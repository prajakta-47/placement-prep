using System;
using System.Collections.Generic;
using System.Globalization;

namespace PlacementPrep.Helpers
{
    public class StudentApplicationRecord
    {
        public string CompanyName { get; set; }
        public string JobRole { get; set; }
        public string RecruitmentStage { get; set; } // e.g. Online Assessment, Tech Round 1, Tech Round 2, HR Round
        public string ApplicationStatus { get; set; } // Applied, Shortlisted, In Process, Offered, Rejected
        public double? OfferPackageLpa { get; set; }
        public string AppliedDate { get; set; }

        public string StatusBadgeClass
        {
            get
            {
                switch ((ApplicationStatus ?? string.Empty).Trim().ToLowerInvariant())
                {
                    case "offered":
                        return "status-pill status-active";
                    case "shortlisted":
                    case "in process":
                        return "status-pill status-process";
                    case "applied":
                        return "status-pill status-draft";
                    default:
                        return "status-pill status-suspended";
                }
            }
        }
    }

    public class StudentItem
    {
        public int StudentId { get; set; }
        public string FullName { get; set; }
        public string EnrollmentId { get; set; }
        public string Email { get; set; }
        public string Department { get; set; }
        public int GraduationYear { get; set; }
        public double Cgpa { get; set; }
        public string PlacementEligibility { get; set; } // Eligible, Ineligible, Pending Review
        public string PlacementStatus { get; set; }      // Placed, In Process, Unplaced, Opted Out
        public string CompanyPlaced { get; set; }
        public double? PackageLpa { get; set; }
        public string TechnicalSkills { get; set; }
        public string ResumeStatus { get; set; }
        public int AtsScore { get; set; }
        public int ReadinessScore { get; set; }
        public int AssessmentsCompleted { get; set; }
        public int InterviewCount { get; set; }
        public string ActiveApplications { get; set; }
        public List<StudentApplicationRecord> Applications { get; set; } = new List<StudentApplicationRecord>();
        public string GithubProfile { get; set; }
        public string LinkedinProfile { get; set; }
        public string AvatarClass { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public string Initials
        {
            get
            {
                if (string.IsNullOrWhiteSpace(FullName))
                {
                    return "ST";
                }

                var parts = FullName.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                if (parts.Length == 1)
                {
                    return parts[0].Substring(0, Math.Min(2, parts[0].Length)).ToUpperInvariant();
                }

                return (parts[0].Substring(0, 1) + parts[parts.Length - 1].Substring(0, 1)).ToUpperInvariant();
            }
        }

        public string CgpaDisplay
        {
            get
            {
                return Cgpa.ToString("0.00", CultureInfo.InvariantCulture);
            }
        }

        public string EligibilityClass
        {
            get
            {
                switch ((PlacementEligibility ?? string.Empty).Trim().ToLowerInvariant())
                {
                    case "eligible":
                        return "elig-pill elig-eligible";
                    case "ineligible":
                        return "elig-pill elig-ineligible";
                    default:
                        return "elig-pill elig-pending";
                }
            }
        }

        public string PlacementStatusClass
        {
            get
            {
                switch ((PlacementStatus ?? string.Empty).Trim().ToLowerInvariant())
                {
                    case "placed":
                        return "status-pill status-active";
                    case "in process":
                        return "status-pill status-process";
                    case "opted out":
                        return "status-pill status-draft";
                    default:
                        return "status-pill status-suspended";
                }
            }
        }
    }
}
