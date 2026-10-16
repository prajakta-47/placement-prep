using System;

namespace PlacementPrep.Helpers
{
    public class QuestionItem
    {
        public int QuestionId { get; set; }
        public string Code { get; set; }
        public string Category { get; set; }
        public string Topic { get; set; }
        public string Difficulty { get; set; }
        public string Prompt { get; set; }
        public string OptionA { get; set; }
        public string OptionB { get; set; }
        public string OptionC { get; set; }
        public string OptionD { get; set; }
        public string CorrectOption { get; set; }
        public string Explanation { get; set; }
        public int UsageCount { get; set; }
        public string ValidationStatus { get; set; }
        public int Marks { get; set; }
        public double NegativeMarks { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public string PromptSnippet
        {
            get
            {
                if (string.IsNullOrWhiteSpace(Prompt))
                {
                    return string.Empty;
                }

                var clean = Prompt.Trim().Replace("\r", " ").Replace("\n", " ");
                return clean.Length > 90 ? clean.Substring(0, 87) + "..." : clean;
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

        public string CategoryClass
        {
            get
            {
                switch ((Category ?? string.Empty).Trim().ToLowerInvariant())
                {
                    case "technical":
                        return "cat-badge cat-tech";
                    case "coding":
                        return "cat-badge cat-coding";
                    default:
                        return "cat-badge cat-aptitude";
                }
            }
        }

        public string StatusClass
        {
            get
            {
                switch ((ValidationStatus ?? string.Empty).Trim().ToLowerInvariant())
                {
                    case "verified":
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
