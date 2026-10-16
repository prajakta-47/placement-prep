using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace PlacementPrep.Helpers
{
    public class QuestionKpiSummary
    {
        public int TotalItems { get; set; }
        public int AptitudeCount { get; set; }
        public int TechnicalCount { get; set; }
        public int CodingCount { get; set; }
        public double VerifiedPercent { get; set; }
    }

    public class QuestionSearchResult
    {
        public List<QuestionItem> Items { get; set; }
        public int TotalCount { get; set; }
        public int PageIndex { get; set; }
        public int PageSize { get; set; }
        public int TotalPages { get; set; }
    }

    public class QuestionRepository
    {
        private static readonly object SyncLock = new object();
        private static List<QuestionItem> _questions;
        private static int _nextId = 100;

        static QuestionRepository()
        {
            SeedSampleQuestions();
        }

        public QuestionKpiSummary GetKpiSummary()
        {
            lock (SyncLock)
            {
                var verified = _questions.Count(q => string.Equals(q.ValidationStatus, "Verified", StringComparison.OrdinalIgnoreCase));
                var total = 2486; // Figma baseline
                return new QuestionKpiSummary
                {
                    TotalItems = total,
                    AptitudeCount = 1240,
                    TechnicalCount = 856,
                    CodingCount = 390,
                    VerifiedPercent = 98.4
                };
            }
        }

        public List<string> GetTopics(string category = null)
        {
            lock (SyncLock)
            {
                var query = _questions.AsEnumerable();
                if (!string.IsNullOrEmpty(category) && !string.Equals(category, "All", StringComparison.OrdinalIgnoreCase))
                {
                    query = query.Where(q => string.Equals(q.Category, category, StringComparison.OrdinalIgnoreCase));
                }

                return query.Select(q => q.Topic)
                    .Where(t => !string.IsNullOrEmpty(t))
                    .Distinct(StringComparer.OrdinalIgnoreCase)
                    .OrderBy(t => t)
                    .ToList();
            }
        }

        public QuestionSearchResult SearchQuestions(string query, string category, string difficulty, string status, int pageIndex, int pageSize)
        {
            lock (SyncLock)
            {
                var filtered = _questions.AsEnumerable();

                if (!string.IsNullOrWhiteSpace(query))
                {
                    var q = query.Trim();
                    filtered = filtered.Where(x =>
                        (x.Prompt != null && x.Prompt.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (x.Code != null && x.Code.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (x.Topic != null && x.Topic.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0));
                }

                if (!string.IsNullOrEmpty(category) && !string.Equals(category, "All", StringComparison.OrdinalIgnoreCase))
                {
                    filtered = filtered.Where(x => string.Equals(x.Category, category, StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrEmpty(difficulty) && !string.Equals(difficulty, "All", StringComparison.OrdinalIgnoreCase))
                {
                    filtered = filtered.Where(x => string.Equals(x.Difficulty, difficulty, StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrEmpty(status) && !string.Equals(status, "All", StringComparison.OrdinalIgnoreCase))
                {
                    filtered = filtered.Where(x => string.Equals(x.ValidationStatus, status, StringComparison.OrdinalIgnoreCase));
                }

                var list = filtered.OrderByDescending(x => x.QuestionId).ToList();
                var totalCount = list.Count;
                var safePageSize = Math.Max(1, pageSize);
                var totalPages = Math.Max(1, (int)Math.Ceiling(totalCount / (double)safePageSize));
                var safePageIndex = Math.Max(1, Math.Min(pageIndex, totalPages));

                var pagedItems = list
                    .Skip((safePageIndex - 1) * safePageSize)
                    .Take(safePageSize)
                    .ToList();

                return new QuestionSearchResult
                {
                    Items = pagedItems,
                    TotalCount = totalCount,
                    PageIndex = safePageIndex,
                    PageSize = safePageSize,
                    TotalPages = totalPages
                };
            }
        }

        public QuestionItem GetById(int questionId)
        {
            lock (SyncLock)
            {
                return _questions.FirstOrDefault(q => q.QuestionId == questionId);
            }
        }

        public void CreateQuestion(QuestionItem question)
        {
            if (question == null) throw new ArgumentNullException(nameof(question));

            lock (SyncLock)
            {
                _nextId++;
                question.QuestionId = _nextId;
                if (string.IsNullOrWhiteSpace(question.Code))
                {
                    var prefix = (question.Category ?? "GEN").Substring(0, Math.Min(3, (question.Category ?? "GEN").Length)).ToUpperInvariant();
                    question.Code = string.Format(CultureInfo.InvariantCulture, "QB-{0}-{1:D4}", prefix, question.QuestionId);
                }
                question.CreatedAt = DateTime.UtcNow;
                question.UpdatedAt = DateTime.UtcNow;
                if (question.UsageCount == 0)
                {
                    question.UsageCount = 1;
                }
                _questions.Insert(0, question);
            }
        }

        public void UpdateQuestion(QuestionItem question)
        {
            if (question == null) throw new ArgumentNullException(nameof(question));

            lock (SyncLock)
            {
                var existing = _questions.FirstOrDefault(q => q.QuestionId == question.QuestionId);
                if (existing == null)
                {
                    throw new InvalidOperationException("Question not found.");
                }

                existing.Category = question.Category;
                existing.Topic = question.Topic;
                existing.Difficulty = question.Difficulty;
                existing.Prompt = question.Prompt;
                existing.OptionA = question.OptionA;
                existing.OptionB = question.OptionB;
                existing.OptionC = question.OptionC;
                existing.OptionD = question.OptionD;
                existing.CorrectOption = question.CorrectOption;
                existing.Explanation = question.Explanation;
                existing.ValidationStatus = question.ValidationStatus;
                existing.Marks = question.Marks;
                existing.NegativeMarks = question.NegativeMarks;
                existing.UpdatedAt = DateTime.UtcNow;
            }
        }

        public void DeleteQuestion(int questionId)
        {
            lock (SyncLock)
            {
                var existing = _questions.FirstOrDefault(q => q.QuestionId == questionId);
                if (existing != null)
                {
                    _questions.Remove(existing);
                }
            }
        }

        public void ToggleStatus(int questionId)
        {
            lock (SyncLock)
            {
                var existing = _questions.FirstOrDefault(q => q.QuestionId == questionId);
                if (existing != null)
                {
                    existing.ValidationStatus = string.Equals(existing.ValidationStatus, "Verified", StringComparison.OrdinalIgnoreCase)
                        ? "Review Needed"
                        : "Verified";
                    existing.UpdatedAt = DateTime.UtcNow;
                }
            }
        }

        private static void SeedSampleQuestions()
        {
            _questions = new List<QuestionItem>
            {
                new QuestionItem
                {
                    QuestionId = 1,
                    Code = "QB-APT-1001",
                    Category = "Aptitude",
                    Topic = "Quantitative Aptitude",
                    Difficulty = "Medium",
                    Prompt = "A train travelling at 72 km/h crosses a 200m long platform in 22 seconds. What is the length of the train in meters?",
                    OptionA = "220 m",
                    OptionB = "240 m",
                    OptionC = "260 m",
                    OptionD = "280 m",
                    CorrectOption = "B",
                    Explanation = "Speed in m/s = 72 * (5/18) = 20 m/s. Total distance = speed * time = 20 * 22 = 440 m. Train length = 440 - 200 = 240 m.",
                    UsageCount = 14,
                    ValidationStatus = "Verified",
                    Marks = 2,
                    NegativeMarks = 0.5,
                    CreatedAt = DateTime.UtcNow.AddDays(-15),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                },
                new QuestionItem
                {
                    QuestionId = 2,
                    Code = "QB-TECH-2001",
                    Category = "Technical",
                    Topic = "Data Structures",
                    Difficulty = "Hard",
                    Prompt = "What is the worst-case time complexity of searching for an element in an AVL tree containing N nodes, and what is its maximum height?",
                    OptionA = "O(N) and height N",
                    OptionB = "O(log N) and height 1.44 log2(N)",
                    OptionC = "O(N log N) and height 2 log2(N)",
                    OptionD = "O(1) amortized and height log2(N)",
                    CorrectOption = "B",
                    Explanation = "AVL trees maintain a balance factor of {-1, 0, 1}, ensuring strictly O(log N) height with max bound ~ 1.44 log2(N).",
                    UsageCount = 28,
                    ValidationStatus = "Verified",
                    Marks = 3,
                    NegativeMarks = 1.0,
                    CreatedAt = DateTime.UtcNow.AddDays(-20),
                    UpdatedAt = DateTime.UtcNow.AddDays(-5)
                },
                new QuestionItem
                {
                    QuestionId = 3,
                    Code = "QB-COD-3001",
                    Category = "Coding",
                    Topic = "Dynamic Programming",
                    Difficulty = "Hard",
                    Prompt = "Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum (Kadane's Algorithm).",
                    OptionA = "O(N) time and O(1) auxiliary space",
                    OptionB = "O(N^2) time and O(N) auxiliary space",
                    OptionC = "O(N log N) divide and conquer only",
                    OptionD = "O(2^N) exponential time",
                    CorrectOption = "A",
                    Explanation = "Kadane's Algorithm tracks current max ending at index i and global max in a single pass O(N) time and O(1) memory.",
                    UsageCount = 42,
                    ValidationStatus = "Verified",
                    Marks = 5,
                    NegativeMarks = 0.0,
                    CreatedAt = DateTime.UtcNow.AddDays(-30),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                },
                new QuestionItem
                {
                    QuestionId = 4,
                    Code = "QB-APT-1002",
                    Category = "Aptitude",
                    Topic = "Logical Reasoning",
                    Difficulty = "Easy",
                    Prompt = "Statements: All cats are dogs. Some dogs are birds. Conclusions: I. Some cats are birds. II. No cat is a bird. Which conclusion follows?",
                    OptionA = "Only I follows",
                    OptionB = "Only II follows",
                    OptionC = "Either I or II follows",
                    OptionD = "Neither I nor II follows",
                    CorrectOption = "C",
                    Explanation = "Subject and predicate are same in both conclusions and they form a complementary pair (Some + No) with uncertain relation.",
                    UsageCount = 18,
                    ValidationStatus = "Verified",
                    Marks = 1,
                    NegativeMarks = 0.25,
                    CreatedAt = DateTime.UtcNow.AddDays(-12),
                    UpdatedAt = DateTime.UtcNow.AddDays(-3)
                },
                new QuestionItem
                {
                    QuestionId = 5,
                    Code = "QB-TECH-2002",
                    Category = "Technical",
                    Topic = "DBMS & SQL",
                    Difficulty = "Medium",
                    Prompt = "Which isolation level in SQL prevents Dirty Reads and Non-Repeatable Reads, but allows Phantom Reads?",
                    OptionA = "Read Uncommitted",
                    OptionB = "Read Committed",
                    OptionC = "Repeatable Read",
                    OptionD = "Serializable",
                    CorrectOption = "C",
                    Explanation = "Repeatable Read holds shared read locks until transaction completion, preventing non-repeatable reads while phantom rows may appear without range locks.",
                    UsageCount = 22,
                    ValidationStatus = "Verified",
                    Marks = 2,
                    NegativeMarks = 0.5,
                    CreatedAt = DateTime.UtcNow.AddDays(-18),
                    UpdatedAt = DateTime.UtcNow.AddDays(-4)
                },
                new QuestionItem
                {
                    QuestionId = 6,
                    Code = "QB-TECH-2003",
                    Category = "Technical",
                    Topic = "Operating Systems",
                    Difficulty = "Medium",
                    Prompt = "Which condition is NOT one of Coffman's four conditions required for a system deadlock to occur?",
                    OptionA = "Mutual Exclusion",
                    OptionB = "Hold and Wait",
                    OptionC = "Preemption Allowed",
                    OptionD = "Circular Wait",
                    CorrectOption = "C",
                    Explanation = "The condition is No Preemption. If preemption is allowed, deadlocks can be broken and avoided.",
                    UsageCount = 19,
                    ValidationStatus = "Verified",
                    Marks = 2,
                    NegativeMarks = 0.5,
                    CreatedAt = DateTime.UtcNow.AddDays(-10),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                },
                new QuestionItem
                {
                    QuestionId = 7,
                    Code = "QB-COD-3002",
                    Category = "Coding",
                    Topic = "Trees & Graphs",
                    Difficulty = "Medium",
                    Prompt = "Determine if a directed graph contains a cycle using Depth First Search (DFS). What data structure tracks the current recursion call stack?",
                    OptionA = "FIFO Queue",
                    OptionB = "Visited boolean array and Recursion Stack set",
                    OptionC = "Disjoint Set Union (DSU) without rank",
                    OptionD = "Adjacency matrix only",
                    CorrectOption = "B",
                    Explanation = "A back-edge pointing to a node currently in the recursion stack indicates a cycle in a directed graph.",
                    UsageCount = 31,
                    ValidationStatus = "Verified",
                    Marks = 4,
                    NegativeMarks = 0.0,
                    CreatedAt = DateTime.UtcNow.AddDays(-25),
                    UpdatedAt = DateTime.UtcNow.AddDays(-6)
                },
                new QuestionItem
                {
                    QuestionId = 8,
                    Code = "QB-APT-1003",
                    Category = "Aptitude",
                    Topic = "Verbal Ability",
                    Difficulty = "Easy",
                    Prompt = "Choose the word most nearly opposite in meaning to 'METICULOUS':",
                    OptionA = "Fastidious",
                    OptionB = "Careless",
                    OptionC = "Scrupulous",
                    OptionD = "Punctual",
                    CorrectOption = "B",
                    Explanation = "Meticulous means showing great attention to detail; careless is its direct antonym.",
                    UsageCount = 11,
                    ValidationStatus = "Verified",
                    Marks = 1,
                    NegativeMarks = 0.25,
                    CreatedAt = DateTime.UtcNow.AddDays(-8),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                },
                new QuestionItem
                {
                    QuestionId = 9,
                    Code = "QB-COD-3003",
                    Category = "Coding",
                    Topic = "Arrays & Strings",
                    Difficulty = "Easy",
                    Prompt = "Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target. Optimal time complexity?",
                    OptionA = "O(N^2) using nested loops",
                    OptionB = "O(N log N) using sorting and two pointers",
                    OptionC = "O(N) using a Hash Map for complements",
                    OptionD = "O(1) using Bit manipulation",
                    CorrectOption = "C",
                    Explanation = "A single pass hash map stores seen elements with their indices, resolving complementary lookups in average O(1) time.",
                    UsageCount = 49,
                    ValidationStatus = "Verified",
                    Marks = 3,
                    NegativeMarks = 0.0,
                    CreatedAt = DateTime.UtcNow.AddDays(-40),
                    UpdatedAt = DateTime.UtcNow.AddDays(-8)
                },
                new QuestionItem
                {
                    QuestionId = 10,
                    Code = "QB-TECH-2004",
                    Category = "Technical",
                    Topic = "Computer Networks",
                    Difficulty = "Medium",
                    Prompt = "During TCP 3-way handshake connection establishment, what sequence of packets is transmitted between client and server?",
                    OptionA = "ACK, SYN, SYN-ACK",
                    OptionB = "SYN, SYN-ACK, ACK",
                    OptionC = "SYN, ACK, DATA",
                    OptionD = "FIN, ACK, FIN-ACK",
                    CorrectOption = "B",
                    Explanation = "Client sends SYN, server responds with SYN-ACK, and client completes handshake with ACK.",
                    UsageCount = 16,
                    ValidationStatus = "Review Needed",
                    Marks = 2,
                    NegativeMarks = 0.5,
                    CreatedAt = DateTime.UtcNow.AddDays(-7),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                }
            };
        }
    }
}
