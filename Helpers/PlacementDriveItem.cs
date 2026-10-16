using System;
using System.Globalization;

namespace PlacementPrep.Helpers
{
    public class DriveCandidateEvaluation
    {
        public int StudentId { get; set; }
        public string FullName { get; set; }
        public string EnrollmentId { get; set; }
        public string Email { get; set; }
        public string Department { get; set; }
        public int GraduationYear { get; set; }
        public double Cgpa { get; set; }
        public bool IsEligible { get; set; }
        public string EligibilityReason { get; set; }
        public string ApplicationStage { get; set; }
        public string AvatarClass { get; set; }
        public string Initials { get; set; }
    }

    public class PlacementDriveItem
    {
        public int DriveId { get; set; }
        public string DriveCode { get; set; }
        public int CompanyId { get; set; }
        public string CompanyName { get; set; }
        public string JobRole { get; set; }
        public string JobDescription { get; set; }
        public DateTime DriveDate { get; set; }
        public DateTime ApplicationDeadline { get; set; }
        public string EligibleDepartments { get; set; } // Comma-separated: Computer Science, Information Technology, etc.
        public int GraduationBatch { get; set; }
        public double MinCgpa { get; set; }
        public double PackageMinLpa { get; set; }
        public double PackageMaxLpa { get; set; }
        public int Openings { get; set; }
        public string DriveStatus { get; set; } // Draft, Upcoming, Open, Closed, Completed
        public string RecruitmentStages { get; set; } // e.g. Online Assessment, Tech Round 1, Tech Round 2, HR Round
        public int ApplicantCount { get; set; }
        public int ShortlistedCount { get; set; }
        public int OfferedCount { get; set; }
        public string WorkLocation { get; set; }
        public string BondDetails { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public string PackageDisplay
        {
            get
            {
                if (PackageMinLpa > 0 && PackageMaxLpa > 0)
                {
                    if (Math.Abs(PackageMinLpa - PackageMaxLpa) < 0.01)
                    {
                        return PackageMinLpa.ToString("0.0", CultureInfo.InvariantCulture) + " LPA";
                    }
                    return PackageMinLpa.ToString("0.0", CultureInfo.InvariantCulture) + " - " +
                           PackageMaxLpa.ToString("0.0", CultureInfo.InvariantCulture) + " LPA";
                }
                if (PackageMinLpa > 0)
                {
                    return PackageMinLpa.ToString("0.0", CultureInfo.InvariantCulture) + " LPA";
                }
                return "Not Disclosed";
            }
        }

        public string StatusClass
        {
            get
            {
                switch ((DriveStatus ?? string.Empty).Trim().ToLowerInvariant())
                {
                    case "open":
                        return "status-pill status-active";
                    case "upcoming":
                        return "status-pill status-process";
                    case "completed":
                        return "status-pill status-mint";
                    case "draft":
                        return "status-pill status-draft";
                    default:
                        return "status-pill status-suspended";
                }
            }
        }
    }
}
