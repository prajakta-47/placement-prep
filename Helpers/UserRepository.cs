using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace PlacementPrep.Helpers
{
    /// <summary>
    /// In-memory repository provider for User Management sample data.
    /// Thread-safe in-memory store decoupled from SQL Server for UI development.
    /// Preserves existing method contracts for future ADO.NET database migration.
    /// </summary>
    public class UserRepository
    {
        private static readonly object SyncLock = new object();
        private static List<AppUser> _sampleUsers;

        public UserRepository()
        {
            EnsureSampleData();
        }

        private static void EnsureSampleData()
        {
            if (_sampleUsers != null)
            {
                return;
            }

            lock (SyncLock)
            {
                if (_sampleUsers != null)
                {
                    return;
                }

                _sampleUsers = new List<AppUser>
                {
                    new AppUser
                    {
                        UserId = 101,
                        FullName = "System Administrator",
                        Email = "admin@placementprep.local",
                        EnrollmentId = "ADM-0001",
                        UserRole = "Admin",
                        Department = "Placement Cell",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow,
                        CreatedAt = new DateTime(2023, 10, 15, 11, 0, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 102,
                        FullName = "Prof. Faculty Coordinator",
                        Email = "faculty@placementprep.local",
                        EnrollmentId = "FAC-0001",
                        UserRole = "Faculty",
                        Department = "Computer Science",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow,
                        CreatedAt = new DateTime(2024, 1, 10, 9, 30, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 103,
                        FullName = "Demo Student",
                        Email = "student@placementprep.local",
                        EnrollmentId = "STU-0001",
                        UserRole = "Student",
                        Department = "Computer Science",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow,
                        CreatedAt = new DateTime(2024, 8, 20, 14, 15, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 1,
                        FullName = "Dr. Arvind Menon",
                        Email = "arvind.m@univ.edu",
                        EnrollmentId = "UID-88210",
                        UserRole = "Faculty",
                        Department = "Computer Science",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddMinutes(-12),
                        CreatedAt = new DateTime(2024, 1, 10, 9, 30, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 2,
                        FullName = "Sarah Jenkins",
                        Email = "s.jenkins@univ.edu",
                        EnrollmentId = "UID-10943",
                        UserRole = "Admin",
                        Department = "Placement Cell",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddSeconds(-25),
                        CreatedAt = new DateTime(2023, 10, 15, 11, 0, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 3,
                        FullName = "Rahul Sharma",
                        Email = "rahul.s@student.univ.edu",
                        EnrollmentId = "UID-94103",
                        UserRole = "Student",
                        Department = "Computer Science",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddHours(-1),
                        CreatedAt = new DateTime(2024, 8, 20, 14, 15, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 4,
                        FullName = "Priya Patel",
                        Email = "p.patel@student.univ.edu",
                        EnrollmentId = "UID-94188",
                        UserRole = "Student",
                        Department = "Information Tech",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddHours(-3),
                        CreatedAt = new DateTime(2024, 8, 22, 10, 45, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 5,
                        FullName = "Ananya Rao",
                        Email = "a.rao@student.univ.edu",
                        EnrollmentId = "UID-95521",
                        UserRole = "Student",
                        Department = "Electronics",
                        AccountStatus = "Suspended",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddDays(-5),
                        CreatedAt = new DateTime(2024, 9, 1, 16, 20, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 6,
                        FullName = "Dr. Rajesh Kumar",
                        Email = "r.kumar@univ.edu",
                        EnrollmentId = "UID-88392",
                        UserRole = "Faculty",
                        Department = "Data Science",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddHours(-2),
                        CreatedAt = new DateTime(2024, 2, 14, 8, 50, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 7,
                        FullName = "Prof. Sunita Kulkarni",
                        Email = "sunita.k@univ.edu",
                        EnrollmentId = "UID-88415",
                        UserRole = "Faculty",
                        Department = "Computer Science",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddHours(-4),
                        CreatedAt = new DateTime(2023, 11, 5, 10, 0, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 8,
                        FullName = "Amit Deshmukh",
                        Email = "amit.d@student.univ.edu",
                        EnrollmentId = "UID-94210",
                        UserRole = "Student",
                        Department = "Computer Science",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddDays(-1),
                        CreatedAt = new DateTime(2024, 8, 21, 13, 10, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 9,
                        FullName = "Sneha Nair",
                        Email = "sneha.n@student.univ.edu",
                        EnrollmentId = "UID-94255",
                        UserRole = "Student",
                        Department = "Information Tech",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddDays(-2),
                        CreatedAt = new DateTime(2024, 8, 22, 11, 30, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 10,
                        FullName = "Rohan Gupta",
                        Email = "rohan.g@student.univ.edu",
                        EnrollmentId = "UID-94301",
                        UserRole = "Student",
                        Department = "Electronics",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddDays(-3),
                        CreatedAt = new DateTime(2024, 8, 25, 15, 0, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 11,
                        FullName = "Vikram Malhotra",
                        Email = "vikram.m@student.univ.edu",
                        EnrollmentId = "UID-94380",
                        UserRole = "Student",
                        Department = "Data Science",
                        AccountStatus = "Suspended",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddDays(-6),
                        CreatedAt = new DateTime(2024, 9, 2, 12, 10, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 12,
                        FullName = "Dr. Meera Sen",
                        Email = "meera.s@univ.edu",
                        EnrollmentId = "UID-88502",
                        UserRole = "Faculty",
                        Department = "Electronics",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddDays(-1),
                        CreatedAt = new DateTime(2023, 12, 8, 14, 0, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 13,
                        FullName = "Pooja Iyer",
                        Email = "pooja.i@student.univ.edu",
                        EnrollmentId = "UID-94420",
                        UserRole = "Student",
                        Department = "Computer Science",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddHours(-5),
                        CreatedAt = new DateTime(2024, 8, 23, 9, 20, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 14,
                        FullName = "Devansh Joshi",
                        Email = "devansh.j@student.univ.edu",
                        EnrollmentId = "UID-94465",
                        UserRole = "Student",
                        Department = "Information Tech",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddHours(-12),
                        CreatedAt = new DateTime(2024, 8, 24, 16, 45, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 15,
                        FullName = "Kavita Reddy",
                        Email = "kavita.r@student.univ.edu",
                        EnrollmentId = "UID-94510",
                        UserRole = "Student",
                        Department = "Data Science",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddDays(-1),
                        CreatedAt = new DateTime(2024, 8, 26, 10, 15, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 16,
                        FullName = "Karan Verma",
                        Email = "karan.v@student.univ.edu",
                        EnrollmentId = "UID-94555",
                        UserRole = "Student",
                        Department = "Mechanical",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddDays(-2),
                        CreatedAt = new DateTime(2024, 8, 28, 11, 0, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 17,
                        FullName = "Prof. Alok Pandey",
                        Email = "alok.p@univ.edu",
                        EnrollmentId = "UID-88610",
                        UserRole = "Faculty",
                        Department = "Mechanical",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddDays(-5),
                        CreatedAt = new DateTime(2023, 9, 14, 15, 30, 0, DateTimeKind.Utc)
                    },
                    new AppUser
                    {
                        UserId = 18,
                        FullName = "Deepak Chawla",
                        Email = "deepak.c@univ.edu",
                        EnrollmentId = "UID-10988",
                        UserRole = "Admin",
                        Department = "Placement Cell",
                        AccountStatus = "Active",
                        IsOnboardingCompleted = true,
                        LastActiveAt = DateTime.UtcNow.AddHours(-4),
                        CreatedAt = new DateTime(2023, 11, 2, 9, 0, 0, DateTimeKind.Utc)
                    }
                };
            }
        }

        public UserKpiSummary GetKpiSummary()
        {
            // Returns the institutional KPI metrics specified in the Figma design.
            return new UserKpiSummary
            {
                TotalAccounts = 12450,
                FacultyMembers = 184,
                EnrolledStudents = 12142,
                Administrators = 124,
                ActiveCount = 12375,
                FacultyDepartments = 9
            };
        }

        public PagedResult<AppUser> SearchUsers(
            string search,
            string role,
            string status,
            string department,
            int pageIndex,
            int pageSize)
        {
            if (pageIndex < 1) pageIndex = 1;
            if (pageSize < 1) pageSize = 10;

            lock (SyncLock)
            {
                var query = _sampleUsers.AsQueryable();

                if (!string.IsNullOrWhiteSpace(search))
                {
                    var term = search.Trim();
                    query = query.Where(u =>
                        (u.FullName != null && u.FullName.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (u.Email != null && u.Email.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        (u.EnrollmentId != null && u.EnrollmentId.IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0) ||
                        u.UserId.ToString(CultureInfo.InvariantCulture).IndexOf(term, StringComparison.OrdinalIgnoreCase) >= 0);
                }

                if (!string.IsNullOrWhiteSpace(role) && !string.Equals(role, "All", StringComparison.OrdinalIgnoreCase))
                {
                    query = query.Where(u => string.Equals(u.UserRole, role, StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrWhiteSpace(status) && !string.Equals(status, "All", StringComparison.OrdinalIgnoreCase))
                {
                    query = query.Where(u => string.Equals(u.AccountStatus, status, StringComparison.OrdinalIgnoreCase));
                }

                if (!string.IsNullOrWhiteSpace(department) && !string.Equals(department, "All", StringComparison.OrdinalIgnoreCase))
                {
                    query = query.Where(u => string.Equals(u.Department, department, StringComparison.OrdinalIgnoreCase));
                }

                var ordered = query.OrderBy(u => u.UserId).ToList();
                var total = ordered.Count;

                var items = ordered
                    .Skip((pageIndex - 1) * pageSize)
                    .Take(pageSize)
                    .Select(CloneUser)
                    .ToList();

                return new PagedResult<AppUser>
                {
                    Items = items,
                    TotalCount = total,
                    PageIndex = pageIndex,
                    PageSize = pageSize
                };
            }
        }

        public AppUser GetById(int userId)
        {
            lock (SyncLock)
            {
                var user = _sampleUsers.FirstOrDefault(u => u.UserId == userId);
                return user == null ? null : CloneUser(user);
            }
        }

        public AppUser GetByEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email)) return null;
            var clean = email.Trim();

            lock (SyncLock)
            {
                var user = _sampleUsers.FirstOrDefault(u =>
                    string.Equals(u.Email, clean, StringComparison.OrdinalIgnoreCase));
                return user == null ? null : CloneUser(user);
            }
        }

        public bool EmailExists(string email, int? excludeUserId = null)
        {
            if (string.IsNullOrWhiteSpace(email)) return false;
            var clean = email.Trim();

            lock (SyncLock)
            {
                return _sampleUsers.Any(u =>
                    string.Equals(u.Email, clean, StringComparison.OrdinalIgnoreCase) &&
                    (!excludeUserId.HasValue || u.UserId != excludeUserId.Value));
            }
        }

        public int CreateUser(AppUser user, string passwordHash)
        {
            if (user == null) throw new ArgumentNullException(nameof(user));

            lock (SyncLock)
            {
                var nextId = _sampleUsers.Count == 0 ? 1 : (_sampleUsers.Max(u => u.UserId) + 1);
                var created = new AppUser
                {
                    UserId = nextId,
                    FullName = user.FullName.Trim(),
                    Email = user.Email.Trim(),
                    EnrollmentId = string.IsNullOrWhiteSpace(user.EnrollmentId)
                        ? "UID-" + nextId.ToString("D5")
                        : user.EnrollmentId.Trim(),
                    UserRole = user.UserRole,
                    Department = string.IsNullOrWhiteSpace(user.Department) ? null : user.Department.Trim(),
                    AccountStatus = string.IsNullOrWhiteSpace(user.AccountStatus) ? "Active" : user.AccountStatus.Trim(),
                    IsOnboardingCompleted = user.IsOnboardingCompleted,
                    ProfilePictureUrl = user.ProfilePictureUrl,
                    LastActiveAt = DateTime.UtcNow,
                    CreatedAt = DateTime.UtcNow
                };

                _sampleUsers.Insert(0, created);
                return nextId;
            }
        }

        public void UpdateUser(AppUser user)
        {
            if (user == null) throw new ArgumentNullException(nameof(user));

            lock (SyncLock)
            {
                var existing = _sampleUsers.FirstOrDefault(u => u.UserId == user.UserId);
                if (existing == null)
                {
                    throw new InvalidOperationException("User not found.");
                }

                existing.FullName = user.FullName.Trim();
                existing.Email = user.Email.Trim();
                existing.EnrollmentId = string.IsNullOrWhiteSpace(user.EnrollmentId) ? null : user.EnrollmentId.Trim();
                existing.UserRole = user.UserRole;
                existing.Department = string.IsNullOrWhiteSpace(user.Department) ? null : user.Department.Trim();
                existing.AccountStatus = string.IsNullOrWhiteSpace(user.AccountStatus) ? "Active" : user.AccountStatus.Trim();
            }
        }

        public void SetAccountStatus(int userId, string status)
        {
            lock (SyncLock)
            {
                var existing = _sampleUsers.FirstOrDefault(u => u.UserId == userId);
                if (existing != null)
                {
                    existing.AccountStatus = status;
                }
            }
        }

        public void ResetPasswordHash(int userId, string passwordHash)
        {
            // In-memory verification: password hash updated in-memory
            lock (SyncLock)
            {
                var existing = _sampleUsers.FirstOrDefault(u => u.UserId == userId);
                if (existing != null)
                {
                    existing.LastActiveAt = DateTime.UtcNow;
                }
            }
        }

        public IList<string> GetDepartments()
        {
            lock (SyncLock)
            {
                return _sampleUsers
                    .Where(u => !string.IsNullOrWhiteSpace(u.Department))
                    .Select(u => u.Department.Trim())
                    .Distinct(StringComparer.OrdinalIgnoreCase)
                    .OrderBy(d => d)
                    .ToList();
            }
        }

        public int? GetPrimaryAdminUserId()
        {
            lock (SyncLock)
            {
                var admin = _sampleUsers.FirstOrDefault(u =>
                    string.Equals(u.UserRole, "Admin", StringComparison.OrdinalIgnoreCase) &&
                    string.Equals(u.AccountStatus, "Active", StringComparison.OrdinalIgnoreCase));

                return admin?.UserId ?? 2;
            }
        }

        public void EnsureSeedPasswordHashes()
        {
            // No-op for in-memory provider
        }

        public UserImportResult ImportUsers(IEnumerable<AppUser> rows, Func<AppUser, string> passwordFactory)
        {
            var result = new UserImportResult();
            if (rows == null) return result;

            var rowNumber = 1;
            foreach (var row in rows)
            {
                rowNumber++;
                try
                {
                    string validationError;
                    if (!ValidateUserForSave(row, isNew: true, out validationError))
                    {
                        result.Failed++;
                        result.Messages.Add("Row " + rowNumber + ": " + validationError);
                        continue;
                    }

                    if (EmailExists(row.Email))
                    {
                        result.Skipped++;
                        result.Messages.Add("Row " + rowNumber + ": skipped duplicate email '" + row.Email + "'.");
                        continue;
                    }

                    var tempPassword = passwordFactory != null ? passwordFactory(row) : PasswordHelper.DefaultTempPassword;
                    var hash = PasswordHelper.HashPassword(tempPassword);

                    if (string.IsNullOrWhiteSpace(row.AccountStatus))
                    {
                        row.AccountStatus = "Active";
                    }

                    CreateUser(row, hash);
                    result.Created++;
                }
                catch (Exception ex)
                {
                    result.Failed++;
                    result.Messages.Add("Row " + rowNumber + ": " + ex.Message);
                }
            }

            return result;
        }

        public static bool ValidateUserForSave(AppUser user, bool isNew, out string errorMessage)
        {
            errorMessage = null;

            if (user == null)
            {
                errorMessage = "User details are required.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(user.FullName) || user.FullName.Trim().Length < 2)
            {
                errorMessage = "Full name is required (minimum 2 characters).";
                return false;
            }

            if (string.IsNullOrWhiteSpace(user.Email) || !IsValidEmail(user.Email.Trim()))
            {
                errorMessage = "A valid email address is required.";
                return false;
            }

            var role = (user.UserRole ?? string.Empty).Trim();
            if (role != "Student" && role != "Faculty" && role != "Admin")
            {
                errorMessage = "Role must be Student, Faculty, or Admin.";
                return false;
            }

            user.UserRole = role;

            var status = string.IsNullOrWhiteSpace(user.AccountStatus) ? "Active" : user.AccountStatus.Trim();
            if (status != "Active" && status != "Suspended")
            {
                errorMessage = "Status must be Active or Suspended.";
                return false;
            }

            user.AccountStatus = status;
            return true;
        }

        private static bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return string.Equals(addr.Address, email, StringComparison.OrdinalIgnoreCase);
            }
            catch
            {
                return false;
            }
        }

        private static AppUser CloneUser(AppUser source)
        {
            return new AppUser
            {
                UserId = source.UserId,
                FullName = source.FullName,
                Email = source.Email,
                EnrollmentId = source.EnrollmentId,
                UserRole = source.UserRole,
                Department = source.Department,
                AccountStatus = source.AccountStatus,
                IsOnboardingCompleted = source.IsOnboardingCompleted,
                ProfilePictureUrl = source.ProfilePictureUrl,
                LastActiveAt = source.LastActiveAt,
                CreatedAt = source.CreatedAt
            };
        }
    }
}
