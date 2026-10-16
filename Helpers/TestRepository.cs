using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace PlacementPrep.Helpers
{
    public class TestKpiSummary
    {
        public int TotalTests { get; set; }
        public int PublishedTests { get; set; }
        public int DraftTests { get; set; }
        public int ScheduledTests { get; set; }
    }

    public class TestSearchResult
    {
        public List<TestItem> Items { get; set; }
        public int TotalCount { get; set; }
        public int PageIndex { get; set; }
        public int PageSize { get; set; }
        public int TotalPages { get; set; }
    }

    public class TestRepository
    {
        private static readonly object SyncLock = new object();
        private static List<TestItem> _tests;
        private static int _nextId = 100;

        static TestRepository()
        {
            SeedSampleTests();
        }

        public TestKpiSummary GetKpiSummary()
        {
            lock (SyncLock)
            {
                // Baseline realistic sample metrics aligned with specification
                return new TestKpiSummary
                {
                    TotalTests = 124,
                    PublishedTests = 86,
                    DraftTests = 24,
                    ScheduledTests = 14
                };
            }
        }

        public List<string> GetCompanies()
        {
            lock (SyncLock)
            {
                return _tests
                    .Select(t => t.Company)
                    .Where(c => !string.IsNullOrWhiteSpace(c))
                    .Distinct(StringComparer.OrdinalIgnoreCase)
                    .OrderBy(c => c)
                    .ToList();
            }
        }

        public TestSearchResult SearchTests(string query, string status, string testType, string company, int pageIndex, int pageSize)
        {
            lock (SyncLock)
            {
                var filtered = _tests.AsEnumerable();

                if (!string.IsNullOrWhiteSpace(query))
                {
                    var q = query.Trim();
                    filtered = filtered.Where(x =>
                        (x.Title != null && x.Title.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (x.TestCode != null && x.TestCode.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (x.Company != null && x.Company.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0));
                }

                if (!string.IsNullOrEmpty(status) && !string.Equals(status, "All", StringComparison.OrdinalIgnoreCase))
                {
                    filtered = filtered.Where(x => string.Equals(x.Status, status, StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrEmpty(testType) && !string.Equals(testType, "All", StringComparison.OrdinalIgnoreCase))
                {
                    filtered = filtered.Where(x => string.Equals(x.TestType, testType, StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrEmpty(company) && !string.Equals(company, "All", StringComparison.OrdinalIgnoreCase))
                {
                    filtered = filtered.Where(x => string.Equals(x.Company, company, StringComparison.OrdinalIgnoreCase));
                }

                var list = filtered.OrderByDescending(x => x.TestId).ToList();
                var totalCount = list.Count;
                var safePageSize = Math.Max(1, pageSize);
                var totalPages = Math.Max(1, (int)Math.Ceiling(totalCount / (double)safePageSize));
                var safePageIndex = Math.Max(1, Math.Min(pageIndex, totalPages));

                var paged = list
                    .Skip((safePageIndex - 1) * safePageSize)
                    .Take(safePageSize)
                    .ToList();

                return new TestSearchResult
                {
                    Items = paged,
                    TotalCount = totalCount,
                    PageIndex = safePageIndex,
                    PageSize = safePageSize,
                    TotalPages = totalPages
                };
            }
        }

        public TestItem GetById(int testId)
        {
            lock (SyncLock)
            {
                return _tests.FirstOrDefault(t => t.TestId == testId);
            }
        }

        public void CreateTest(TestItem test)
        {
            if (test == null) throw new ArgumentNullException(nameof(test));

            lock (SyncLock)
            {
                _nextId++;
                test.TestId = _nextId;
                if (string.IsNullOrWhiteSpace(test.TestCode))
                {
                    test.TestCode = string.Format(CultureInfo.InvariantCulture, "TST-2026-{0:D3}", test.TestId);
                }
                test.CreatedAt = DateTime.UtcNow;
                test.UpdatedAt = DateTime.UtcNow;
                if (string.IsNullOrWhiteSpace(test.CreatedBy))
                {
                    test.CreatedBy = "Admin Superuser";
                }
                _tests.Insert(0, test);
            }
        }

        public void UpdateTest(TestItem test)
        {
            if (test == null) throw new ArgumentNullException(nameof(test));

            lock (SyncLock)
            {
                var existing = _tests.FirstOrDefault(t => t.TestId == test.TestId);
                if (existing == null)
                {
                    throw new InvalidOperationException("Test not found.");
                }

                existing.Title = test.Title;
                existing.Company = test.Company;
                existing.TestType = test.TestType;
                existing.Description = test.Description;
                existing.DurationMinutes = test.DurationMinutes;
                existing.TotalMarks = test.TotalMarks;
                existing.TotalQuestions = test.TotalQuestions;
                existing.ScheduledStart = test.ScheduledStart;
                existing.ScheduledEnd = test.ScheduledEnd;
                existing.Status = test.Status;
                existing.Instructions = test.Instructions;
                existing.PassingPercentage = test.PassingPercentage > 0 ? test.PassingPercentage : 65;
                existing.TargetDepartment = !string.IsNullOrWhiteSpace(test.TargetDepartment) ? test.TargetDepartment : "All Departments";
                existing.TargetBatch = !string.IsNullOrWhiteSpace(test.TargetBatch) ? test.TargetBatch : "Batch 2025";
                existing.ProctoringLevel = !string.IsNullOrWhiteSpace(test.ProctoringLevel) ? test.ProctoringLevel : "Strict Lockdown (Webcam + Fullscreen)";
                existing.NegativeMarking = test.NegativeMarking;
                existing.NegativeMarkValue = test.NegativeMarkValue;
                existing.ShuffleQuestions = test.ShuffleQuestions;
                if (test.SelectedQuestionCodes != null)
                {
                    existing.SelectedQuestionCodes = test.SelectedQuestionCodes;
                }
                existing.UpdatedAt = DateTime.UtcNow;
            }
        }

        public void PublishTest(int testId)
        {
            lock (SyncLock)
            {
                var existing = _tests.FirstOrDefault(t => t.TestId == testId);
                if (existing != null)
                {
                    existing.Status = "Published";
                    existing.UpdatedAt = DateTime.UtcNow;
                }
            }
        }

        public void ScheduleTest(int testId, DateTime? start = null, DateTime? end = null)
        {
            lock (SyncLock)
            {
                var existing = _tests.FirstOrDefault(t => t.TestId == testId);
                if (existing != null)
                {
                    existing.Status = "Scheduled";
                    if (start.HasValue) existing.ScheduledStart = start.Value;
                    if (end.HasValue) existing.ScheduledEnd = end.Value;
                    existing.UpdatedAt = DateTime.UtcNow;
                }
            }
        }

        public void RevertToDraft(int testId)
        {
            lock (SyncLock)
            {
                var existing = _tests.FirstOrDefault(t => t.TestId == testId);
                if (existing != null)
                {
                    existing.Status = "Draft";
                    existing.UpdatedAt = DateTime.UtcNow;
                }
            }
        }

        public void ArchiveTest(int testId)
        {
            lock (SyncLock)
            {
                var existing = _tests.FirstOrDefault(t => t.TestId == testId);
                if (existing != null)
                {
                    existing.Status = "Archived";
                    existing.UpdatedAt = DateTime.UtcNow;
                }
            }
        }

        public void DeleteTest(int testId)
        {
            lock (SyncLock)
            {
                var existing = _tests.FirstOrDefault(t => t.TestId == testId);
                if (existing != null)
                {
                    _tests.Remove(existing);
                }
            }
        }

        private static void SeedSampleTests()
        {
            _tests = new List<TestItem>
            {
                new TestItem
                {
                    TestId = 1,
                    TestCode = "TST-2026-001",
                    Title = "TCS NQT National Qualifier 2026",
                    Company = "TCS",
                    TestType = "Mixed",
                    Description = "Official benchmark campus qualifier assessment covering Numerical, Verbal Ability, and Technical Programming Logic.",
                    DurationMinutes = 120,
                    TotalMarks = 100,
                    TotalQuestions = 80,
                    ScheduledStart = DateTime.UtcNow.AddDays(2).Date.AddHours(10),
                    ScheduledEnd = DateTime.UtcNow.AddDays(2).Date.AddHours(12),
                    Status = "Published",
                    Instructions = "Full-screen lockdown enabled. Calculators are allowed only for the Advanced Quantitative section. No negative marks.",
                    CreatedBy = "Dr. Arvind Menon",
                    PassingPercentage = 60,
                    TargetDepartment = "All Engineering Departments",
                    TargetBatch = "Batch of 2025",
                    ProctoringLevel = "Strict Lockdown (Webcam + Fullscreen)",
                    NegativeMarking = false,
                    NegativeMarkValue = 0.0,
                    ShuffleQuestions = true,
                    SelectedQuestionCodes = new List<string> { "QB-APT-1001", "QB-APT-1002", "QB-TECH-2001", "QB-TECH-2002", "COD-101" },
                    CreatedAt = DateTime.UtcNow.AddDays(-20),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                },
                new TestItem
                {
                    TestId = 2,
                    TestCode = "TST-2026-002",
                    Title = "Amazon SDE Mock Technical Assessment",
                    Company = "Amazon",
                    TestType = "Coding",
                    Description = "Hands-on algorithmic coding challenge with strict constraints and automated test suite evaluation.",
                    DurationMinutes = 90,
                    TotalMarks = 100,
                    TotalQuestions = 4,
                    ScheduledStart = null,
                    ScheduledEnd = null,
                    Status = "Published",
                    Instructions = "Submissions evaluated across hidden corner cases and time complexity limits. Write clean, modular functions.",
                    CreatedBy = "Sarah Jenkins",
                    PassingPercentage = 75,
                    TargetDepartment = "Computer Science & Information Tech",
                    TargetBatch = "Batch of 2025",
                    ProctoringLevel = "AI Proctoring & Plagiarism Scanner",
                    NegativeMarking = false,
                    NegativeMarkValue = 0.0,
                    ShuffleQuestions = true,
                    SelectedQuestionCodes = new List<string> { "COD-101", "COD-102", "COD-103", "COD-105" },
                    CreatedAt = DateTime.UtcNow.AddDays(-18),
                    UpdatedAt = DateTime.UtcNow.AddDays(-3)
                },
                new TestItem
                {
                    TestId = 3,
                    TestCode = "TST-2026-003",
                    Title = "Infosys HackWithInfy Pre-Round",
                    Company = "Infosys",
                    TestType = "Coding",
                    Description = "High-velocity competitive programming drill designed for pre-placement interview shortlist qualification.",
                    DurationMinutes = 180,
                    TotalMarks = 150,
                    TotalQuestions = 3,
                    ScheduledStart = DateTime.UtcNow.AddDays(5).Date.AddHours(14),
                    ScheduledEnd = DateTime.UtcNow.AddDays(5).Date.AddHours(17),
                    Status = "Scheduled",
                    Instructions = "Three dynamic programming & graph problems. Plagiarism scanning active. Memory limit: 256MB.",
                    CreatedBy = "Dr. Rajesh Kumar",
                    CreatedAt = DateTime.UtcNow.AddDays(-15),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                },
                new TestItem
                {
                    TestId = 4,
                    TestCode = "TST-2026-004",
                    Title = "Cisco Network Software Assessment",
                    Company = "Cisco",
                    TestType = "Technical",
                    Description = "Domain technical evaluation on TCP/IP protocols, Socket Programming, Linux System Calls, and C++ OOP.",
                    DurationMinutes = 75,
                    TotalMarks = 90,
                    TotalQuestions = 45,
                    ScheduledStart = null,
                    ScheduledEnd = null,
                    Status = "Published",
                    Instructions = "Negative marking of 0.25 marks for incorrect answers. Single question navigation enabled.",
                    CreatedBy = "Dr. Arvind Menon",
                    CreatedAt = DateTime.UtcNow.AddDays(-14),
                    UpdatedAt = DateTime.UtcNow.AddDays(-4)
                },
                new TestItem
                {
                    TestId = 5,
                    TestCode = "TST-2026-005",
                    Title = "Microsoft Technical Core Diagnostic",
                    Company = "Microsoft",
                    TestType = "Mixed",
                    Description = "Comprehensive diagnostic spanning Operating Systems, DBMS internals, System Architecture, and Algorithms.",
                    DurationMinutes = 90,
                    TotalMarks = 100,
                    TotalQuestions = 50,
                    ScheduledStart = DateTime.UtcNow.AddDays(8).Date.AddHours(9),
                    ScheduledEnd = DateTime.UtcNow.AddDays(8).Date.AddHours(10).AddMinutes(30),
                    Status = "Scheduled",
                    Instructions = "Webcam monitoring and AI proctoring active. Please remain seated facing the camera.",
                    CreatedBy = "Sarah Jenkins",
                    CreatedAt = DateTime.UtcNow.AddDays(-12),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                },
                new TestItem
                {
                    TestId = 6,
                    TestCode = "TST-2026-006",
                    Title = "Cognizant GenC Quantitative Speed Drill",
                    Company = "Cognizant",
                    TestType = "Aptitude",
                    Description = "Speed and accuracy aptitude assessment testing Percentages, Ratios, Time-Speed-Distance, and Series.",
                    DurationMinutes = 60,
                    TotalMarks = 60,
                    TotalQuestions = 60,
                    ScheduledStart = null,
                    ScheduledEnd = null,
                    Status = "Published",
                    Instructions = "60 questions in 60 minutes. Timed section lock applies after 30 minutes.",
                    CreatedBy = "Priya Patel",
                    CreatedAt = DateTime.UtcNow.AddDays(-10),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                },
                new TestItem
                {
                    TestId = 7,
                    TestCode = "TST-2026-007",
                    Title = "Google Cloud Architecture & System Design",
                    Company = "Google",
                    TestType = "Technical",
                    Description = "Advanced multiple-choice test on distributed cache coherence, microservices fault-tolerance, and load balancing.",
                    DurationMinutes = 90,
                    TotalMarks = 100,
                    TotalQuestions = 30,
                    ScheduledStart = null,
                    ScheduledEnd = null,
                    Status = "Draft",
                    Instructions = "Draft test under question composition review by Faculty Evaluation Board.",
                    CreatedBy = "Dr. Arvind Menon",
                    CreatedAt = DateTime.UtcNow.AddDays(-5),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                },
                new TestItem
                {
                    TestId = 8,
                    TestCode = "TST-2026-008",
                    Title = "Wipro Elite NLTH Readiness Test",
                    Company = "Wipro",
                    TestType = "Mixed",
                    Description = "National Level Talent Hunt mock test combining Quants, Logical Reasoning, Verbal, and Basic Coding.",
                    DurationMinutes = 95,
                    TotalMarks = 100,
                    TotalQuestions = 55,
                    ScheduledStart = null,
                    ScheduledEnd = null,
                    Status = "Published",
                    Instructions = "Mandatory sections: Section A Quants, Section B Logical, Section C Coding (2 problems).",
                    CreatedBy = "Dr. Rajesh Kumar",
                    CreatedAt = DateTime.UtcNow.AddDays(-16),
                    UpdatedAt = DateTime.UtcNow.AddDays(-5)
                },
                new TestItem
                {
                    TestId = 9,
                    TestCode = "TST-2026-009",
                    Title = "Placement Cell Diagnostic Aptitude Test",
                    Company = "Placement Cell",
                    TestType = "Aptitude",
                    Description = "Institutional placement baseline screening test administered to all final-year engineering candidates.",
                    DurationMinutes = 60,
                    TotalMarks = 50,
                    TotalQuestions = 50,
                    ScheduledStart = null,
                    ScheduledEnd = null,
                    Status = "Published",
                    Instructions = "Results are mapped directly into your Placement Readiness Index (PRI).",
                    CreatedBy = "Sarah Jenkins",
                    CreatedAt = DateTime.UtcNow.AddDays(-25),
                    UpdatedAt = DateTime.UtcNow.AddDays(-7)
                },
                new TestItem
                {
                    TestId = 10,
                    TestCode = "TST-2026-010",
                    Title = "Accenture Cognitive & Technical Assessment",
                    Company = "Accenture",
                    TestType = "Mixed",
                    Description = "Critical thinking, abstract reasoning, and pseudocode debugging assessment.",
                    DurationMinutes = 90,
                    TotalMarks = 90,
                    TotalQuestions = 70,
                    ScheduledStart = DateTime.UtcNow.AddDays(12).Date.AddHours(11),
                    ScheduledEnd = DateTime.UtcNow.AddDays(12).Date.AddHours(12).AddMinutes(30),
                    Status = "Scheduled",
                    Instructions = "Passing benchmark is 65% across both Cognitive and Pseudocode sections.",
                    CreatedBy = "Dr. Arvind Menon",
                    CreatedAt = DateTime.UtcNow.AddDays(-6),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                },
                new TestItem
                {
                    TestId = 11,
                    TestCode = "TST-2026-011",
                    Title = "Goldman Sachs Aptitude & Financial Math Benchmark",
                    Company = "Goldman Sachs",
                    TestType = "Aptitude",
                    Description = "Probability, Permutations, Statistics, and Data Interpretation assessment.",
                    DurationMinutes = 60,
                    TotalMarks = 80,
                    TotalQuestions = 40,
                    ScheduledStart = null,
                    ScheduledEnd = null,
                    Status = "Archived",
                    Instructions = "Archived past test from Campus Drive Cycle 2025.",
                    CreatedBy = "Sarah Jenkins",
                    CreatedAt = DateTime.UtcNow.AddDays(-45),
                    UpdatedAt = DateTime.UtcNow.AddDays(-15)
                },
                new TestItem
                {
                    TestId = 12,
                    TestCode = "TST-2026-012",
                    Title = "Capgemini Excelerator Technical Test",
                    Company = "Capgemini",
                    TestType = "Technical",
                    Description = "Technical assessment on Core Java, Data Structures, SQL, and Software Engineering principles.",
                    DurationMinutes = 60,
                    TotalMarks = 50,
                    TotalQuestions = 40,
                    ScheduledStart = null,
                    ScheduledEnd = null,
                    Status = "Draft",
                    Instructions = "Draft test awaiting final question pool approval from Placement Coordinator.",
                    CreatedBy = "Priya Patel",
                    CreatedAt = DateTime.UtcNow.AddDays(-3),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                }
            };
        }
    }
}
