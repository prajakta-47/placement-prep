using System;

namespace PlacementPrep.Helpers
{
    public class AppUser
    {
        public int UserId { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string EnrollmentId { get; set; }
        public string UserRole { get; set; }
        public string Department { get; set; }
        public string AccountStatus { get; set; }
        public bool IsOnboardingCompleted { get; set; }
        public string ProfilePictureUrl { get; set; }
        public DateTime? LastActiveAt { get; set; }
        public DateTime CreatedAt { get; set; }

        public string Initials
        {
            get
            {
                if (string.IsNullOrWhiteSpace(FullName))
                {
                    return "?";
                }

                var parts = FullName.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                if (parts.Length == 1)
                {
                    return parts[0].Substring(0, 1).ToUpperInvariant();
                }

                return (parts[0].Substring(0, 1) + parts[parts.Length - 1].Substring(0, 1)).ToUpperInvariant();
            }
        }

        public string DisplayUid
        {
            get
            {
                if (!string.IsNullOrWhiteSpace(EnrollmentId))
                {
                    return EnrollmentId;
                }

                return "UID-" + UserId.ToString("D5");
            }
        }

        public string AvatarClass
        {
            get
            {
                switch (Math.Abs(UserId) % 5)
                {
                    case 1: return "users-avatar avatar-teal";
                    case 2: return "users-avatar avatar-mint";
                    case 3: return "users-avatar avatar-blue";
                    case 4: return "users-avatar avatar-purple";
                    default: return "users-avatar avatar-slate";
                }
            }
        }
    }

    public class UserKpiSummary
    {
        public int TotalAccounts { get; set; }
        public int FacultyMembers { get; set; }
        public int EnrolledStudents { get; set; }
        public int Administrators { get; set; }
        public int ActiveCount { get; set; }
        public int FacultyDepartments { get; set; }
    }

    public class PagedResult<T>
    {
        public System.Collections.Generic.IList<T> Items { get; set; }
        public int TotalCount { get; set; }
        public int PageIndex { get; set; }
        public int PageSize { get; set; }

        public int TotalPages
        {
            get
            {
                if (PageSize <= 0)
                {
                    return 0;
                }

                return (int)Math.Ceiling(TotalCount / (double)PageSize);
            }
        }
    }

    public class UserImportResult
    {
        public int Created { get; set; }
        public int Skipped { get; set; }
        public int Failed { get; set; }
        public System.Collections.Generic.List<string> Messages { get; set; }

        public UserImportResult()
        {
            Messages = new System.Collections.Generic.List<string>();
        }
    }
}
