using System;
using System.Collections.Generic;

namespace PlacementPrep.Helpers
{
    public class CompanyJobRole
    {
        public string Title { get; set; }
        public string PackageLpa { get; set; }
        public string Department { get; set; }
        public double MinCgpa { get; set; }
        public int Openings { get; set; }
    }

    public class CompanyItem
    {
        public int CompanyId { get; set; }
        public string CompanyName { get; set; }
        public string Industry { get; set; }
        public string WebsiteUrl { get; set; }
        public string RecruiterName { get; set; }
        public string RecruiterEmail { get; set; }
        public string RecruiterPhone { get; set; }
        public string HiringStatus { get; set; } // Active Partner, Hiring This Season, Upcoming, Inactive
        public string Tier { get; set; }         // Tier 1 (Dream), Tier 2, Mass Recruiter
        public int ActiveDrivesCount { get; set; }
        public int TotalOffersMade { get; set; }
        public double AveragePackageLpa { get; set; }
        public double HighestPackageLpa { get; set; }
        public string About { get; set; }
        public string Locations { get; set; }
        public string AvatarClass { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public string Initials
        {
            get
            {
                if (string.IsNullOrWhiteSpace(CompanyName))
                {
                    return "CO";
                }

                var parts = CompanyName.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                if (parts.Length == 1)
                {
                    return parts[0].Substring(0, Math.Min(2, parts[0].Length)).ToUpperInvariant();
                }

                return (parts[0].Substring(0, 1) + parts[1].Substring(0, 1)).ToUpperInvariant();
            }
        }

        public string StatusClass
        {
            get
            {
                switch ((HiringStatus ?? string.Empty).Trim().ToLowerInvariant())
                {
                    case "hiring this season":
                        return "status-pill status-active";
                    case "active partner":
                        return "status-pill status-process";
                    case "upcoming":
                        return "status-pill status-draft";
                    default:
                        return "status-pill status-suspended";
                }
            }
        }

        public string TierClass
        {
            get
            {
                switch ((Tier ?? string.Empty).Trim().ToLowerInvariant())
                {
                    case "tier 1 (dream)":
                        return "tier-badge tier-dream";
                    case "tier 2":
                        return "tier-badge tier-standard";
                    default:
                        return "tier-badge tier-mass";
                }
            }
        }
    }
}
