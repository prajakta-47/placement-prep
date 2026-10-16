using System;
using System.Collections.Generic;
using System.Linq;

namespace PlacementPrep.Helpers
{
    public class DriveKpiSummary
    {
        public int TotalDrives { get; set; }
        public int OpenDrivesCount { get; set; }
        public int UpcomingDrivesCount { get; set; }
        public int TotalOpeningsCount { get; set; }
    }

    public class DriveSearchResult
    {
        public List<PlacementDriveItem> Items { get; set; }
        public int TotalCount { get; set; }
        public int PageIndex { get; set; }
        public int PageSize { get; set; }
        public int TotalPages { get; set; }
    }

    public class PlacementDriveRepository
    {
        private static readonly object SyncLock = new object();
        private static List<PlacementDriveItem> _drives;
        private static int _nextId = 100;

        static PlacementDriveRepository()
        {
            SeedSampleDrives();
        }

        public DriveKpiSummary GetKpiSummary()
        {
            lock (SyncLock)
            {
                return new DriveKpiSummary
                {
                    TotalDrives = _drives.Count,
                    OpenDrivesCount = _drives.Count(d => string.Equals(d.DriveStatus, "Open", StringComparison.OrdinalIgnoreCase)),
                    UpcomingDrivesCount = _drives.Count(d => string.Equals(d.DriveStatus, "Upcoming", StringComparison.OrdinalIgnoreCase)),
                    TotalOpeningsCount = _drives.Sum(d => d.Openings)
                };
            }
        }

        public List<string> GetStatuses()
        {
            return new List<string>
            {
                "Open",
                "Upcoming",
                "Closed",
                "Completed",
                "Draft"
            };
        }

        public DriveSearchResult Search(string query, string company, string status, string department, int pageIndex, int pageSize)
        {
            lock (SyncLock)
            {
                var q = _drives.AsQueryable();

                if (!string.IsNullOrWhiteSpace(query))
                {
                    var term = query.Trim();
                    q = q.Where(d =>
                        (d.CompanyName != null && d.CompanyName.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (d.JobRole != null && d.JobRole.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (d.DriveCode != null && d.DriveCode.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (d.WorkLocation != null && d.WorkLocation.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0));
                }

                if (!string.IsNullOrWhiteSpace(company) && !string.Equals(company, "All", StringComparison.OrdinalIgnoreCase))
                {
                    q = q.Where(d => string.Equals(d.CompanyName, company.Trim(), StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrWhiteSpace(status) && !string.Equals(status, "All", StringComparison.OrdinalIgnoreCase))
                {
                    q = q.Where(d => string.Equals(d.DriveStatus, status.Trim(), StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrWhiteSpace(department) && !string.Equals(department, "All", StringComparison.OrdinalIgnoreCase))
                {
                    q = q.Where(d => d.EligibleDepartments != null && d.EligibleDepartments.IndexOf(department.Trim(), StringComparison.OrdinalIgnoreCase) >= 0);
                }

                var list = q.OrderByDescending(d => d.DriveDate).ToList();

                var total = list.Count;
                var totalPages = (int)Math.Ceiling((double)total / pageSize);
                if (totalPages == 0) totalPages = 1;
                if (pageIndex < 1) pageIndex = 1;
                if (pageIndex > totalPages) pageIndex = totalPages;

                var pageItems = list.Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList();

                return new DriveSearchResult
                {
                    Items = pageItems,
                    TotalCount = total,
                    PageIndex = pageIndex,
                    PageSize = pageSize,
                    TotalPages = totalPages
                };
            }
        }

        public PlacementDriveItem GetById(int driveId)
        {
            lock (SyncLock)
            {
                var original = _drives.FirstOrDefault(d => d.DriveId == driveId);
                return original == null ? null : CloneDrive(original);
            }
        }

        public List<PlacementDriveItem> GetByCompanyId(int companyId)
        {
            lock (SyncLock)
            {
                return _drives.Where(d => d.CompanyId == companyId)
                              .OrderByDescending(d => d.DriveDate)
                              .Select(CloneDrive)
                              .ToList();
            }
        }

        public List<PlacementDriveItem> GetByCompanyName(string companyName)
        {
            if (string.IsNullOrWhiteSpace(companyName)) return new List<PlacementDriveItem>();
            lock (SyncLock)
            {
                return _drives.Where(d => string.Equals(d.CompanyName, companyName.Trim(), StringComparison.OrdinalIgnoreCase))
                              .OrderByDescending(d => d.DriveDate)
                              .Select(CloneDrive)
                              .ToList();
            }
        }

        public bool Add(PlacementDriveItem item, out string error)
        {
            error = null;
            if (item == null)
            {
                error = "Drive payload is required.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(item.CompanyName))
            {
                error = "Sponsoring company is required.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(item.JobRole))
            {
                error = "Job role is required.";
                return false;
            }

            if (item.ApplicationDeadline > item.DriveDate)
            {
                error = "Application deadline cannot be later than the drive execution date.";
                return false;
            }

            if (item.Openings <= 0)
            {
                error = "Openings count must be a positive integer.";
                return false;
            }

            if (item.MinCgpa < 0 || item.MinCgpa > 10.0)
            {
                error = "Minimum CGPA must be between 0.00 and 10.00.";
                return false;
            }

            lock (SyncLock)
            {
                item.DriveId = ++_nextId;
                if (string.IsNullOrWhiteSpace(item.DriveCode))
                {
                    item.DriveCode = string.Format("DRV-{0}-{1:D3}", DateTime.UtcNow.Year, item.DriveId);
                }
                item.CreatedAt = DateTime.UtcNow;
                item.UpdatedAt = DateTime.UtcNow;

                _drives.Add(CloneDrive(item));
                return true;
            }
        }

        public bool Update(PlacementDriveItem item, out string error)
        {
            error = null;
            if (item == null)
            {
                error = "Drive payload is required.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(item.CompanyName))
            {
                error = "Sponsoring company is required.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(item.JobRole))
            {
                error = "Job role is required.";
                return false;
            }

            if (item.ApplicationDeadline > item.DriveDate)
            {
                error = "Application deadline cannot be later than the drive execution date.";
                return false;
            }

            if (item.Openings <= 0)
            {
                error = "Openings count must be a positive integer.";
                return false;
            }

            if (item.MinCgpa < 0 || item.MinCgpa > 10.0)
            {
                error = "Minimum CGPA must be between 0.00 and 10.00.";
                return false;
            }

            lock (SyncLock)
            {
                var existing = _drives.FirstOrDefault(d => d.DriveId == item.DriveId);
                if (existing == null)
                {
                    error = "Placement drive record not found.";
                    return false;
                }

                existing.CompanyId = item.CompanyId;
                existing.CompanyName = item.CompanyName.Trim();
                existing.JobRole = item.JobRole.Trim();
                existing.JobDescription = item.JobDescription;
                existing.DriveDate = item.DriveDate;
                existing.ApplicationDeadline = item.ApplicationDeadline;
                existing.EligibleDepartments = item.EligibleDepartments;
                existing.GraduationBatch = item.GraduationBatch;
                existing.MinCgpa = item.MinCgpa;
                existing.PackageMinLpa = item.PackageMinLpa;
                existing.PackageMaxLpa = item.PackageMaxLpa;
                existing.Openings = item.Openings;
                existing.DriveStatus = item.DriveStatus;
                existing.RecruitmentStages = item.RecruitmentStages;
                existing.WorkLocation = item.WorkLocation;
                existing.BondDetails = item.BondDetails;
                existing.UpdatedAt = DateTime.UtcNow;

                return true;
            }
        }

        public bool Delete(int driveId, out string error)
        {
            error = null;
            lock (SyncLock)
            {
                var existing = _drives.FirstOrDefault(d => d.DriveId == driveId);
                if (existing == null)
                {
                    error = "Placement drive not found.";
                    return false;
                }

                _drives.Remove(existing);
                return true;
            }
        }

        public bool ToggleStatus(int driveId)
        {
            lock (SyncLock)
            {
                var existing = _drives.FirstOrDefault(d => d.DriveId == driveId);
                if (existing == null) return false;

                if (string.Equals(existing.DriveStatus, "Open", StringComparison.OrdinalIgnoreCase))
                {
                    existing.DriveStatus = "Closed";
                }
                else
                {
                    existing.DriveStatus = "Open";
                }

                existing.UpdatedAt = DateTime.UtcNow;
                return true;
            }
        }

        /// <summary>
        /// Evaluates sample students from the student repository against this drive's eligibility rules.
        /// Demonstrates live candidate qualification metrics.
        /// </summary>
        public List<DriveCandidateEvaluation> EvaluateCandidates(int driveId, List<StudentItem> students)
        {
            var drive = GetById(driveId);
            if (drive == null || students == null) return new List<DriveCandidateEvaluation>();

            var eligibleDepts = (drive.EligibleDepartments ?? string.Empty)
                .Split(new[] { ',', ';' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(d => d.Trim().ToLowerInvariant())
                .ToList();

            var evaluations = new List<DriveCandidateEvaluation>();

            foreach (var s in students)
            {
                var reasons = new List<string>();
                bool eligible = true;

                // 1. CGPA check
                if (s.Cgpa < drive.MinCgpa)
                {
                    eligible = false;
                    reasons.Add(string.Format("CGPA {0:F2} is below required {1:F2}", s.Cgpa, drive.MinCgpa));
                }

                // 2. Department check
                if (eligibleDepts.Count > 0)
                {
                    var sDept = (s.Department ?? string.Empty).Trim().ToLowerInvariant();
                    bool deptMatches = eligibleDepts.Any(ed => sDept.Contains(ed) || ed.Contains(sDept));
                    if (!deptMatches)
                    {
                        eligible = false;
                        reasons.Add(string.Format("Dept '{0}' not in eligible streams", s.Department));
                    }
                }

                // 3. Batch check
                if (drive.GraduationBatch > 0 && s.GraduationYear != drive.GraduationBatch)
                {
                    eligible = false;
                    reasons.Add(string.Format("Batch {0} does not match target {1}", s.GraduationYear, drive.GraduationBatch));
                }

                // Determine simulation application stage
                string stage = "Not Applied";
                if (eligible)
                {
                    if (s.Cgpa >= 9.0)
                    {
                        stage = "Technical Round 2";
                    }
                    else if (s.Cgpa >= 8.0)
                    {
                        stage = "Online Assessment Cleared";
                    }
                    else
                    {
                        stage = "Application Submitted";
                    }
                }

                evaluations.Add(new DriveCandidateEvaluation
                {
                    StudentId = s.StudentId,
                    FullName = s.FullName,
                    EnrollmentId = s.EnrollmentId,
                    Email = s.Email,
                    Department = s.Department,
                    GraduationYear = s.GraduationYear,
                    Cgpa = s.Cgpa,
                    IsEligible = eligible,
                    EligibilityReason = eligible
                        ? string.Format("Eligible: CGPA {0:F2} meets cutoff ({1:F2}+), Dept & Batch matched", s.Cgpa, drive.MinCgpa)
                        : string.Join("; ", reasons),
                    ApplicationStage = stage,
                    AvatarClass = s.AvatarClass,
                    Initials = s.Initials
                });
            }

            return evaluations.OrderByDescending(e => e.IsEligible)
                              .ThenByDescending(e => e.Cgpa)
                              .ToList();
        }

        private static PlacementDriveItem CloneDrive(PlacementDriveItem d)
        {
            return new PlacementDriveItem
            {
                DriveId = d.DriveId,
                DriveCode = d.DriveCode,
                CompanyId = d.CompanyId,
                CompanyName = d.CompanyName,
                JobRole = d.JobRole,
                JobDescription = d.JobDescription,
                DriveDate = d.DriveDate,
                ApplicationDeadline = d.ApplicationDeadline,
                EligibleDepartments = d.EligibleDepartments,
                GraduationBatch = d.GraduationBatch,
                MinCgpa = d.MinCgpa,
                PackageMinLpa = d.PackageMinLpa,
                PackageMaxLpa = d.PackageMaxLpa,
                Openings = d.Openings,
                DriveStatus = d.DriveStatus,
                RecruitmentStages = d.RecruitmentStages,
                ApplicantCount = d.ApplicantCount,
                ShortlistedCount = d.ShortlistedCount,
                OfferedCount = d.OfferedCount,
                WorkLocation = d.WorkLocation,
                BondDetails = d.BondDetails,
                CreatedAt = d.CreatedAt,
                UpdatedAt = d.UpdatedAt
            };
        }

        private static void SeedSampleDrives()
        {
            _drives = new List<PlacementDriveItem>
            {
                new PlacementDriveItem
                {
                    DriveId = 1,
                    DriveCode = "DRV-2025-001",
                    CompanyId = 1,
                    CompanyName = "Google",
                    JobRole = "Software Development Engineer - I",
                    JobDescription = "Design, build, test, and deploy large-scale distributed systems and core cloud infrastructure algorithms.",
                    DriveDate = DateTime.UtcNow.AddDays(14),
                    ApplicationDeadline = DateTime.UtcNow.AddDays(7),
                    EligibleDepartments = "Computer Science, Information Technology",
                    GraduationBatch = 2025,
                    MinCgpa = 8.00,
                    PackageMinLpa = 30.0,
                    PackageMaxLpa = 36.0,
                    Openings = 12,
                    DriveStatus = "Open",
                    RecruitmentStages = "Online Coding Assessment, Technical Interview 1 (DSA), Technical Interview 2 (Systems), Googliness & Leadership",
                    ApplicantCount = 148,
                    ShortlistedCount = 36,
                    OfferedCount = 0,
                    WorkLocation = "Bangalore, Hyderabad",
                    BondDetails = "No Service Bond",
                    CreatedAt = DateTime.UtcNow.AddDays(-20),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                },
                new PlacementDriveItem
                {
                    DriveId = 2,
                    DriveCode = "DRV-2025-002",
                    CompanyId = 2,
                    CompanyName = "Microsoft",
                    JobRole = "Cloud Solution Engineer",
                    JobDescription = "Architect modern enterprise cloud workflows on Azure with high availability, microservices, and observability.",
                    DriveDate = DateTime.UtcNow.AddDays(21),
                    ApplicationDeadline = DateTime.UtcNow.AddDays(10),
                    EligibleDepartments = "Computer Science, Information Technology, Electronics & Comm",
                    GraduationBatch = 2025,
                    MinCgpa = 7.50,
                    PackageMinLpa = 24.0,
                    PackageMaxLpa = 28.0,
                    Openings = 18,
                    DriveStatus = "Open",
                    RecruitmentStages = "Online MCQ + Coding, System Architecture Round, Behavioral Interview",
                    ApplicantCount = 210,
                    ShortlistedCount = 42,
                    OfferedCount = 0,
                    WorkLocation = "Hyderabad, Bangalore",
                    BondDetails = "No Service Bond",
                    CreatedAt = DateTime.UtcNow.AddDays(-18),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                },
                new PlacementDriveItem
                {
                    DriveId = 3,
                    DriveCode = "DRV-2025-003",
                    CompanyId = 3,
                    CompanyName = "Amazon",
                    JobRole = "Graduate Software Developer (AWS)",
                    JobDescription = "Deliver robust services that power millions of customer orders and critical cloud services with customer obsession.",
                    DriveDate = DateTime.UtcNow.AddDays(28),
                    ApplicationDeadline = DateTime.UtcNow.AddDays(15),
                    EligibleDepartments = "Computer Science, Information Technology",
                    GraduationBatch = 2025,
                    MinCgpa = 7.50,
                    PackageMinLpa = 26.0,
                    PackageMaxLpa = 32.0,
                    Openings = 25,
                    DriveStatus = "Upcoming",
                    RecruitmentStages = "Online Assessment (Debugging & Algorithms), Work Style Assessment, Virtual Technical Rounds (x3)",
                    ApplicantCount = 320,
                    ShortlistedCount = 60,
                    OfferedCount = 0,
                    WorkLocation = "Bangalore, Chennai",
                    BondDetails = "No Service Bond",
                    CreatedAt = DateTime.UtcNow.AddDays(-14),
                    UpdatedAt = DateTime.UtcNow.AddDays(-3)
                },
                new PlacementDriveItem
                {
                    DriveId = 4,
                    DriveCode = "DRV-2025-004",
                    CompanyId = 4,
                    CompanyName = "Goldman Sachs",
                    JobRole = "Quantitative & Systems Analyst",
                    JobDescription = "Develop high-throughput algorithmic trading platforms, quantitative financial risk models, and low-latency infrastructure.",
                    DriveDate = DateTime.UtcNow.AddDays(-10),
                    ApplicationDeadline = DateTime.UtcNow.AddDays(-18),
                    EligibleDepartments = "Computer Science, Information Technology, Electronics & Comm",
                    GraduationBatch = 2025,
                    MinCgpa = 8.00,
                    PackageMinLpa = 22.0,
                    PackageMaxLpa = 26.0,
                    Openings = 10,
                    DriveStatus = "Completed",
                    RecruitmentStages = "Quantitative Aptitude + Coding Test, Technical Interview 1, Technical Interview 2, Partner Round",
                    ApplicantCount = 180,
                    ShortlistedCount = 28,
                    OfferedCount = 8,
                    WorkLocation = "Bangalore",
                    BondDetails = "No Service Bond",
                    CreatedAt = DateTime.UtcNow.AddDays(-40),
                    UpdatedAt = DateTime.UtcNow.AddDays(-5)
                },
                new PlacementDriveItem
                {
                    DriveId = 5,
                    DriveCode = "DRV-2025-005",
                    CompanyId = 5,
                    CompanyName = "Deloitte USI",
                    JobRole = "Technology Advisory Analyst",
                    JobDescription = "Assist multinational clients in digital enterprise software engineering, cyber risk assessment, and ERP implementations.",
                    DriveDate = DateTime.UtcNow.AddDays(35),
                    ApplicationDeadline = DateTime.UtcNow.AddDays(20),
                    EligibleDepartments = "Computer Science, Information Technology, Electronics & Comm, Mechanical",
                    GraduationBatch = 2025,
                    MinCgpa = 6.50,
                    PackageMinLpa = 9.0,
                    PackageMaxLpa = 11.5,
                    Openings = 45,
                    DriveStatus = "Upcoming",
                    RecruitmentStages = "Cognitive Ability Test, Verbal & Technical MCQ, Case Study Presentation, Partner Interview",
                    ApplicantCount = 410,
                    ShortlistedCount = 0,
                    OfferedCount = 0,
                    WorkLocation = "Hyderabad, Bangalore, Mumbai",
                    BondDetails = "1 Year Service Agreement",
                    CreatedAt = DateTime.UtcNow.AddDays(-10),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                },
                new PlacementDriveItem
                {
                    DriveId = 6,
                    DriveCode = "DRV-2025-006",
                    CompanyId = 8,
                    CompanyName = "Cisco Systems",
                    JobRole = "Hardware & Embedded Systems Engineer",
                    JobDescription = "Work with custom ASICs, networking microcode, Ethernet switching protocols, and embedded Linux device drivers.",
                    DriveDate = DateTime.UtcNow.AddDays(18),
                    ApplicationDeadline = DateTime.UtcNow.AddDays(9),
                    EligibleDepartments = "Electronics & Comm, Computer Science",
                    GraduationBatch = 2025,
                    MinCgpa = 7.00,
                    PackageMinLpa = 18.0,
                    PackageMaxLpa = 22.0,
                    Openings = 8,
                    DriveStatus = "Open",
                    RecruitmentStages = "Hardware & DSA Assessment, Circuit & C/C++ Technical Round, Managerial Round",
                    ApplicantCount = 95,
                    ShortlistedCount = 20,
                    OfferedCount = 0,
                    WorkLocation = "Bangalore",
                    BondDetails = "No Service Bond",
                    CreatedAt = DateTime.UtcNow.AddDays(-15),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                }
            };
        }
    }
}
