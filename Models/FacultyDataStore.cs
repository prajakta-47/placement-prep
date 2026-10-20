using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace PlacementPrep.Models
{
    public class StudentModel
    {
        public string RollNo { get; set; }
        public string Name { get; set; }
        public string Department { get; set; }
        public string ClassYear { get; set; }
        public decimal CGPA { get; set; }
        public decimal AvgScore { get; set; }
        public int TestsCompleted { get; set; }
        public string Status { get; set; } // "Strong Fit", "On Track", "Needs Review"
        public string Trend { get; set; } // "+4%", "+2%", "-3%"
        public string Email { get; set; }
        public decimal ReadinessIndex { get; set; }
        public int BatchRank { get; set; }
        public int TotalSolved { get; set; }
        public List<string> Skills { get; set; }
    }

    public class SubjectModel
    {
        public string SubjectCode { get; set; }
        public string SubjectName { get; set; }
        public string Department { get; set; }
        public int Semester { get; set; }
        public int TopicsCount { get; set; }
        public decimal ReadinessRate { get; set; }
        public decimal AIRelevance { get; set; }
        public bool IsActive { get; set; }
    }

    public class CompanyModel
    {
        public string CompanyName { get; set; }
        public string Industry { get; set; }
        public string Role { get; set; }
        public decimal MinCgpa { get; set; }
        public decimal PackageLPA { get; set; }
        public string DriveDate { get; set; }
        public string Status { get; set; } // "Upcoming", "Active", "Completed"
        public int EligibleCount { get; set; }
    }

    public class SystemLogModel
    {
        public string EventId { get; set; }
        public DateTime Timestamp { get; set; }
        public string Actor { get; set; }
        public string Module { get; set; }
        public string EventName { get; set; }
        public string Severity { get; set; } // "Info", "Warning", "Critical"
        public string ActionSynopsis { get; set; }
    }

    public class PlacementDriveModel
    {
        public string DriveId { get; set; }
        public string CompanyName { get; set; }
        public string JobTitle { get; set; }
        public string EventDate { get; set; }
        public string TimeWindow { get; set; }
        public string Location { get; set; }
        public string Status { get; set; } // "Scheduled", "In Progress", "Completed"
        public int RegisteredStudents { get; set; }
        public string EligibleDept { get; set; }
        public decimal MinCgpa { get; set; }
        public string DriveType { get; set; } // "Full Time", "Internship", "Mixed"
        public decimal PackageLPA { get; set; }
        public string Industry { get; set; }
    }

    public class AnnouncementModel
    {
        public string AnnouncementId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public string Priority { get; set; } // "High", "Normal", "Urgent"
        public string TargetCohort { get; set; }
        public DateTime PostedDate { get; set; }
        public string Author { get; set; }
    }

    public class CoordinatorSettingsModel
    {
        public string FullName { get; set; }
        public string Designation { get; set; }
        public string Department { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string OfficeLocation { get; set; }
        public bool DailySummaryEmail { get; set; }
        public bool InstantProctorSms { get; set; }
        public bool WeeklyDigest { get; set; }
        public bool StudentRegistrationAlert { get; set; }
        public string DefaultInferenceModel { get; set; }
        public int BenchmarkPassingCutoff { get; set; }
        public bool DefaultNegativeMarking { get; set; }
        public bool ShuffleQuestions { get; set; }
        public bool TwoFactorAuth { get; set; }
    }

    public static class FacultyDataStore
    {
        private static List<StudentModel> _students;
        private static List<SubjectModel> _subjects;
        private static List<CompanyModel> _companies;
        private static List<SystemLogModel> _logs;
        private static List<PlacementDriveModel> _drives;
        private static List<AnnouncementModel> _announcements;
        private static CoordinatorSettingsModel _settings;
        private static readonly object _lock = new object();

        static FacultyDataStore()
        {
            SeedData();
        }

        public static List<StudentModel> Students => _students;
        public static List<SubjectModel> Subjects => _subjects;
        public static List<CompanyModel> Companies => _companies;
        public static List<SystemLogModel> Logs => _logs;
        public static List<PlacementDriveModel> Drives => _drives;
        public static List<AnnouncementModel> Announcements => _announcements;

        public static CoordinatorSettingsModel GetSettings()
        {
            lock (_lock)
            {
                if (_settings == null)
                {
                    _settings = new CoordinatorSettingsModel
                    {
                        FullName = "Prof. R. Sharma",
                        Designation = "Placement Coordinator & Associate Professor",
                        Department = "Computer Science & Engineering",
                        Email = "r.sharma@campus.edu",
                        Phone = "+91 98765 43210",
                        OfficeLocation = "Block C, Faculty Wing, Room 304",
                        DailySummaryEmail = true,
                        InstantProctorSms = true,
                        WeeklyDigest = true,
                        StudentRegistrationAlert = false,
                        DefaultInferenceModel = "GPT-4 Turbo",
                        BenchmarkPassingCutoff = 65,
                        DefaultNegativeMarking = true,
                        ShuffleQuestions = true,
                        TwoFactorAuth = true
                    };
                }
                return _settings;
            }
        }

        public static void SaveSettings(CoordinatorSettingsModel s)
        {
            lock (_lock)
            {
                _settings = s;
            }
        }

        public static void AddDrive(PlacementDriveModel drive)
        {
            lock (_lock)
            {
                if (string.IsNullOrWhiteSpace(drive.DriveId))
                {
                    drive.DriveId = "DRV-2026-" + (_drives.Count + 1).ToString("D2");
                }
                _drives.Insert(0, drive);

                // Real-time synchronization: update/insert Corporate Partner Company
                SyncDriveToCompany(drive);

                // Audit log
                _logs.Insert(0, new SystemLogModel
                {
                    EventId = "EVT-" + DateTime.Now.Ticks.ToString().Substring(12),
                    Timestamp = DateTime.Now,
                    Actor = "Prof. R. Sharma (Coordinator)",
                    Module = "Placement Drives",
                    EventName = "Scheduled Placement Drive: " + drive.CompanyName,
                    Severity = "Info",
                    ActionSynopsis = "Scheduled drive " + drive.DriveId + " for " + drive.CompanyName + " (" + drive.JobTitle + ")."
                });
            }

            TrySyncDriveToDatabase(drive, isNew: true);
        }

        public static bool UpdateDrive(PlacementDriveModel drive)
        {
            lock (_lock)
            {
                var existing = _drives.FirstOrDefault(d => d.DriveId.Equals(drive.DriveId, StringComparison.OrdinalIgnoreCase));
                if (existing != null)
                {
                    existing.CompanyName = drive.CompanyName;
                    existing.JobTitle = drive.JobTitle;
                    existing.EventDate = drive.EventDate;
                    existing.TimeWindow = drive.TimeWindow;
                    existing.Location = drive.Location;
                    existing.Status = drive.Status;
                    existing.RegisteredStudents = drive.RegisteredStudents;
                    existing.EligibleDept = drive.EligibleDept;
                    existing.MinCgpa = drive.MinCgpa;
                    existing.DriveType = drive.DriveType;
                    if (drive.PackageLPA > 0) existing.PackageLPA = drive.PackageLPA;
                    if (!string.IsNullOrWhiteSpace(drive.Industry)) existing.Industry = drive.Industry;

                    // Real-time synchronization: reflect in Corporate Partner Directory
                    SyncDriveToCompany(existing);
                    TrySyncDriveToDatabase(existing, isNew: false);
                    return true;
                }
                return false;
            }
        }

        public static bool DeleteDrive(string driveId)
        {
            lock (_lock)
            {
                var item = _drives.FirstOrDefault(d => d.DriveId.Equals(driveId, StringComparison.OrdinalIgnoreCase));
                if (item != null)
                {
                    string compName = item.CompanyName;
                    _drives.Remove(item);

                    if (!string.IsNullOrWhiteSpace(compName))
                    {
                        var remaining = _drives.Where(d => string.Equals(d.CompanyName, compName, StringComparison.OrdinalIgnoreCase)).ToList();
                        var comp = _companies.FirstOrDefault(c => string.Equals(c.CompanyName, compName, StringComparison.OrdinalIgnoreCase));
                        if (comp != null)
                        {
                            if (remaining.Count == 0)
                            {
                                _companies.Remove(comp);
                                TryDeleteCompanyFromDatabase(compName);
                            }
                            else
                            {
                                SyncDriveToCompany(remaining[0]);
                            }
                        }
                    }

                    TryDeleteDriveFromDatabase(driveId);
                    return true;
                }
                return false;
            }
        }

        public static PlacementDriveModel GetDrive(string driveId)
        {
            lock (_lock)
            {
                return _drives.FirstOrDefault(d => d.DriveId.Equals(driveId, StringComparison.OrdinalIgnoreCase));
            }
        }

        public static void AddCompany(CompanyModel company)
        {
            lock (_lock)
            {
                if (company == null || string.IsNullOrWhiteSpace(company.CompanyName)) return;

                string compName = company.CompanyName.Trim();
                var existing = _companies.FirstOrDefault(c => string.Equals(c.CompanyName, compName, StringComparison.OrdinalIgnoreCase));
                if (existing != null)
                {
                    existing.Industry = company.Industry;
                    existing.Role = company.Role;
                    existing.MinCgpa = company.MinCgpa;
                    existing.PackageLPA = company.PackageLPA;
                    existing.DriveDate = company.DriveDate;
                    existing.Status = company.Status;
                    existing.EligibleCount = company.EligibleCount;
                }
                else
                {
                    _companies.Insert(0, company);
                }

                // Real-time synchronization: update/create matching Placement Drive
                var matchingDrive = _drives.FirstOrDefault(d => string.Equals(d.CompanyName, compName, StringComparison.OrdinalIgnoreCase));
                if (matchingDrive != null)
                {
                    matchingDrive.JobTitle = company.Role;
                    matchingDrive.EventDate = company.DriveDate;
                    matchingDrive.Status = MapCompanyStatusToDriveStatus(company.Status);
                    matchingDrive.RegisteredStudents = company.EligibleCount;
                    matchingDrive.MinCgpa = company.MinCgpa;
                    matchingDrive.PackageLPA = company.PackageLPA;
                    matchingDrive.Industry = company.Industry;
                    TrySyncDriveToDatabase(matchingDrive, isNew: false);
                }
                else
                {
                    var newDrive = new PlacementDriveModel
                    {
                        DriveId = "DRV-2026-" + (_drives.Count + 1).ToString("D2"),
                        CompanyName = compName,
                        JobTitle = company.Role,
                        EventDate = company.DriveDate,
                        TimeWindow = "10:00 AM - 01:00 PM",
                        Location = "Campus Lab 3 & 4",
                        Status = MapCompanyStatusToDriveStatus(company.Status),
                        RegisteredStudents = company.EligibleCount > 0 ? company.EligibleCount : 50,
                        EligibleDept = "CSE, IT, ECE",
                        MinCgpa = company.MinCgpa > 0 ? company.MinCgpa : 7.0m,
                        PackageLPA = company.PackageLPA,
                        Industry = company.Industry,
                        DriveType = "Full Time"
                    };
                    _drives.Insert(0, newDrive);
                    TrySyncDriveToDatabase(newDrive, isNew: true);
                }

                TrySyncCompanyToDatabase(company);
            }
        }

        public static bool DeleteCompany(string companyName)
        {
            lock (_lock)
            {
                if (string.IsNullOrWhiteSpace(companyName)) return false;

                var comp = _companies.FirstOrDefault(c => string.Equals(c.CompanyName, companyName, StringComparison.OrdinalIgnoreCase));
                if (comp != null)
                {
                    _companies.Remove(comp);
                    var matchedDrives = _drives.Where(d => string.Equals(d.CompanyName, companyName, StringComparison.OrdinalIgnoreCase)).ToList();
                    foreach (var d in matchedDrives)
                    {
                        _drives.Remove(d);
                        TryDeleteDriveFromDatabase(d.DriveId);
                    }
                    TryDeleteCompanyFromDatabase(companyName);
                    return true;
                }
                return false;
            }
        }

        private static void SyncDriveToCompany(PlacementDriveModel drive)
        {
            if (drive == null || string.IsNullOrWhiteSpace(drive.CompanyName)) return;

            string compName = drive.CompanyName.Trim();
            var existing = _companies.FirstOrDefault(c => string.Equals(c.CompanyName, compName, StringComparison.OrdinalIgnoreCase));
            string companyStatus = MapDriveStatusToCompanyStatus(drive.Status);

            if (existing != null)
            {
                if (!string.IsNullOrWhiteSpace(drive.JobTitle)) existing.Role = drive.JobTitle;
                if (!string.IsNullOrWhiteSpace(drive.EventDate)) existing.DriveDate = drive.EventDate;
                if (drive.MinCgpa > 0) existing.MinCgpa = drive.MinCgpa;
                if (drive.PackageLPA > 0) existing.PackageLPA = drive.PackageLPA;
                if (!string.IsNullOrWhiteSpace(drive.Industry)) existing.Industry = drive.Industry;
                existing.Status = companyStatus;
                if (drive.RegisteredStudents > 0) existing.EligibleCount = drive.RegisteredStudents;
            }
            else
            {
                var newComp = new CompanyModel
                {
                    CompanyName = compName,
                    Industry = !string.IsNullOrWhiteSpace(drive.Industry) ? drive.Industry : "IT & Software Services",
                    Role = !string.IsNullOrWhiteSpace(drive.JobTitle) ? drive.JobTitle : "Software Engineer",
                    MinCgpa = drive.MinCgpa > 0 ? drive.MinCgpa : 7.0m,
                    PackageLPA = drive.PackageLPA > 0 ? drive.PackageLPA : 6.5m,
                    DriveDate = !string.IsNullOrWhiteSpace(drive.EventDate) ? drive.EventDate : DateTime.Now.AddDays(14).ToString("MMM dd, yyyy"),
                    Status = companyStatus,
                    EligibleCount = drive.RegisteredStudents > 0 ? drive.RegisteredStudents : 48
                };
                _companies.Insert(0, newComp);
                TrySyncCompanyToDatabase(newComp);
            }
        }

        public static string MapDriveStatusToCompanyStatus(string driveStatus)
        {
            if (string.IsNullOrWhiteSpace(driveStatus)) return "Upcoming";
            string s = driveStatus.Trim().ToLowerInvariant();
            if (s.Contains("progress") || s == "active" || s == "open") return "Active";
            if (s.Contains("complete") || s == "closed") return "Completed";
            return "Upcoming";
        }

        public static string MapCompanyStatusToDriveStatus(string compStatus)
        {
            if (string.IsNullOrWhiteSpace(compStatus)) return "Scheduled";
            string s = compStatus.Trim().ToLowerInvariant();
            if (s.Contains("active") || s.Contains("hiring")) return "In Progress";
            if (s.Contains("complete") || s.Contains("closed")) return "Completed";
            return "Scheduled";
        }

        #region Database Synchronization Helpers
        private static string GetDbConnectionString()
        {
            var cs = ConfigurationManager.ConnectionStrings["PlacementPrepDB"] ??
                     ConfigurationManager.ConnectionStrings["PlacementPrepDb"];
            return cs != null ? cs.ConnectionString : null;
        }

        private static void TrySyncDriveToDatabase(PlacementDriveModel drive, bool isNew)
        {
            try
            {
                string connStr = GetDbConnectionString();
                if (string.IsNullOrWhiteSpace(connStr)) return;

                using (var conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string sql = @"
IF EXISTS (SELECT 1 FROM dbo.PlacementDrives WHERE DriveId = @DriveId)
BEGIN
    UPDATE dbo.PlacementDrives
    SET CompanyName = @CompanyName,
        JobTitle = @JobTitle,
        EventDate = @EventDate,
        TimeWindow = @TimeWindow,
        Location = @Location,
        Status = @Status,
        RegisteredStudents = @RegisteredStudents,
        MinCtcOffered = @PackageLPA,
        MaxCtcOffered = @PackageLPA,
        EligibilityMinCgpa = @MinCgpa
    WHERE DriveId = @DriveId;
END
ELSE
BEGIN
    INSERT INTO dbo.PlacementDrives (DriveId, CompanyName, JobTitle, EventDate, TimeWindow, Location, Status, RegisteredStudents, MinCtcOffered, MaxCtcOffered, EligibilityMinCgpa)
    VALUES (@DriveId, @CompanyName, @JobTitle, @EventDate, @TimeWindow, @Location, @Status, @RegisteredStudents, @PackageLPA, @PackageLPA, @MinCgpa);
END";
                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@DriveId", (object)drive.DriveId ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@CompanyName", (object)drive.CompanyName ?? "Company");
                        cmd.Parameters.AddWithValue("@JobTitle", (object)drive.JobTitle ?? "Software Engineer");
                        cmd.Parameters.AddWithValue("@EventDate", (object)drive.EventDate ?? DateTime.Now.ToString("MMM dd, yyyy"));
                        cmd.Parameters.AddWithValue("@TimeWindow", (object)drive.TimeWindow ?? "10:00 AM - 01:00 PM");
                        cmd.Parameters.AddWithValue("@Location", (object)drive.Location ?? "Campus Lab");
                        cmd.Parameters.AddWithValue("@Status", (object)drive.Status ?? "Scheduled");
                        cmd.Parameters.AddWithValue("@RegisteredStudents", drive.RegisteredStudents);
                        cmd.Parameters.AddWithValue("@PackageLPA", drive.PackageLPA > 0 ? drive.PackageLPA : 6.0m);
                        cmd.Parameters.AddWithValue("@MinCgpa", drive.MinCgpa > 0 ? drive.MinCgpa : 6.5m);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch
            {
                // Graceful fallback to in-memory store
            }
        }

        private static void TrySyncCompanyToDatabase(CompanyModel company)
        {
            try
            {
                string connStr = GetDbConnectionString();
                if (string.IsNullOrWhiteSpace(connStr)) return;

                using (var conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string sql = @"
IF EXISTS (SELECT 1 FROM dbo.Companies WHERE CompanyName = @CompanyName)
BEGIN
    UPDATE dbo.Companies
    SET Industry = @Industry,
        Role = @Role,
        MinCgpa = @MinCgpa,
        PackageLPA = @PackageLPA,
        DriveDate = @DriveDate,
        Status = @Status,
        EligibleCount = @EligibleCount
    WHERE CompanyName = @CompanyName;
END
ELSE
BEGIN
    INSERT INTO dbo.Companies (CompanyName, Industry, Role, TierClassification, MinCgpa, PackageLPA, DriveDate, Status, EligibleCount)
    VALUES (@CompanyName, @Industry, @Role, 'Tier 2', @MinCgpa, @PackageLPA, @DriveDate, @Status, @EligibleCount);
END";
                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@CompanyName", (object)company.CompanyName ?? "Company");
                        cmd.Parameters.AddWithValue("@Industry", (object)company.Industry ?? "IT Services");
                        cmd.Parameters.AddWithValue("@Role", (object)company.Role ?? "Software Engineer");
                        cmd.Parameters.AddWithValue("@MinCgpa", company.MinCgpa > 0 ? company.MinCgpa : 7.0m);
                        cmd.Parameters.AddWithValue("@PackageLPA", company.PackageLPA > 0 ? company.PackageLPA : 6.5m);
                        cmd.Parameters.AddWithValue("@DriveDate", (object)company.DriveDate ?? DateTime.Now.ToString("MMM dd, yyyy"));
                        cmd.Parameters.AddWithValue("@Status", (object)company.Status ?? "Upcoming");
                        cmd.Parameters.AddWithValue("@EligibleCount", company.EligibleCount > 0 ? company.EligibleCount : 45);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch
            {
                // Graceful fallback to in-memory store
            }
        }

        private static void TryDeleteDriveFromDatabase(string driveId)
        {
            try
            {
                string connStr = GetDbConnectionString();
                if (string.IsNullOrWhiteSpace(connStr)) return;

                using (var conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    using (var cmd = new SqlCommand("DELETE FROM dbo.PlacementDrives WHERE DriveId = @DriveId", conn))
                    {
                        cmd.Parameters.AddWithValue("@DriveId", driveId);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch
            {
                // Graceful fallback
            }
        }

        private static void TryDeleteCompanyFromDatabase(string companyName)
        {
            try
            {
                string connStr = GetDbConnectionString();
                if (string.IsNullOrWhiteSpace(connStr)) return;

                using (var conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    using (var cmd = new SqlCommand("DELETE FROM dbo.Companies WHERE CompanyName = @CompanyName", conn))
                    {
                        cmd.Parameters.AddWithValue("@CompanyName", companyName);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch
            {
                // Graceful fallback
            }
        }
        #endregion

        public static void AddAnnouncement(AnnouncementModel a)
        {
            lock (_lock)
            {
                if (string.IsNullOrWhiteSpace(a.AnnouncementId))
                {
                    a.AnnouncementId = "ANN-" + DateTime.Now.Ticks.ToString().Substring(10);
                }
                a.PostedDate = DateTime.Now;
                _announcements.Insert(0, a);
            }
        }

        public static void AddStudent(StudentModel s)
        {
            lock (_lock)
            {
                _students.Insert(0, s);
            }
        }

        private static void SeedData()
        {
            _students = new List<StudentModel>
            {
                new StudentModel
                {
                    RollNo = "24SOECE1101",
                    Name = "Aarav Sharma",
                    Department = "Computer Science & Engineering",
                    ClassYear = "Class of 2025",
                    CGPA = 9.2m,
                    AvgScore = 88.5m,
                    TestsCompleted = 14,
                    Status = "Strong Fit",
                    Trend = "+4%",
                    Email = "aarav.sharma@campus.edu",
                    ReadinessIndex = 92m,
                    BatchRank = 1,
                    TotalSolved = 245,
                    Skills = new List<string> { "C#", "ASP.NET Core", "SQL", "DSA", "System Design" }
                },
                new StudentModel
                {
                    RollNo = "24SOECE1102",
                    Name = "Sneha Patel",
                    Department = "Computer Science & Engineering",
                    ClassYear = "Class of 2025",
                    CGPA = 8.9m,
                    AvgScore = 84.0m,
                    TestsCompleted = 12,
                    Status = "Strong Fit",
                    Trend = "+2%",
                    Email = "sneha.patel@campus.edu",
                    ReadinessIndex = 88m,
                    BatchRank = 4,
                    TotalSolved = 210,
                    Skills = new List<string> { "Java", "Spring Boot", "AWS", "Python" }
                },
                new StudentModel
                {
                    RollNo = "24SOECE1103",
                    Name = "Rohan Gupta",
                    Department = "Information Technology",
                    ClassYear = "Class of 2025",
                    CGPA = 7.8m,
                    AvgScore = 72.5m,
                    TestsCompleted = 9,
                    Status = "On Track",
                    Trend = "+5%",
                    Email = "rohan.gupta@campus.edu",
                    ReadinessIndex = 74m,
                    BatchRank = 18,
                    TotalSolved = 150,
                    Skills = new List<string> { "JavaScript", "React", "Node.js", "MongoDB" }
                },
                new StudentModel
                {
                    RollNo = "24SOECE1104",
                    Name = "Priya Nair",
                    Department = "Computer Science & Engineering",
                    ClassYear = "Class of 2025",
                    CGPA = 8.4m,
                    AvgScore = 79.0m,
                    TestsCompleted = 11,
                    Status = "Strong Fit",
                    Trend = "+1%",
                    Email = "priya.nair@campus.edu",
                    ReadinessIndex = 82m,
                    BatchRank = 8,
                    TotalSolved = 185,
                    Skills = new List<string> { "Python", "Data Science", "SQL", "PowerBI" }
                },
                new StudentModel
                {
                    RollNo = "24SOECE1105",
                    Name = "Vikram Singh",
                    Department = "Information Technology",
                    ClassYear = "Class of 2025",
                    CGPA = 6.9m,
                    AvgScore = 61.0m,
                    TestsCompleted = 7,
                    Status = "Needs Review",
                    Trend = "-2%",
                    Email = "vikram.singh@campus.edu",
                    ReadinessIndex = 62m,
                    BatchRank = 34,
                    TotalSolved = 98,
                    Skills = new List<string> { "C++", "HTML/CSS", "Git" }
                }
            };

            _subjects = new List<SubjectModel>
            {
                new SubjectModel
                {
                    SubjectCode = "CS501",
                    SubjectName = "Data Structures & Algorithms",
                    Department = "Computer Science",
                    Semester = 5,
                    TopicsCount = 18,
                    ReadinessRate = 84.5m,
                    AIRelevance = 95.0m,
                    IsActive = true
                },
                new SubjectModel
                {
                    SubjectCode = "CS502",
                    SubjectName = "Object Oriented Programming (C# / Java)",
                    Department = "Computer Science",
                    Semester = 5,
                    TopicsCount = 14,
                    ReadinessRate = 88.0m,
                    AIRelevance = 90.0m,
                    IsActive = true
                },
                new SubjectModel
                {
                    SubjectCode = "CS503",
                    SubjectName = "Database Management Systems",
                    Department = "Computer Science",
                    Semester = 5,
                    TopicsCount = 12,
                    ReadinessRate = 79.5m,
                    AIRelevance = 85.0m,
                    IsActive = true
                },
                new SubjectModel
                {
                    SubjectCode = "CS504",
                    SubjectName = "System Design & Architecture",
                    Department = "Computer Science",
                    Semester = 5,
                    TopicsCount = 10,
                    ReadinessRate = 68.0m,
                    AIRelevance = 92.0m,
                    IsActive = true
                }
            };

            _companies = new List<CompanyModel>
            {
                new CompanyModel
                {
                    CompanyName = "Tech Mahindra",
                    Industry = "IT Services",
                    Role = "Associate Software Engineer",
                    MinCgpa = 7.0m,
                    PackageLPA = 4.5m,
                    DriveDate = "Oct 12, 2026",
                    Status = "Active",
                    EligibleCount = 164
                },
                new CompanyModel
                {
                    CompanyName = "Accenture",
                    Industry = "Consulting & Tech",
                    Role = "Advanced App Engineering Analyst",
                    MinCgpa = 7.5m,
                    PackageLPA = 6.5m,
                    DriveDate = "Oct 19, 2026",
                    Status = "Upcoming",
                    EligibleCount = 142
                },
                new CompanyModel
                {
                    CompanyName = "Amazon",
                    Industry = "Product & Cloud",
                    Role = "Software Development Engineer (SDE-1)",
                    MinCgpa = 8.5m,
                    PackageLPA = 28.0m,
                    DriveDate = "Nov 04, 2026",
                    Status = "Upcoming",
                    EligibleCount = 48
                },
                new CompanyModel
                {
                    CompanyName = "Tata Consultancy Services (TCS)",
                    Industry = "IT Services",
                    Role = "TCS Digital / Ninja",
                    MinCgpa = 6.5m,
                    PackageLPA = 7.2m,
                    DriveDate = "Nov 15, 2026",
                    Status = "Upcoming",
                    EligibleCount = 188
                }
            };

            _logs = new List<SystemLogModel>
            {
                new SystemLogModel
                {
                    EventId = "EVT-1092",
                    Timestamp = DateTime.Now.AddMinutes(-12),
                    Actor = "Prof. R. Sharma",
                    Module = "Curriculum Management",
                    EventName = "Updated Problem Set Weightage",
                    Severity = "Info",
                    ActionSynopsis = "Updated Graph Theory problem set weightage to 25% for upcoming mock test."
                },
                new SystemLogModel
                {
                    EventId = "EVT-1091",
                    Timestamp = DateTime.Now.AddHours(-2),
                    Actor = "Evaluation Engine",
                    Module = "Assessment Integrity",
                    EventName = "Mock Test 4 Auto-Evaluation Complete",
                    Severity = "Info",
                    ActionSynopsis = "Batch test completed by 164 candidates with average score 72%."
                },
                new SystemLogModel
                {
                    EventId = "EVT-1090",
                    Timestamp = DateTime.Now.AddHours(-4),
                    Actor = "Proctor Guard Monitor",
                    Module = "Security System",
                    EventName = "Tab Switch Flag",
                    Severity = "Warning",
                    ActionSynopsis = "Detected window focus change during coding round for candidate 24SOECE1105."
                }
            };

            _drives = new List<PlacementDriveModel>
            {
                new PlacementDriveModel
                {
                    DriveId = "DRV-2026-01",
                    CompanyName = "Tech Mahindra",
                    JobTitle = "Associate Software Engineer",
                    EventDate = "Oct 12, 2026",
                    TimeWindow = "10:00 AM - 01:00 PM",
                    Location = "Lab 4, CS Block",
                    Status = "In Progress",
                    RegisteredStudents = 164,
                    EligibleDept = "CSE, IT, ECE",
                    MinCgpa = 7.0m,
                    PackageLPA = 4.5m,
                    Industry = "IT Services",
                    DriveType = "Full Time"
                },
                new PlacementDriveModel
                {
                    DriveId = "DRV-2026-02",
                    CompanyName = "Accenture",
                    JobTitle = "Advanced App Engineering Analyst",
                    EventDate = "Oct 19, 2026",
                    TimeWindow = "11:30 AM - 01:30 PM",
                    Location = "Auditorium / Online",
                    Status = "Scheduled",
                    RegisteredStudents = 142,
                    EligibleDept = "CSE, IT",
                    MinCgpa = 7.5m,
                    PackageLPA = 6.5m,
                    Industry = "Consulting & Tech",
                    DriveType = "Full Time"
                },
                new PlacementDriveModel
                {
                    DriveId = "DRV-2026-03",
                    CompanyName = "Amazon",
                    JobTitle = "SDE-1",
                    EventDate = "Nov 04, 2026",
                    TimeWindow = "09:00 AM - 05:00 PM",
                    Location = "Virtual Hackathon",
                    Status = "Scheduled",
                    RegisteredStudents = 48,
                    EligibleDept = "CSE, IT",
                    MinCgpa = 8.5m,
                    PackageLPA = 28.0m,
                    Industry = "Product & Cloud",
                    DriveType = "Full Time"
                },
                new PlacementDriveModel
                {
                    DriveId = "DRV-2026-04",
                    CompanyName = "Tata Consultancy Services (TCS)",
                    JobTitle = "TCS Digital / Ninja",
                    EventDate = "Nov 15, 2026",
                    TimeWindow = "09:30 AM - 04:30 PM",
                    Location = "Campus Placement Hall",
                    Status = "Scheduled",
                    RegisteredStudents = 188,
                    EligibleDept = "All Engineering",
                    MinCgpa = 6.5m,
                    PackageLPA = 7.2m,
                    Industry = "IT Services",
                    DriveType = "Full Time"
                }
            };

            _announcements = new List<AnnouncementModel>
            {
                new AnnouncementModel
                {
                    AnnouncementId = "ANN-101",
                    Title = "Tech Mahindra Campus Mock Test Mandatory Attendance",
                    Content = "All final-year students eligible for Tech Mahindra drive must participate in the Mock Assessment scheduled for October 12, 10:00 AM at CS Lab 4.",
                    Priority = "High",
                    TargetCohort = "B.Tech CSE & IT (Batch 2025)",
                    PostedDate = DateTime.Now.AddDays(-1),
                    Author = "Prof. R. Sharma"
                },
                new AnnouncementModel
                {
                    AnnouncementId = "ANN-102",
                    Title = "Resume Verification Deadline Extended",
                    Content = "Students flagged for ATS compliance issues have until Friday, 5:00 PM to update and re-submit their verified resume through the student portal.",
                    Priority = "Normal",
                    TargetCohort = "All Branches",
                    PostedDate = DateTime.Now.AddDays(-3),
                    Author = "Placement Cell"
                }
            };
        }
    }
}
