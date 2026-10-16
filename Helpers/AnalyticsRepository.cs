using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;

namespace PlacementPrep.Helpers
{
    public class DepartmentMetric
    {
        public string DepartmentName { get; set; }
        public int TotalStudents { get; set; }
        public int PlacedCount { get; set; }
        public double PlacementPercentage { get; set; }
        public double AveragePackageLpa { get; set; }
        public double HighestPackageLpa { get; set; }
        public string TopRecruiter { get; set; }
    }

    public class SalaryBracketMetric
    {
        public string BracketLabel { get; set; }
        public int OffersCount { get; set; }
        public double Percentage { get; set; }
        public string ColorClass { get; set; }
    }

    public class PartnerRankingMetric
    {
        public int Rank { get; set; }
        public string CompanyName { get; set; }
        public string Tier { get; set; }
        public int OffersMade { get; set; }
        public double AveragePackageLpa { get; set; }
        public double HighestPackageLpa { get; set; }
        public int ActiveDrives { get; set; }
    }

    public class AnalyticsRepository
    {
        public int TotalStudents => 8192;
        public int EligibleStudents => 6480;
        public int PlacedStudents => 5482;
        public int TotalOffers => 6820;
        public double GlobalPlacementRate => 84.6; // 5482 / 6480 * 100
        public double AverageOverallPackageLpa => 14.8;
        public double HighestOverallPackageLpa => 48.0;

        public List<SalaryBracketMetric> GetSalaryDistribution()
        {
            return new List<SalaryBracketMetric>
            {
                new SalaryBracketMetric { BracketLabel = "Below 6.0 LPA", OffersCount = 980, Percentage = 14.4, ColorClass = "bracket-slate" },
                new SalaryBracketMetric { BracketLabel = "6.0 - 12.0 LPA", OffersCount = 2860, Percentage = 41.9, ColorClass = "bracket-blue" },
                new SalaryBracketMetric { BracketLabel = "12.0 - 25.0 LPA", OffersCount = 2140, Percentage = 31.4, ColorClass = "bracket-teal" },
                new SalaryBracketMetric { BracketLabel = "25.0+ LPA (Dream)", OffersCount = 840, Percentage = 12.3, ColorClass = "bracket-gold" }
            };
        }

        public List<DepartmentMetric> GetDepartmentMetrics()
        {
            return new List<DepartmentMetric>
            {
                new DepartmentMetric
                {
                    DepartmentName = "Computer Science",
                    TotalStudents = 2480,
                    PlacedCount = 2310,
                    PlacementPercentage = 93.1,
                    AveragePackageLpa = 18.5,
                    HighestPackageLpa = 48.0,
                    TopRecruiter = "Google"
                },
                new DepartmentMetric
                {
                    DepartmentName = "Information Technology",
                    TotalStudents = 1860,
                    PlacedCount = 1680,
                    PlacementPercentage = 90.3,
                    AveragePackageLpa = 16.2,
                    HighestPackageLpa = 44.0,
                    TopRecruiter = "Microsoft"
                },
                new DepartmentMetric
                {
                    DepartmentName = "Electronics & Comm",
                    TotalStudents = 2120,
                    PlacedCount = 1790,
                    PlacementPercentage = 84.4,
                    AveragePackageLpa = 13.4,
                    HighestPackageLpa = 27.0,
                    TopRecruiter = "Cisco Systems"
                },
                new DepartmentMetric
                {
                    DepartmentName = "Mechanical Engineering",
                    TotalStudents = 1732,
                    PlacedCount = 1240,
                    PlacementPercentage = 71.6,
                    AveragePackageLpa = 8.6,
                    HighestPackageLpa = 14.0,
                    TopRecruiter = "Deloitte USI"
                }
            };
        }

        public List<PartnerRankingMetric> GetPartnerRankings()
        {
            return new List<PartnerRankingMetric>
            {
                new PartnerRankingMetric { Rank = 1, CompanyName = "Tata Consultancy Services", Tier = "Mass Recruiter", OffersMade = 340, AveragePackageLpa = 7.2, HighestPackageLpa = 11.5, ActiveDrives = 1 },
                new PartnerRankingMetric { Rank = 2, CompanyName = "Infosys Limited", Tier = "Mass Recruiter", OffersMade = 285, AveragePackageLpa = 6.8, HighestPackageLpa = 9.5, ActiveDrives = 0 },
                new PartnerRankingMetric { Rank = 3, CompanyName = "Deloitte USI", Tier = "Tier 2", OffersMade = 110, AveragePackageLpa = 9.5, HighestPackageLpa = 14.0, ActiveDrives = 1 },
                new PartnerRankingMetric { Rank = 4, CompanyName = "Amazon", Tier = "Tier 1 (Dream)", OffersMade = 80, AveragePackageLpa = 26.5, HighestPackageLpa = 45.0, ActiveDrives = 3 },
                new PartnerRankingMetric { Rank = 5, CompanyName = "Microsoft", Tier = "Tier 1 (Dream)", OffersMade = 52, AveragePackageLpa = 28.0, HighestPackageLpa = 44.0, ActiveDrives = 2 },
                new PartnerRankingMetric { Rank = 6, CompanyName = "Google", Tier = "Tier 1 (Dream)", OffersMade = 45, AveragePackageLpa = 32.5, HighestPackageLpa = 48.0, ActiveDrives = 2 },
                new PartnerRankingMetric { Rank = 7, CompanyName = "Cisco Systems", Tier = "Tier 1 (Dream)", OffersMade = 35, AveragePackageLpa = 19.5, HighestPackageLpa = 27.0, ActiveDrives = 1 },
                new PartnerRankingMetric { Rank = 8, CompanyName = "Goldman Sachs", Tier = "Tier 1 (Dream)", OffersMade = 28, AveragePackageLpa = 24.0, HighestPackageLpa = 36.0, ActiveDrives = 1 }
            };
        }

        public string GenerateCsvExport()
        {
            var sb = new StringBuilder();
            sb.AppendLine("Institutional Placement Analytics & Seasonal Intelligence Report");
            sb.AppendLine("Generated on: " + DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss") + " UTC");
            sb.AppendLine();

            sb.AppendLine("Global Summary Metrics");
            sb.AppendLine("Total Registered Students," + TotalStudents);
            sb.AppendLine("Eligible Candidates," + EligibleStudents);
            sb.AppendLine("Placed Students," + PlacedStudents);
            sb.AppendLine("Total Offers Extended," + TotalOffers);
            sb.AppendLine("Global Placement Rate (%)," + GlobalPlacementRate.ToString("0.0", CultureInfo.InvariantCulture) + "%");
            sb.AppendLine("Average Overall CTC (LPA)," + AverageOverallPackageLpa.ToString("0.0", CultureInfo.InvariantCulture));
            sb.AppendLine("Highest CTC (LPA)," + HighestOverallPackageLpa.ToString("0.0", CultureInfo.InvariantCulture));
            sb.AppendLine();

            sb.AppendLine("Department Performance Breakdown");
            sb.AppendLine("Department,Total Students,Placed Students,Placement Rate (%),Average Package (LPA),Highest Package (LPA),Top Recruiter");
            foreach (var d in GetDepartmentMetrics())
            {
                sb.AppendFormat(CultureInfo.InvariantCulture,
                    "\"{0}\",{1},{2},{3:0.0}%,{4:0.0},{5:0.0},\"{6}\"\r\n",
                    d.DepartmentName, d.TotalStudents, d.PlacedCount, d.PlacementPercentage, d.AveragePackageLpa, d.HighestPackageLpa, d.TopRecruiter);
            }
            sb.AppendLine();

            sb.AppendLine("Salary Compensation Distribution");
            sb.AppendLine("Salary Bracket,Total Offers,Percentage (%)");
            foreach (var s in GetSalaryDistribution())
            {
                sb.AppendFormat(CultureInfo.InvariantCulture,
                    "\"{0}\",{1},{2:0.0}%\r\n", s.BracketLabel, s.OffersCount, s.Percentage);
            }
            sb.AppendLine();

            sb.AppendLine("Top Hiring Corporate Partners");
            sb.AppendLine("Rank,Company Name,Tier,Offers Extended,Average CTC (LPA),Highest CTC (LPA),Active Drives");
            foreach (var p in GetPartnerRankings())
            {
                sb.AppendFormat(CultureInfo.InvariantCulture,
                    "{0},\"{1}\",\"{2}\",{3},{4:0.0},{5:0.0},{6}\r\n",
                    p.Rank, p.CompanyName, p.Tier, p.OffersMade, p.AveragePackageLpa, p.HighestPackageLpa, p.ActiveDrives);
            }

            return sb.ToString();
        }
    }
}
