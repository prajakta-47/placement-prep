using System;
using System.Collections.Generic;
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
            }
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
                    _drives.Remove(item);
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
                    RegisteredStudents = 164
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
                    RegisteredStudents = 142
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
