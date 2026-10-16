using System;
using System.Globalization;

namespace PlacementPrep.Helpers
{
    public class CodingProblemItem
    {
        public int ProblemId { get; set; }
        public string Code { get; set; } // e.g. COD-101
        public string Title { get; set; }
        public string Topic { get; set; } // Arrays, Strings, Trees, Graphs, Dynamic Programming, etc.
        public string Difficulty { get; set; } // Easy, Medium, Hard
        public string Statement { get; set; }
        public string InputFormat { get; set; }
        public string OutputFormat { get; set; }
        public string Constraints { get; set; } // e.g. 1 <= N <= 10^5, Time: 1.0s, Mem: 256MB
        public string SampleInput { get; set; }
        public string SampleOutput { get; set; }
        public string Explanation { get; set; }
        public string StarterCode { get; set; }
        public int TestCaseCount { get; set; }
        public int Marks { get; set; }
        public string Status { get; set; } // Published, Draft, In Review
        public int SubmissionsCount { get; set; }
        public double AcceptanceRate { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public string StatementSnippet
        {
            get
            {
                if (string.IsNullOrWhiteSpace(Statement))
                {
                    return string.Empty;
                }

                var clean = Statement.Trim().Replace("\r", " ").Replace("\n", " ");
                return clean.Length > 95 ? clean.Substring(0, 92) + "..." : clean;
            }
        }

        public string DifficultyClass
        {
            get
            {
                switch ((Difficulty ?? string.Empty).Trim().ToLowerInvariant())
                {
                    case "easy":
                        return "diff-badge diff-easy";
                    case "hard":
                        return "diff-badge diff-hard";
                    default:
                        return "diff-badge diff-medium";
                }
            }
        }

        public string StatusClass
        {
            get
            {
                switch ((Status ?? string.Empty).Trim().ToLowerInvariant())
                {
                    case "published":
                        return "status-pill status-verified";
                    case "draft":
                        return "status-pill status-draft";
                    default:
                        return "status-pill status-review";
                }
            }
        }
    }
}
