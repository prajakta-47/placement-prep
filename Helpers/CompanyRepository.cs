using System;
using System.Collections.Generic;
using System.Linq;

namespace PlacementPrep.Helpers
{
    public class CompanyKpiSummary
    {
        public int TotalCompanies { get; set; }
        public int ActiveHiringCount { get; set; }
        public int ActiveDrivesCount { get; set; }
        public int TotalOffersPlaced { get; set; }
    }

    public class CompanySearchResult
    {
        public List<CompanyItem> Items { get; set; }
        public int TotalCount { get; set; }
        public int PageIndex { get; set; }
        public int PageSize { get; set; }
        public int TotalPages { get; set; }
    }

    public class CompanyRepository
    {
        private static readonly object SyncLock = new object();
        private static List<CompanyItem> _companies;
        private static int _nextId = 100;

        static CompanyRepository()
        {
            SeedSampleCompanies();
        }

        public CompanyKpiSummary GetKpiSummary()
        {
            lock (SyncLock)
            {
                return new CompanyKpiSummary
                {
                    TotalCompanies = _companies.Count,
                    ActiveHiringCount = _companies.Count(c => string.Equals(c.HiringStatus, "Hiring This Season", StringComparison.OrdinalIgnoreCase)),
                    ActiveDrivesCount = _companies.Sum(c => c.ActiveDrivesCount),
                    TotalOffersPlaced = _companies.Sum(c => c.TotalOffersMade)
                };
            }
        }

        public List<string> GetIndustries()
        {
            lock (SyncLock)
            {
                return _companies
                    .Select(c => c.Industry)
                    .Where(i => !string.IsNullOrWhiteSpace(i))
                    .Distinct(StringComparer.OrdinalIgnoreCase)
                    .OrderBy(i => i)
                    .ToList();
            }
        }

        public List<string> GetHiringStatuses()
        {
            return new List<string>
            {
                "Hiring This Season",
                "Active Partner",
                "Upcoming",
                "Inactive"
            };
        }

        public bool CompanyExists(string companyName, int? excludeCompanyId)
        {
            if (string.IsNullOrWhiteSpace(companyName)) return false;

            lock (SyncLock)
            {
                return _companies.Any(c =>
                    string.Equals(c.CompanyName, companyName.Trim(), StringComparison.OrdinalIgnoreCase) &&
                    (!excludeCompanyId.HasValue || c.CompanyId != excludeCompanyId.Value));
            }
        }

        public CompanySearchResult Search(string query, string industry, string hiringStatus, int pageIndex, int pageSize)
        {
            lock (SyncLock)
            {
                var q = _companies.AsQueryable();

                if (!string.IsNullOrWhiteSpace(query))
                {
                    var term = query.Trim();
                    q = q.Where(c =>
                        (c.CompanyName != null && c.CompanyName.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (c.Industry != null && c.Industry.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (c.RecruiterName != null && c.RecruiterName.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (c.Locations != null && c.Locations.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0));
                }

                if (!string.IsNullOrWhiteSpace(industry) && !string.Equals(industry, "All", StringComparison.OrdinalIgnoreCase))
                {
                    q = q.Where(c => string.Equals(c.Industry, industry.Trim(), StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrWhiteSpace(hiringStatus) && !string.Equals(hiringStatus, "All", StringComparison.OrdinalIgnoreCase))
                {
                    q = q.Where(c => string.Equals(c.HiringStatus, hiringStatus.Trim(), StringComparison.OrdinalIgnoreCase));
                }

                var list = q.OrderByDescending(c => c.ActiveDrivesCount)
                            .ThenBy(c => c.CompanyName)
                            .ToList();

                var total = list.Count;
                var totalPages = (int)Math.Ceiling((double)total / pageSize);
                if (totalPages == 0) totalPages = 1;
                if (pageIndex < 1) pageIndex = 1;
                if (pageIndex > totalPages) pageIndex = totalPages;

                var pageItems = list.Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList();

                return new CompanySearchResult
                {
                    Items = pageItems,
                    TotalCount = total,
                    PageIndex = pageIndex,
                    PageSize = pageSize,
                    TotalPages = totalPages
                };
            }
        }

        public CompanyItem GetById(int companyId)
        {
            lock (SyncLock)
            {
                var original = _companies.FirstOrDefault(c => c.CompanyId == companyId);
                return original == null ? null : CloneCompany(original);
            }
        }

        public bool Add(CompanyItem item, out string error)
        {
            error = null;
            if (item == null)
            {
                error = "Company payload is required.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(item.CompanyName))
            {
                error = "Company name is required.";
                return false;
            }

            lock (SyncLock)
            {
                if (CompanyExists(item.CompanyName, null))
                {
                    error = "A company with this name is already registered.";
                    return false;
                }

                item.CompanyId = ++_nextId;
                item.CreatedAt = DateTime.UtcNow;
                item.UpdatedAt = DateTime.UtcNow;

                if (string.IsNullOrWhiteSpace(item.AvatarClass))
                {
                    item.AvatarClass = PickAvatarClass(item.CompanyId);
                }

                _companies.Add(CloneCompany(item));
                return true;
            }
        }

        public bool Update(CompanyItem item, out string error)
        {
            error = null;
            if (item == null)
            {
                error = "Company payload is required.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(item.CompanyName))
            {
                error = "Company name is required.";
                return false;
            }

            lock (SyncLock)
            {
                var existing = _companies.FirstOrDefault(c => c.CompanyId == item.CompanyId);
                if (existing == null)
                {
                    error = "Company record not found.";
                    return false;
                }

                if (CompanyExists(item.CompanyName, item.CompanyId))
                {
                    error = "Another company with this name already exists.";
                    return false;
                }

                existing.CompanyName = item.CompanyName.Trim();
                existing.Industry = item.Industry;
                existing.WebsiteUrl = item.WebsiteUrl;
                existing.RecruiterName = item.RecruiterName;
                existing.RecruiterEmail = item.RecruiterEmail;
                existing.RecruiterPhone = item.RecruiterPhone;
                existing.HiringStatus = item.HiringStatus;
                existing.Tier = item.Tier;
                existing.ActiveDrivesCount = item.ActiveDrivesCount;
                existing.TotalOffersMade = item.TotalOffersMade;
                existing.AveragePackageLpa = item.AveragePackageLpa;
                existing.HighestPackageLpa = item.HighestPackageLpa;
                existing.About = item.About;
                existing.Locations = item.Locations;
                existing.UpdatedAt = DateTime.UtcNow;

                return true;
            }
        }

        public bool Delete(int companyId, out string error)
        {
            error = null;
            lock (SyncLock)
            {
                var existing = _companies.FirstOrDefault(c => c.CompanyId == companyId);
                if (existing == null)
                {
                    error = "Company not found.";
                    return false;
                }

                _companies.Remove(existing);
                return true;
            }
        }

        public bool ToggleHiringStatus(int companyId)
        {
            lock (SyncLock)
            {
                var existing = _companies.FirstOrDefault(c => c.CompanyId == companyId);
                if (existing == null) return false;

                if (string.Equals(existing.HiringStatus, "Hiring This Season", StringComparison.OrdinalIgnoreCase))
                {
                    existing.HiringStatus = "Inactive";
                }
                else
                {
                    existing.HiringStatus = "Hiring This Season";
                }

                existing.UpdatedAt = DateTime.UtcNow;
                return true;
            }
        }

        private static CompanyItem CloneCompany(CompanyItem c)
        {
            return new CompanyItem
            {
                CompanyId = c.CompanyId,
                CompanyName = c.CompanyName,
                Industry = c.Industry,
                WebsiteUrl = c.WebsiteUrl,
                RecruiterName = c.RecruiterName,
                RecruiterEmail = c.RecruiterEmail,
                RecruiterPhone = c.RecruiterPhone,
                HiringStatus = c.HiringStatus,
                Tier = c.Tier,
                ActiveDrivesCount = c.ActiveDrivesCount,
                TotalOffersMade = c.TotalOffersMade,
                AveragePackageLpa = c.AveragePackageLpa,
                HighestPackageLpa = c.HighestPackageLpa,
                About = c.About,
                Locations = c.Locations,
                AvatarClass = c.AvatarClass,
                CreatedAt = c.CreatedAt,
                UpdatedAt = c.UpdatedAt
            };
        }

        private static string PickAvatarClass(int id)
        {
            var classes = new[]
            {
                "users-avatar avatar-teal",
                "users-avatar avatar-blue",
                "users-avatar avatar-purple",
                "users-avatar avatar-orange",
                "users-avatar avatar-mint",
                "users-avatar avatar-slate"
            };
            return classes[Math.Abs(id) % classes.Length];
        }

        private static void SeedSampleCompanies()
        {
            _companies = new List<CompanyItem>
            {
                new CompanyItem
                {
                    CompanyId = 1,
                    CompanyName = "Google",
                    Industry = "Software & Internet",
                    WebsiteUrl = "https://careers.google.com",
                    RecruiterName = "Priyanka Sen",
                    RecruiterEmail = "priyanka.sen@google.recruitment.com",
                    RecruiterPhone = "+91 98450 11223",
                    HiringStatus = "Hiring This Season",
                    Tier = "Tier 1 (Dream)",
                    ActiveDrivesCount = 2,
                    TotalOffersMade = 45,
                    AveragePackageLpa = 32.5,
                    HighestPackageLpa = 48.0,
                    About = "Global technology leader in search, cloud systems, generative AI, and consumer hardware with worldwide engineering campuses.",
                    Locations = "Bangalore, Hyderabad",
                    AvatarClass = "users-avatar avatar-teal",
                    CreatedAt = DateTime.UtcNow.AddDays(-180),
                    UpdatedAt = DateTime.UtcNow.AddDays(-2)
                },
                new CompanyItem
                {
                    CompanyId = 2,
                    CompanyName = "Microsoft",
                    Industry = "Cloud & Enterprise IT",
                    WebsiteUrl = "https://careers.microsoft.com",
                    RecruiterName = "Anand Mehra",
                    RecruiterEmail = "anand.mehra@microsoft.campus.com",
                    RecruiterPhone = "+91 98200 44556",
                    HiringStatus = "Hiring This Season",
                    Tier = "Tier 1 (Dream)",
                    ActiveDrivesCount = 2,
                    TotalOffersMade = 52,
                    AveragePackageLpa = 28.0,
                    HighestPackageLpa = 44.0,
                    About = "Pioneer in personal computing, enterprise cloud infrastructure (Azure), operating systems, and developer platforms.",
                    Locations = "Hyderabad, Bangalore, Noida",
                    AvatarClass = "users-avatar avatar-blue",
                    CreatedAt = DateTime.UtcNow.AddDays(-170),
                    UpdatedAt = DateTime.UtcNow.AddDays(-3)
                },
                new CompanyItem
                {
                    CompanyId = 3,
                    CompanyName = "Amazon",
                    Industry = "E-Commerce & Cloud",
                    WebsiteUrl = "https://amazon.jobs",
                    RecruiterName = "Rituja Kulkarni",
                    RecruiterEmail = "rituja.k@amazon-recruiting.com",
                    RecruiterPhone = "+91 97660 77889",
                    HiringStatus = "Hiring This Season",
                    Tier = "Tier 1 (Dream)",
                    ActiveDrivesCount = 3,
                    TotalOffersMade = 80,
                    AveragePackageLpa = 26.5,
                    HighestPackageLpa = 45.0,
                    About = "World leader in e-commerce, cloud computing (AWS), digital streaming, and applied machine learning.",
                    Locations = "Bangalore, Hyderabad, Chennai",
                    AvatarClass = "users-avatar avatar-orange",
                    CreatedAt = DateTime.UtcNow.AddDays(-160),
                    UpdatedAt = DateTime.UtcNow.AddDays(-1)
                },
                new CompanyItem
                {
                    CompanyId = 4,
                    CompanyName = "Goldman Sachs",
                    Industry = "FinTech & Banking",
                    WebsiteUrl = "https://goldmansachs.com/careers",
                    RecruiterName = "Siddharth Jain",
                    RecruiterEmail = "siddharth.jain@gs.campus.com",
                    RecruiterPhone = "+91 99300 22110",
                    HiringStatus = "Hiring This Season",
                    Tier = "Tier 1 (Dream)",
                    ActiveDrivesCount = 1,
                    TotalOffersMade = 28,
                    AveragePackageLpa = 24.0,
                    HighestPackageLpa = 36.0,
                    About = "Global investment banking, securities, and investment management firm engineering mission-critical quantitative systems.",
                    Locations = "Bangalore, Hyderabad",
                    AvatarClass = "users-avatar avatar-mint",
                    CreatedAt = DateTime.UtcNow.AddDays(-150),
                    UpdatedAt = DateTime.UtcNow.AddDays(-5)
                },
                new CompanyItem
                {
                    CompanyId = 5,
                    CompanyName = "Deloitte USI",
                    Industry = "Consulting & Analytics",
                    WebsiteUrl = "https://deloitte.com/careers",
                    RecruiterName = "Meera Nambiar",
                    RecruiterEmail = "mnambiar@deloitte.usi.com",
                    RecruiterPhone = "+91 98110 33445",
                    HiringStatus = "Active Partner",
                    Tier = "Tier 2",
                    ActiveDrivesCount = 1,
                    TotalOffersMade = 110,
                    AveragePackageLpa = 9.5,
                    HighestPackageLpa = 14.0,
                    About = "Top global professional services firm providing audit, consulting, financial advisory, and enterprise cloud transformation.",
                    Locations = "Hyderabad, Bangalore, Mumbai, Gurgaon",
                    AvatarClass = "users-avatar avatar-purple",
                    CreatedAt = DateTime.UtcNow.AddDays(-140),
                    UpdatedAt = DateTime.UtcNow.AddDays(-8)
                },
                new CompanyItem
                {
                    CompanyId = 6,
                    CompanyName = "Tata Consultancy Services",
                    Industry = "IT Services & Consulting",
                    WebsiteUrl = "https://tcs.com/careers",
                    RecruiterName = "Rajesh Verma",
                    RecruiterEmail = "rajesh.v@tcs-campus.com",
                    RecruiterPhone = "+91 98711 55667",
                    HiringStatus = "Active Partner",
                    Tier = "Mass Recruiter",
                    ActiveDrivesCount = 1,
                    TotalOffersMade = 340,
                    AveragePackageLpa = 7.2,
                    HighestPackageLpa = 11.5,
                    About = "Multinational IT consulting and services giant driving large-scale digital business reinvention for Fortune 500 enterprises.",
                    Locations = "Pan-India",
                    AvatarClass = "users-avatar avatar-slate",
                    CreatedAt = DateTime.UtcNow.AddDays(-130),
                    UpdatedAt = DateTime.UtcNow.AddDays(-12)
                },
                new CompanyItem
                {
                    CompanyId = 7,
                    CompanyName = "Infosys Limited",
                    Industry = "IT Services & Consulting",
                    WebsiteUrl = "https://infosys.com/careers",
                    RecruiterName = "Kavita Rao",
                    RecruiterEmail = "kavita.rao@infosys-talent.com",
                    RecruiterPhone = "+91 99450 66778",
                    HiringStatus = "Upcoming",
                    Tier = "Mass Recruiter",
                    ActiveDrivesCount = 0,
                    TotalOffersMade = 285,
                    AveragePackageLpa = 6.8,
                    HighestPackageLpa = 9.5,
                    About = "Global leader in next-generation digital services and consulting with proprietary enterprise AI and cloud suites.",
                    Locations = "Bangalore, Pune, Hyderabad, Mysore",
                    AvatarClass = "users-avatar avatar-blue",
                    CreatedAt = DateTime.UtcNow.AddDays(-120),
                    UpdatedAt = DateTime.UtcNow.AddDays(-15)
                },
                new CompanyItem
                {
                    CompanyId = 8,
                    CompanyName = "Cisco Systems",
                    Industry = "Hardware & Embedded",
                    WebsiteUrl = "https://cisco.com/careers",
                    RecruiterName = "Vikram Singhania",
                    RecruiterEmail = "vsinghania@cisco-university.com",
                    RecruiterPhone = "+91 98860 88990",
                    HiringStatus = "Active Partner",
                    Tier = "Tier 1 (Dream)",
                    ActiveDrivesCount = 1,
                    TotalOffersMade = 35,
                    AveragePackageLpa = 19.5,
                    HighestPackageLpa = 27.0,
                    About = "Worldwide networking leader transforming how people connect, communicate, and collaborate across enterprise systems.",
                    Locations = "Bangalore",
                    AvatarClass = "users-avatar avatar-teal",
                    CreatedAt = DateTime.UtcNow.AddDays(-110),
                    UpdatedAt = DateTime.UtcNow.AddDays(-4)
                }
            };
        }
    }
}
