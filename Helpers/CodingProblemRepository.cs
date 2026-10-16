using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace PlacementPrep.Helpers
{
    public class CodingProblemKpiSummary
    {
        public int TotalProblems { get; set; }
        public int EasyCount { get; set; }
        public int MediumCount { get; set; }
        public int HardCount { get; set; }
        public double PublishedPercent { get; set; }
    }

    public class CodingProblemSearchResult
    {
        public List<CodingProblemItem> Items { get; set; }
        public int TotalCount { get; set; }
        public int PageIndex { get; set; }
        public int PageSize { get; set; }
        public int TotalPages { get; set; }
    }

    public class CodingProblemRepository
    {
        private static readonly object SyncLock = new object();
        private static List<CodingProblemItem> _problems;
        private static int _nextId = 110;

        static CodingProblemRepository()
        {
            SeedSampleProblems();
        }

        public CodingProblemKpiSummary GetKpiSummary()
        {
            lock (SyncLock)
            {
                return new CodingProblemKpiSummary
                {
                    TotalProblems = 390,
                    EasyCount = 140,
                    MediumCount = 195,
                    HardCount = 55,
                    PublishedPercent = 94.8
                };
            }
        }

        public List<string> GetTopics()
        {
            lock (SyncLock)
            {
                return _problems
                    .Select(p => p.Topic)
                    .Where(t => !string.IsNullOrEmpty(t))
                    .Distinct(StringComparer.OrdinalIgnoreCase)
                    .OrderBy(t => t)
                    .ToList();
            }
        }

        public CodingProblemSearchResult SearchProblems(string query, string topic, string difficulty, string status, int pageIndex, int pageSize)
        {
            lock (SyncLock)
            {
                var filtered = _problems.AsEnumerable();

                if (!string.IsNullOrWhiteSpace(query))
                {
                    var q = query.Trim();
                    filtered = filtered.Where(x =>
                        (x.Title != null && x.Title.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (x.Code != null && x.Code.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (x.Topic != null && x.Topic.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (x.Statement != null && x.Statement.IndexOf(q, StringComparison.OrdinalIgnoreCase) >= 0));
                }

                if (!string.IsNullOrEmpty(topic) && !string.Equals(topic, "All", StringComparison.OrdinalIgnoreCase))
                {
                    filtered = filtered.Where(x => string.Equals(x.Topic, topic, StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrEmpty(difficulty) && !string.Equals(difficulty, "All", StringComparison.OrdinalIgnoreCase))
                {
                    filtered = filtered.Where(x => string.Equals(x.Difficulty, difficulty, StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrEmpty(status) && !string.Equals(status, "All", StringComparison.OrdinalIgnoreCase))
                {
                    filtered = filtered.Where(x => string.Equals(x.Status, status, StringComparison.OrdinalIgnoreCase));
                }

                var list = filtered.OrderByDescending(x => x.ProblemId).ToList();
                var totalCount = list.Count;
                var safePageSize = Math.Max(1, pageSize);
                var totalPages = Math.Max(1, (int)Math.Ceiling(totalCount / (double)safePageSize));
                var safePageIndex = Math.Max(1, Math.Min(pageIndex, totalPages));

                var pagedItems = list
                    .Skip((safePageIndex - 1) * safePageSize)
                    .Take(safePageSize)
                    .ToList();

                return new CodingProblemSearchResult
                {
                    Items = pagedItems,
                    TotalCount = totalCount,
                    PageIndex = safePageIndex,
                    PageSize = safePageSize,
                    TotalPages = totalPages
                };
            }
        }

        public CodingProblemItem GetById(int problemId)
        {
            lock (SyncLock)
            {
                return _problems.FirstOrDefault(p => p.ProblemId == problemId);
            }
        }

        public void CreateProblem(CodingProblemItem problem)
        {
            if (problem == null) throw new ArgumentNullException(nameof(problem));

            lock (SyncLock)
            {
                _nextId++;
                problem.ProblemId = _nextId;
                if (string.IsNullOrWhiteSpace(problem.Code))
                {
                    problem.Code = string.Format(CultureInfo.InvariantCulture, "COD-{0:D3}", problem.ProblemId);
                }
                problem.CreatedAt = DateTime.UtcNow;
                problem.UpdatedAt = DateTime.UtcNow;
                if (problem.TestCaseCount == 0)
                {
                    problem.TestCaseCount = 10;
                }
                if (problem.Marks == 0)
                {
                    problem.Marks = 50;
                }
                if (string.IsNullOrWhiteSpace(problem.Status))
                {
                    problem.Status = "Published";
                }
                _problems.Insert(0, problem);
            }
        }

        public void UpdateProblem(CodingProblemItem problem)
        {
            if (problem == null) throw new ArgumentNullException(nameof(problem));

            lock (SyncLock)
            {
                var existing = _problems.FirstOrDefault(p => p.ProblemId == problem.ProblemId);
                if (existing == null)
                {
                    throw new InvalidOperationException("Coding problem not found.");
                }

                existing.Title = problem.Title;
                existing.Topic = problem.Topic;
                existing.Difficulty = problem.Difficulty;
                existing.Statement = problem.Statement;
                existing.InputFormat = problem.InputFormat;
                existing.OutputFormat = problem.OutputFormat;
                existing.Constraints = problem.Constraints;
                existing.SampleInput = problem.SampleInput;
                existing.SampleOutput = problem.SampleOutput;
                existing.Explanation = problem.Explanation;
                existing.StarterCode = problem.StarterCode;
                existing.TestCaseCount = problem.TestCaseCount;
                existing.Marks = problem.Marks;
                existing.Status = problem.Status;
                existing.UpdatedAt = DateTime.UtcNow;
            }
        }

        public void DeleteProblem(int problemId)
        {
            lock (SyncLock)
            {
                var existing = _problems.FirstOrDefault(p => p.ProblemId == problemId);
                if (existing != null)
                {
                    _problems.Remove(existing);
                }
            }
        }

        public void ToggleStatus(int problemId)
        {
            lock (SyncLock)
            {
                var existing = _problems.FirstOrDefault(p => p.ProblemId == problemId);
                if (existing != null)
                {
                    existing.Status = string.Equals(existing.Status, "Published", StringComparison.OrdinalIgnoreCase)
                        ? "Draft"
                        : "Published";
                    existing.UpdatedAt = DateTime.UtcNow;
                }
            }
        }

        public List<CodingProblemItem> GetAll()
        {
            lock (SyncLock)
            {
                return _problems.ToList();
            }
        }

        private static void SeedSampleProblems()
        {
            _problems = new List<CodingProblemItem>
            {
                new CodingProblemItem
                {
                    ProblemId = 1,
                    Code = "COD-101",
                    Title = "Two Sum - Target Pair",
                    Topic = "Arrays & Hashing",
                    Difficulty = "Easy",
                    Statement = "Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.\nYou may assume that each input would have exactly one solution, and you may not use the same element twice.",
                    InputFormat = "First line contains integer N and target. Second line contains N space-separated integers representing nums.",
                    OutputFormat = "Two space-separated integers representing zero-based indices of the two numbers.",
                    Constraints = "2 <= nums.length <= 10^5\n-10^9 <= nums[i] <= 10^9\n-10^9 <= target <= 10^9\nTime Limit: 1.0s\nMemory Limit: 256MB",
                    SampleInput = "4 9\n2 7 11 15",
                    SampleOutput = "0 1",
                    Explanation = "Because nums[0] + nums[1] == 2 + 7 == 9, we return 0 1.",
                    StarterCode = "def twoSum(nums: list[int], target: int) -> list[int]:\n    # Implement your O(N) hash map solution here\n    pass",
                    TestCaseCount = 15,
                    Marks = 20,
                    Status = "Published",
                    SubmissionsCount = 2840,
                    AcceptanceRate = 78.4,
                    CreatedAt = DateTime.UtcNow.AddDays(-30),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                },
                new CodingProblemItem
                {
                    ProblemId = 2,
                    Code = "COD-102",
                    Title = "Maximum Subarray (Kadane's Algorithm)",
                    Topic = "Dynamic Programming",
                    Difficulty = "Medium",
                    Statement = "Given an integer array nums, find the subarray with the largest sum, and return its sum. A subarray is a contiguous non-empty sequence of elements within an array.",
                    InputFormat = "First line contains N. Second line contains N integers representing nums.",
                    OutputFormat = "Single integer representing maximum contiguous subarray sum.",
                    Constraints = "1 <= nums.length <= 10^5\n-10^4 <= nums[i] <= 10^4\nTime Limit: 1.0s\nMemory Limit: 256MB",
                    SampleInput = "9\n-2 1 -3 4 -1 2 1 -5 4",
                    SampleOutput = "6",
                    Explanation = "The subarray [4, -1, 2, 1] has the largest sum 6.",
                    StarterCode = "int maxSubArray(vector<int>& nums) {\n    // Kadane's algorithm\n    return 0;\n}",
                    TestCaseCount = 20,
                    Marks = 50,
                    Status = "Published",
                    SubmissionsCount = 1920,
                    AcceptanceRate = 62.1,
                    CreatedAt = DateTime.UtcNow.AddDays(-28),
                    UpdatedAt = DateTime.UtcNow.AddDays(-3)
                },
                new CodingProblemItem
                {
                    ProblemId = 3,
                    Code = "COD-103",
                    Title = "Longest Palindromic Substring",
                    Topic = "Dynamic Programming",
                    Difficulty = "Medium",
                    Statement = "Given a string s, return the longest palindromic substring in s. Expand around center or 2D DP table approach.",
                    InputFormat = "A single line containing string s.",
                    OutputFormat = "The longest substring that is a palindrome.",
                    Constraints = "1 <= s.length <= 1000\ns consist of only digits and English letters.\nTime Limit: 1.0s\nMemory Limit: 256MB",
                    SampleInput = "babad",
                    SampleOutput = "bab",
                    Explanation = "\"aba\" is also a valid answer.",
                    StarterCode = "public String longestPalindrome(String s) {\n    // Expand around center approach\n    return \"\";\n}",
                    TestCaseCount = 25,
                    Marks = 50,
                    Status = "Published",
                    SubmissionsCount = 1450,
                    AcceptanceRate = 54.8,
                    CreatedAt = DateTime.UtcNow.AddDays(-24),
                    UpdatedAt = DateTime.UtcNow.AddDays(-4)
                },
                new CodingProblemItem
                {
                    ProblemId = 4,
                    Code = "COD-104",
                    Title = "Lowest Common Ancestor in BST",
                    Topic = "Trees & Graphs",
                    Difficulty = "Medium",
                    Statement = "Given a binary search tree (BST), find the lowest common ancestor (LCA) node of two given nodes in the BST.",
                    InputFormat = "Level order traversal of tree and integers p and q.",
                    OutputFormat = "Value of LCA node.",
                    Constraints = "Number of nodes in [2, 10^5]\n-10^9 <= Node.val <= 10^9\nAll Node.val are unique.",
                    SampleInput = "6 2 8 0 4 7 9\n2 8",
                    SampleOutput = "6",
                    Explanation = "The LCA of nodes 2 and 8 is 6.",
                    StarterCode = "TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {\n    // BST property navigation\n    return null;\n}",
                    TestCaseCount = 18,
                    Marks = 50,
                    Status = "Published",
                    SubmissionsCount = 1120,
                    AcceptanceRate = 68.2,
                    CreatedAt = DateTime.UtcNow.AddDays(-20),
                    UpdatedAt = DateTime.UtcNow.AddDays(-5)
                },
                new CodingProblemItem
                {
                    ProblemId = 5,
                    Code = "COD-105",
                    Title = "Detect Cycle in Directed Graph",
                    Topic = "Trees & Graphs",
                    Difficulty = "Hard",
                    Statement = "Given a Directed Graph with V vertices (numbered from 0 to V-1) and E edges, check whether it contains any cycle. Return 1 if cycle exists, else 0.",
                    InputFormat = "First line contains V and E. Next E lines contain edges u -> v.",
                    OutputFormat = "1 if cycle exists, 0 otherwise.",
                    Constraints = "1 <= V, E <= 10^5\nTime Limit: 1.5s\nMemory Limit: 256MB",
                    SampleInput = "4 4\n0 1\n1 2\n2 3\n3 1",
                    SampleOutput = "1",
                    Explanation = "Vertices 1 -> 2 -> 3 -> 1 form a directed cycle.",
                    StarterCode = "bool isCyclic(int V, vector<int> adj[]) {\n    // DFS with recursion stack or Kahn's topological sort\n    return false;\n}",
                    TestCaseCount = 30,
                    Marks = 100,
                    Status = "Published",
                    SubmissionsCount = 890,
                    AcceptanceRate = 41.5,
                    CreatedAt = DateTime.UtcNow.AddDays(-16),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                },
                new CodingProblemItem
                {
                    ProblemId = 6,
                    Code = "COD-106",
                    Title = "Trapping Rain Water",
                    Topic = "Two Pointers",
                    Difficulty = "Hard",
                    Statement = "Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.",
                    InputFormat = "First line contains n. Second line contains n elevation heights.",
                    OutputFormat = "Total units of trapped rain water.",
                    Constraints = "n == height.length\n1 <= n <= 2 * 10^4\n0 <= height[i] <= 10^5\nTime Limit: 1.0s\nMemory Limit: 256MB",
                    SampleInput = "12\n0 1 0 2 1 0 1 3 2 1 2 1",
                    SampleOutput = "6",
                    Explanation = "Elevation map traps 6 units of rain water.",
                    StarterCode = "int trap(int[] height) {\n    // Two pointer optimal O(1) space\n    return 0;\n}",
                    TestCaseCount = 28,
                    Marks = 100,
                    Status = "Published",
                    SubmissionsCount = 760,
                    AcceptanceRate = 48.9,
                    CreatedAt = DateTime.UtcNow.AddDays(-14),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                },
                new CodingProblemItem
                {
                    ProblemId = 7,
                    Code = "COD-107",
                    Title = "Merge Intervals",
                    Topic = "Sorting & Intervals",
                    Difficulty = "Medium",
                    Statement = "Given an array of intervals where intervals[i] = [start_i, end_i], merge all overlapping intervals, and return an array of non-overlapping intervals.",
                    InputFormat = "First line contains N. Next N lines contain pair [start, end].",
                    OutputFormat = "Merged intervals list.",
                    Constraints = "1 <= intervals.length <= 10^4\n0 <= start_i <= end_i <= 10^4\nTime Limit: 1.0s\nMemory Limit: 256MB",
                    SampleInput = "4\n1 3\n2 6\n8 10\n15 18",
                    SampleOutput = "[1, 6] [8, 10] [15, 18]",
                    Explanation = "Intervals [1,3] and [2,6] overlap, merging into [1,6].",
                    StarterCode = "vector<vector<int>> merge(vector<vector<int>>& intervals) {\n    // Sort by start time then merge\n    return {};\n}",
                    TestCaseCount = 22,
                    Marks = 50,
                    Status = "Published",
                    SubmissionsCount = 1340,
                    AcceptanceRate = 66.7,
                    CreatedAt = DateTime.UtcNow.AddDays(-10),
                    UpdatedAt = DateTime.UtcNow.AddDays(-3)
                },
                new CodingProblemItem
                {
                    ProblemId = 8,
                    Code = "COD-108",
                    Title = "LRU Cache Implementation",
                    Topic = "Design & Data Structures",
                    Difficulty = "Hard",
                    Statement = "Design a data structure that follows the constraints of a Least Recently Used (LRU) cache with O(1) get and put operations.",
                    InputFormat = "Operations sequence and key-value pairs.",
                    OutputFormat = "Query results array.",
                    Constraints = "1 <= capacity <= 3000\n0 <= key <= 10^4\n0 <= value <= 10^5\nAt most 2 * 10^5 calls to get and put.",
                    SampleInput = "capacity = 2, put(1, 1), put(2, 2), get(1), put(3, 3), get(2)",
                    SampleOutput = "[null, null, null, 1, null, -1]",
                    Explanation = "Key 2 was evicted because it was the least recently used.",
                    StarterCode = "class LRUCache {\npublic:\n    LRUCache(int capacity) {}\n    int get(int key) { return -1; }\n    void put(int key, int value) {}\n};",
                    TestCaseCount = 35,
                    Marks = 100,
                    Status = "Draft",
                    SubmissionsCount = 420,
                    AcceptanceRate = 38.6,
                    CreatedAt = DateTime.UtcNow.AddDays(-5),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                }
            };
        }
    }
}
