using System;
using System.Globalization;

namespace PlacementPrep.Helpers
{
    public class TestItem
    {
        public int TestId { get; set; }
        public string TestCode { get; set; }
        public string Title { get; set; }
        public string Company { get; set; }
        public string TestType { get; set; } // Aptitude, Technical, Coding, Mixed
        public string Description { get; set; }
        public int DurationMinutes { get; set; }
        public int TotalMarks { get; set; }
        public int TotalQuestions { get; set; }
        public DateTime? ScheduledStart { get; set; }
        public DateTime? ScheduledEnd { get; set; }
        public string Status { get; set; } // Draft, Published, Scheduled, Archived
        public string Instructions { get; set; }
        public string CreatedBy { get; set; }
        public int PassingPercentage { get; set; }
        public string TargetDepartment { get; set; }
        public string TargetBatch { get; set; }
        public string ProctoringLevel { get; set; }
        public bool NegativeMarking { get; set; }
        public double NegativeMarkValue { get; set; }
        public bool ShuffleQuestions { get; set; }
        public System.Collections.Generic.List<string> SelectedQuestionCodes { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public string DurationDisplay
        {
            get
            {
                if (DurationMinutes >= 60 && DurationMinutes % 60 == 0)
                {
                    return string.Format(CultureInfo.InvariantCulture, "{0} hrs", DurationMinutes / 60);
                }
                if (DurationMinutes > 60)
                {
                    return string.Format(CultureInfo.InvariantCulture, "{0}h {1}m", DurationMinutes / 60, DurationMinutes % 60);
                }
                return string.Format(CultureInfo.InvariantCulture, "{0} mins", DurationMinutes);
            }
        }

        public string ScheduleDisplay
        {
            get
            {
                if (ScheduledStart.HasValue && ScheduledEnd.HasValue)
                {
                    if (ScheduledStart.Value.Date == ScheduledEnd.Value.Date)
                    {
                        return string.Format(
                            CultureInfo.InvariantCulture,
                            "{0:MMM dd, yyyy} ({1:hh:mm tt} - {2:hh:mm tt})",
                            ScheduledStart.Value,
                            ScheduledStart.Value,
                            ScheduledEnd.Value);
                    }
                    return string.Format(
                        CultureInfo.InvariantCulture,
                        "{0:MMM dd} - {1:MMM dd, yyyy}",
                        ScheduledStart.Value,
                        ScheduledEnd.Value);
                }
                if (ScheduledStart.HasValue)
                {
                    return string.Format(CultureInfo.InvariantCulture, "Starts {0:MMM dd, yyyy hh:mm tt}", ScheduledStart.Value);
                }
                return "On-Demand / Flexible Window";
            }
        }

        public string TypeClass
        {
            get
            {
                switch ((TestType ?? string.Empty).Trim().ToLowerInvariant())
                {
                    case "technical":
                        return "test-type-pill type-tech";
                    case "coding":
                        return "test-type-pill type-coding";
                    case "mixed":
                        return "test-type-pill type-mixed";
                    default:
                        return "test-type-pill type-aptitude";
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
                        return "test-status-pill status-published";
                    case "scheduled":
                        return "test-status-pill status-scheduled";
                    case "archived":
                        return "test-status-pill status-archived";
                    default:
                        return "test-status-pill status-draft";
                }
            }
        }
    }
}
