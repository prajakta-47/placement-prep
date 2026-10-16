using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace PlacementPrep.Helpers
{
    public class StudentKpiSummary
    {
        public int TotalStudents { get; set; }
        public int EligibleCount { get; set; }
        public int PlacedCount { get; set; }
        public int ProfilesIncomplete { get; set; }
    }

    public class StudentSearchResult
    {
        public List<StudentItem> Items { get; set; }
        public int TotalCount { get; set; }
        public int PageIndex { get; set; }
        public int PageSize { get; set; }
        public int TotalPages { get; set; }
    }

    public class StudentRepository
    {
        private static readonly object SyncLock = new object();
        private static List<StudentItem> _students;
        private static int _nextId = 100;

        static StudentRepository()
        {
            SeedSampleStudents();
        }

        public StudentKpiSummary GetKpiSummary()
        {
            lock (SyncLock)
            {
                // Realistic illustrative sample data aligned with specification
                return new StudentKpiSummary
                {
                    TotalStudents = 8192,
                    EligibleCount = 6480,
                    PlacedCount = 1240,
                    ProfilesIncomplete = 472
                };
            }
        }

        public List<string> GetDepartments()
        {
            lock (SyncLock)
            {
                return _students
                    .Select(s => s.Department)
                    .Where(d => !string.IsNullOrWhiteSpace(d))
                    .Distinct(StringComparer.OrdinalIgnoreCase)
                    .OrderBy(d => d)
                    .ToList();
            }
        }

        public List<int> GetGraduationYears()
        {
            lock (SyncLock)
            {
                return _students
                    .Select(s => s.GraduationYear)
                    .Where(y => y > 0)
                    .Distinct()
                    .OrderBy(y => y)
                    .ToList();
            }
        }

        public bool EnrollmentIdExists(string enrollmentId, int? excludeStudentId)
        {
            if (string.IsNullOrWhiteSpace(enrollmentId)) return false;

            lock (SyncLock)
            {
                return _students.Any(s =>
                    string.Equals(s.EnrollmentId, enrollmentId.Trim(), StringComparison.OrdinalIgnoreCase) &&
                    (!excludeStudentId.HasValue || s.StudentId != excludeStudentId.Value));
            }
        }

        public bool EmailExists(string email, int? excludeStudentId)
        {
            if (string.IsNullOrWhiteSpace(email)) return false;

            lock (SyncLock)
            {
                return _students.Any(s =>
                    string.Equals(s.Email, email.Trim(), StringComparison.OrdinalIgnoreCase) &&
                    (!excludeStudentId.HasValue || s.StudentId != excludeStudentId.Value));
            }
        }

        public StudentSearchResult SearchStudents(string query, string department, string gradYear, string eligibility, string placementStatus, int pageIndex, int pageSize)
        {
            lock (SyncLock)
            {
                var filtered = _students.AsEnumerable();

                if (!string.IsNullOrWhiteSpace(query))
                {
                    var q = query.Trim();
                    filtered = filtered.Where(x =>
                        (x.FullName != null && x.FullName.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (x.EnrollmentId != null && x.EnrollmentId.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (x.Email != null && x.Email.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (x.CompanyPlaced != null && x.CompanyPlaced.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0));
                }

                if (!string.IsNullOrEmpty(department) && !string.Equals(department, "All", StringComparison.OrdinalIgnoreCase))
                {
                    filtered = filtered.Where(x => string.Equals(x.Department, department, StringComparison.OrdinalIgnoreCase));
                }

                int yearVal;
                if (!string.IsNullOrEmpty(gradYear) && !string.Equals(gradYear, "All", StringComparison.OrdinalIgnoreCase) && int.TryParse(gradYear, out yearVal))
                {
                    filtered = filtered.Where(x => x.GraduationYear == yearVal);
                }

                if (!string.IsNullOrEmpty(eligibility) && !string.Equals(eligibility, "All", StringComparison.OrdinalIgnoreCase))
                {
                    filtered = filtered.Where(x => string.Equals(x.PlacementEligibility, eligibility, StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrEmpty(placementStatus) && !string.Equals(placementStatus, "All", StringComparison.OrdinalIgnoreCase))
                {
                    filtered = filtered.Where(x => string.Equals(x.PlacementStatus, placementStatus, StringComparison.OrdinalIgnoreCase));
                }

                var list = filtered.OrderByDescending(x => x.StudentId).ToList();
                var totalCount = list.Count;
                var safePageSize = Math.Max(1, pageSize);
                var totalPages = Math.Max(1, (int)Math.Ceiling(totalCount / (double)safePageSize));
                var safePageIndex = Math.Max(1, Math.Min(pageIndex, totalPages));

                var paged = list
                    .Skip((safePageIndex - 1) * safePageSize)
                    .Take(safePageSize)
                    .ToList();

                return new StudentSearchResult
                {
                    Items = paged,
                    TotalCount = totalCount,
                    PageIndex = safePageIndex,
                    PageSize = safePageSize,
                    TotalPages = totalPages
                };
            }
        }

        public StudentItem GetById(int studentId)
        {
            lock (SyncLock)
            {
                return _students.FirstOrDefault(s => s.StudentId == studentId);
            }
        }

        public List<StudentItem> GetAllStudents()
        {
            lock (SyncLock)
            {
                return _students.ToList();
            }
        }

        public void CreateStudent(StudentItem student)
        {
            if (student == null) throw new ArgumentNullException(nameof(student));

            lock (SyncLock)
            {
                _nextId++;
                student.StudentId = _nextId;
                if (string.IsNullOrWhiteSpace(student.AvatarClass))
                {
                    var avatars = new[] { "users-avatar avatar-blue", "users-avatar avatar-mint", "users-avatar avatar-teal", "users-avatar avatar-purple" };
                    student.AvatarClass = avatars[student.StudentId % avatars.Length];
                }
                student.CreatedAt = DateTime.UtcNow;
                student.UpdatedAt = DateTime.UtcNow;
                _students.Insert(0, student);
            }
        }

        public void UpdateStudent(StudentItem student)
        {
            if (student == null) throw new ArgumentNullException(nameof(student));

            lock (SyncLock)
            {
                var existing = _students.FirstOrDefault(s => s.StudentId == student.StudentId);
                if (existing == null)
                {
                    throw new InvalidOperationException("Student record not found.");
                }

                existing.FullName = student.FullName;
                existing.EnrollmentId = student.EnrollmentId;
                existing.Email = student.Email;
                existing.Department = student.Department;
                existing.GraduationYear = student.GraduationYear;
                existing.Cgpa = student.Cgpa;
                existing.PlacementEligibility = student.PlacementEligibility;
                existing.PlacementStatus = student.PlacementStatus;
                existing.CompanyPlaced = student.CompanyPlaced;
                existing.PackageLpa = student.PackageLpa;
                existing.TechnicalSkills = student.TechnicalSkills;
                existing.UpdatedAt = DateTime.UtcNow;
            }
        }

        public void ToggleEligibility(int studentId)
        {
            lock (SyncLock)
            {
                var existing = _students.FirstOrDefault(s => s.StudentId == studentId);
                if (existing != null)
                {
                    existing.PlacementEligibility = string.Equals(existing.PlacementEligibility, "Eligible", StringComparison.OrdinalIgnoreCase)
                        ? "Ineligible"
                        : "Eligible";
                    existing.UpdatedAt = DateTime.UtcNow;
                }
            }
        }

        public void DeleteStudent(int studentId)
        {
            lock (SyncLock)
            {
                var existing = _students.FirstOrDefault(s => s.StudentId == studentId);
                if (existing != null)
                {
                    _students.Remove(existing);
                }
            }
        }

        private static void SeedSampleStudents()
        {
            _students = new List<StudentItem>
            {
                new StudentItem
                {
                    StudentId = 1,
                    FullName = "Rahul Sharma",
                    EnrollmentId = "EN-2022-CS041",
                    Email = "rahul.s@student.univ.edu",
                    Department = "Computer Science",
                    GraduationYear = 2025,
                    Cgpa = 8.85,
                    PlacementEligibility = "Eligible",
                    PlacementStatus = "Placed",
                    CompanyPlaced = "Amazon",
                    PackageLpa = 18.0,
                    TechnicalSkills = "Data Structures, Python, AWS, React, PostgreSQL",
                    ResumeStatus = "Parsed & ATS Verified",
                    AtsScore = 92,
                    ReadinessScore = 88,
                    AssessmentsCompleted = 18,
                    InterviewCount = 4,
                    ActiveApplications = "Amazon (Offer Accepted), Cisco (Withdrawn)",
                    GithubProfile = "github.com/rahul-sharma-cs",
                    LinkedinProfile = "linkedin.com/in/rahulsharma-tech",
                    AvatarClass = "users-avatar avatar-blue",
                    CreatedAt = DateTime.UtcNow.AddDays(-180),
                    UpdatedAt = DateTime.UtcNow.AddDays(-5)
                },
                new StudentItem
                {
                    StudentId = 2,
                    FullName = "Priya Patel",
                    EnrollmentId = "EN-2022-IT019",
                    Email = "p.patel@student.univ.edu",
                    Department = "Information Technology",
                    GraduationYear = 2025,
                    Cgpa = 9.12,
                    PlacementEligibility = "Eligible",
                    PlacementStatus = "Placed",
                    CompanyPlaced = "Microsoft",
                    PackageLpa = 24.0,
                    TechnicalSkills = "C++, System Design, Azure, Microservices, Java",
                    ResumeStatus = "Parsed & ATS Verified",
                    AtsScore = 95,
                    ReadinessScore = 94,
                    AssessmentsCompleted = 22,
                    InterviewCount = 5,
                    ActiveApplications = "Microsoft (Offer Accepted)",
                    GithubProfile = "github.com/priyapatel-it",
                    LinkedinProfile = "linkedin.com/in/priyapatel-tech",
                    AvatarClass = "users-avatar avatar-purple",
                    CreatedAt = DateTime.UtcNow.AddDays(-160),
                    UpdatedAt = DateTime.UtcNow.AddDays(-3)
                },
                new StudentItem
                {
                    StudentId = 3,
                    FullName = "Ananya Rao",
                    EnrollmentId = "EN-2022-EC008",
                    Email = "ananya.r@student.univ.edu",
                    Department = "Electronics & Comm",
                    GraduationYear = 2025,
                    Cgpa = 8.42,
                    PlacementEligibility = "Eligible",
                    PlacementStatus = "In Process",
                    CompanyPlaced = null,
                    PackageLpa = null,
                    TechnicalSkills = "Embedded C, Verilog, Python, Computer Networks",
                    ResumeStatus = "Parsed & ATS Verified",
                    AtsScore = 84,
                    ReadinessScore = 82,
                    AssessmentsCompleted = 14,
                    InterviewCount = 2,
                    ActiveApplications = "Cisco (Round 2 Scheduled), Qualcomm (Shortlisted)",
                    GithubProfile = "github.com/ananyarao-ece",
                    LinkedinProfile = "linkedin.com/in/ananya-rao-ec",
                    AvatarClass = "users-avatar avatar-mint",
                    CreatedAt = DateTime.UtcNow.AddDays(-140),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                },
                new StudentItem
                {
                    StudentId = 4,
                    FullName = "Rohan Verma",
                    EnrollmentId = "EN-2022-CS082",
                    Email = "rohan.v@student.univ.edu",
                    Department = "Computer Science",
                    GraduationYear = 2025,
                    Cgpa = 7.65,
                    PlacementEligibility = "Eligible",
                    PlacementStatus = "In Process",
                    CompanyPlaced = null,
                    PackageLpa = null,
                    TechnicalSkills = "Java, Spring Boot, MySQL, HTML/CSS, Git",
                    ResumeStatus = "Parsed & ATS Verified",
                    AtsScore = 78,
                    ReadinessScore = 75,
                    AssessmentsCompleted = 12,
                    InterviewCount = 1,
                    ActiveApplications = "TCS (Awaiting Interview), Wipro (Written Cleared)",
                    GithubProfile = "github.com/rohanverma-dev",
                    LinkedinProfile = "linkedin.com/in/rohanverma-cs",
                    AvatarClass = "users-avatar avatar-teal",
                    CreatedAt = DateTime.UtcNow.AddDays(-120),
                    UpdatedAt = DateTime.UtcNow.AddDays(-4)
                },
                new StudentItem
                {
                    StudentId = 5,
                    FullName = "Sneha Kulkarni",
                    EnrollmentId = "EN-2023-IT033",
                    Email = "sneha.k@student.univ.edu",
                    Department = "Information Technology",
                    GraduationYear = 2026,
                    Cgpa = 8.90,
                    PlacementEligibility = "Eligible",
                    PlacementStatus = "In Process",
                    CompanyPlaced = null,
                    PackageLpa = null,
                    TechnicalSkills = "Python, Machine Learning, Scikit-learn, SQL, Docker",
                    ResumeStatus = "Parsed & ATS Verified",
                    AtsScore = 89,
                    ReadinessScore = 87,
                    AssessmentsCompleted = 16,
                    InterviewCount = 2,
                    ActiveApplications = "Infosys (Shortlisted), Capgemini (Applied)",
                    GithubProfile = "github.com/snehakulkarni-ml",
                    LinkedinProfile = "linkedin.com/in/snehakulkarni-it",
                    AvatarClass = "users-avatar avatar-purple",
                    CreatedAt = DateTime.UtcNow.AddDays(-100),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                },
                new StudentItem
                {
                    StudentId = 6,
                    FullName = "Aditya Mehta",
                    EnrollmentId = "EN-2022-ME015",
                    Email = "aditya.m@student.univ.edu",
                    Department = "Mechanical",
                    GraduationYear = 2025,
                    Cgpa = 6.40,
                    PlacementEligibility = "Ineligible",
                    PlacementStatus = "Unplaced",
                    CompanyPlaced = null,
                    PackageLpa = null,
                    TechnicalSkills = "AutoCAD, SolidWorks, C Basics, MATLAB",
                    ResumeStatus = "Review Needed",
                    AtsScore = 58,
                    ReadinessScore = 52,
                    AssessmentsCompleted = 6,
                    InterviewCount = 0,
                    ActiveApplications = "Requires CGPA Remediation module (&lt; 6.5 cutoff)",
                    GithubProfile = null,
                    LinkedinProfile = "linkedin.com/in/adityamehta-mech",
                    AvatarClass = "users-avatar avatar-slate",
                    CreatedAt = DateTime.UtcNow.AddDays(-90),
                    UpdatedAt = DateTime.UtcNow.AddDays(-8)
                },
                new StudentItem
                {
                    StudentId = 7,
                    FullName = "Neha Gupta",
                    EnrollmentId = "EN-2022-CS114",
                    Email = "neha.g@student.univ.edu",
                    Department = "Computer Science",
                    GraduationYear = 2025,
                    Cgpa = 8.15,
                    PlacementEligibility = "Eligible",
                    PlacementStatus = "Placed",
                    CompanyPlaced = "Goldman Sachs",
                    PackageLpa = 22.0,
                    TechnicalSkills = "Algorithms, Java, Financial Algorithms, Spring, SQL",
                    ResumeStatus = "Parsed & ATS Verified",
                    AtsScore = 91,
                    ReadinessScore = 90,
                    AssessmentsCompleted = 20,
                    InterviewCount = 3,
                    ActiveApplications = "Goldman Sachs (Offer Accepted)",
                    GithubProfile = "github.com/nehagupta-cs",
                    LinkedinProfile = "linkedin.com/in/nehagupta-tech",
                    AvatarClass = "users-avatar avatar-mint",
                    CreatedAt = DateTime.UtcNow.AddDays(-80),
                    UpdatedAt = DateTime.UtcNow.AddDays(-6)
                },
                new StudentItem
                {
                    StudentId = 8,
                    FullName = "Vikram Joshi",
                    EnrollmentId = "EN-2023-EC047",
                    Email = "vikram.j@student.univ.edu",
                    Department = "Electronics & Comm",
                    GraduationYear = 2026,
                    Cgpa = 7.20,
                    PlacementEligibility = "Eligible",
                    PlacementStatus = "Unplaced",
                    CompanyPlaced = null,
                    PackageLpa = null,
                    TechnicalSkills = "IoT, C++, Arduino, Signal Processing, Python",
                    ResumeStatus = "Parsed & ATS Verified",
                    AtsScore = 72,
                    ReadinessScore = 69,
                    AssessmentsCompleted = 9,
                    InterviewCount = 0,
                    ActiveApplications = "No active placement drive applications",
                    GithubProfile = "github.com/vikramjoshi-ec",
                    LinkedinProfile = "linkedin.com/in/vikramjoshi-ece",
                    AvatarClass = "users-avatar avatar-blue",
                    CreatedAt = DateTime.UtcNow.AddDays(-70),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                },
                new StudentItem
                {
                    StudentId = 9,
                    FullName = "Divya Nair",
                    EnrollmentId = "EN-2022-CS003",
                    Email = "divya.n@student.univ.edu",
                    Department = "Computer Science",
                    GraduationYear = 2025,
                    Cgpa = 9.45,
                    PlacementEligibility = "Eligible",
                    PlacementStatus = "Placed",
                    CompanyPlaced = "Google",
                    PackageLpa = 32.0,
                    TechnicalSkills = "Distributed Systems, Go, C++, Linux Kernel, Algorithms",
                    ResumeStatus = "Parsed & ATS Verified",
                    AtsScore = 98,
                    ReadinessScore = 97,
                    AssessmentsCompleted = 25,
                    InterviewCount = 5,
                    ActiveApplications = "Google (Offer Accepted)",
                    GithubProfile = "github.com/divyanair-core",
                    LinkedinProfile = "linkedin.com/in/divyanair-swe",
                    AvatarClass = "users-avatar avatar-teal",
                    CreatedAt = DateTime.UtcNow.AddDays(-60),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                },
                new StudentItem
                {
                    StudentId = 10,
                    FullName = "Arjun Das",
                    EnrollmentId = "EN-2022-IT088",
                    Email = "arjun.d@student.univ.edu",
                    Department = "Information Technology",
                    GraduationYear = 2025,
                    Cgpa = 6.10,
                    PlacementEligibility = "Ineligible",
                    PlacementStatus = "Unplaced",
                    CompanyPlaced = null,
                    PackageLpa = null,
                    TechnicalSkills = "HTML, CSS, JavaScript, Basic PHP",
                    ResumeStatus = "Review Needed",
                    AtsScore = 54,
                    ReadinessScore = 49,
                    AssessmentsCompleted = 5,
                    InterviewCount = 0,
                    ActiveApplications = "Ineligible: minimum CGPA benchmark is 6.50",
                    GithubProfile = null,
                    LinkedinProfile = null,
                    AvatarClass = "users-avatar avatar-slate",
                    CreatedAt = DateTime.UtcNow.AddDays(-50),
                    UpdatedAt = DateTime.UtcNow.AddDays(-10)
                },
                new StudentItem
                {
                    StudentId = 11,
                    FullName = "Pooja Reddy",
                    EnrollmentId = "EN-2022-EC062",
                    Email = "pooja.r@student.univ.edu",
                    Department = "Electronics & Comm",
                    GraduationYear = 2025,
                    Cgpa = 7.95,
                    PlacementEligibility = "Eligible",
                    PlacementStatus = "In Process",
                    CompanyPlaced = null,
                    PackageLpa = null,
                    TechnicalSkills = "Python, Data Analysis, SQL, VLSI Design, Verilog",
                    ResumeStatus = "Parsed & ATS Verified",
                    AtsScore = 81,
                    ReadinessScore = 78,
                    AssessmentsCompleted = 13,
                    InterviewCount = 1,
                    ActiveApplications = "Accenture (Interview Scheduled), Wipro (Applied)",
                    GithubProfile = "github.com/poojareddy-ece",
                    LinkedinProfile = "linkedin.com/in/poojareddy-eng",
                    AvatarClass = "users-avatar avatar-purple",
                    CreatedAt = DateTime.UtcNow.AddDays(-40),
                    UpdatedAt = DateTime.UtcNow.AddDays(-3)
                },
                new StudentItem
                {
                    StudentId = 12,
                    FullName = "Karan Malhotra",
                    EnrollmentId = "EN-2023-CS055",
                    Email = "karan.m@student.univ.edu",
                    Department = "Computer Science",
                    GraduationYear = 2026,
                    Cgpa = 8.30,
                    PlacementEligibility = "Pending Review",
                    PlacementStatus = "Unplaced",
                    CompanyPlaced = null,
                    PackageLpa = null,
                    TechnicalSkills = "React Native, Mobile Dev, Node.js, MongoDB, Java",
                    ResumeStatus = "Review Needed",
                    AtsScore = 75,
                    ReadinessScore = 74,
                    AssessmentsCompleted = 8,
                    InterviewCount = 0,
                    ActiveApplications = "Awaiting Placement Cell verification of 6th Sem marksheet",
                    GithubProfile = "github.com/karanmalhotra-dev",
                    LinkedinProfile = "linkedin.com/in/karanmalhotra-cs",
                    AvatarClass = "users-avatar avatar-blue",
                    CreatedAt = DateTime.UtcNow.AddDays(-30),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                }
            };

            foreach (var s in _students)
            {
                if (s.Applications == null) s.Applications = new List<StudentApplicationRecord>();
                if (s.Applications.Count == 0)
                {
                    if (string.Equals(s.PlacementStatus, "Placed", StringComparison.OrdinalIgnoreCase) && !string.IsNullOrWhiteSpace(s.CompanyPlaced))
                    {
                        s.Applications.Add(new StudentApplicationRecord
                        {
                            CompanyName = s.CompanyPlaced,
                            JobRole = s.CompanyPlaced == "Google" ? "Software Development Engineer - I" :
                                      s.CompanyPlaced == "Microsoft" ? "Cloud Solution Engineer" :
                                      s.CompanyPlaced == "Goldman Sachs" ? "Quantitative Analyst" :
                                      s.CompanyPlaced == "Amazon" ? "Graduate Software Developer" : "Associate Consultant",
                            RecruitmentStage = "Final Offer Extended",
                            ApplicationStatus = "Offered",
                            OfferPackageLpa = s.PackageLpa,
                            AppliedDate = s.CreatedAt.ToString("MMM dd, yyyy")
                        });
                        s.Applications.Add(new StudentApplicationRecord
                        {
                            CompanyName = "Tata Consultancy Services",
                            JobRole = "Digital Systems Specialist",
                            RecruitmentStage = "Technical Interview 2",
                            ApplicationStatus = "Shortlisted",
                            OfferPackageLpa = null,
                            AppliedDate = s.CreatedAt.AddDays(5).ToString("MMM dd, yyyy")
                        });
                    }
                    else if (string.Equals(s.PlacementStatus, "In Process", StringComparison.OrdinalIgnoreCase))
                    {
                        s.Applications.Add(new StudentApplicationRecord
                        {
                            CompanyName = "Google",
                            JobRole = "Software Development Engineer - I",
                            RecruitmentStage = "Technical Interview 1 (DSA)",
                            ApplicationStatus = "In Process",
                            OfferPackageLpa = null,
                            AppliedDate = DateTime.UtcNow.AddDays(-10).ToString("MMM dd, yyyy")
                        });
                        s.Applications.Add(new StudentApplicationRecord
                        {
                            CompanyName = "Cisco Systems",
                            JobRole = "Embedded Systems Engineer",
                            RecruitmentStage = "Online Assessment Cleared",
                            ApplicationStatus = "Shortlisted",
                            OfferPackageLpa = null,
                            AppliedDate = DateTime.UtcNow.AddDays(-14).ToString("MMM dd, yyyy")
                        });
                    }
                    else if (string.Equals(s.PlacementEligibility, "Ineligible", StringComparison.OrdinalIgnoreCase))
                    {
                        s.Applications.Add(new StudentApplicationRecord
                        {
                            CompanyName = "Placement Cell Audit",
                            JobRole = "Eligibility Audit Flagged",
                            RecruitmentStage = "Academic Verification",
                            ApplicationStatus = "Rejected",
                            OfferPackageLpa = null,
                            AppliedDate = DateTime.UtcNow.AddDays(-30).ToString("MMM dd, yyyy")
                        });
                    }
                    else
                    {
                        s.Applications.Add(new StudentApplicationRecord
                        {
                            CompanyName = "Microsoft",
                            JobRole = "Cloud Solution Engineer",
                            RecruitmentStage = "Resume Screening",
                            ApplicationStatus = "Applied",
                            OfferPackageLpa = null,
                            AppliedDate = DateTime.UtcNow.AddDays(-5).ToString("MMM dd, yyyy")
                        });
                    }
                }
            }
        }
    }
}
