using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;

namespace PlacementPrep.Helpers
{
    public class DemoCredential
    {
        public string Email { get; set; }
        public string Password { get; set; }
        public string Role { get; set; }
        public string DisplayName { get; set; }
    }

    /// <summary>
    /// Centralized authentication and authorization helper for development demo credentials and role-based page protection.
    /// </summary>
    public static class AuthHelper
    {
        public const string AdminEmail = "admin@placementprep.local";
        public const string AdminPassword = "Admin@123";

        public const string FacultyEmail = "faculty@placementprep.local";
        public const string FacultyPassword = "Faculty@123";

        public const string StudentEmail = "student@placementprep.local";
        public const string StudentPassword = "Student@123";

        public static readonly IReadOnlyList<DemoCredential> DemoAccounts = new List<DemoCredential>
        {
            new DemoCredential
            {
                Email = AdminEmail,
                Password = AdminPassword,
                Role = "Admin",
                DisplayName = "Administrator"
            },
            new DemoCredential
            {
                Email = FacultyEmail,
                Password = FacultyPassword,
                Role = "Faculty",
                DisplayName = "Faculty Coordinator"
            },
            new DemoCredential
            {
                Email = StudentEmail,
                Password = StudentPassword,
                Role = "Student",
                DisplayName = "Student Candidate"
            }
        };

        /// <summary>
        /// Validates login credentials explicitly.
        /// Email comparison is case-insensitive; password comparison must match exactly.
        /// </summary>
        public static bool ValidateCredentials(string email, string password, out string role, out string displayName)
        {
            role = null;
            displayName = null;

            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrEmpty(password))
            {
                return false;
            }

            var cleanEmail = email.Trim();

            foreach (var cred in DemoAccounts)
            {
                if (string.Equals(cred.Email, cleanEmail, StringComparison.OrdinalIgnoreCase))
                {
                    if (string.Equals(cred.Password, password, StringComparison.Ordinal))
                    {
                        role = cred.Role;
                        displayName = cred.DisplayName;
                        return true;
                    }
                    return false;
                }
            }

            return false;
        }

        /// <summary>
        /// Populates active session state upon successful authentication.
        /// </summary>
        public static void SetAuthSession(HttpSessionState session, string email, string role, string displayName = null)
        {
            if (session == null) return;

            session["UserEmail"] = email;
            session["UserRole"] = role;
            session["UserName"] = displayName ?? email;

            if (string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase))
            {
                session["AdminFullName"] = displayName ?? "Administrator";
                session["AdminEmail"] = email;
            }
            else if (string.Equals(role, "Faculty", StringComparison.OrdinalIgnoreCase))
            {
                session["FacultyFullName"] = displayName ?? "Faculty Coordinator";
                session["FacultyEmail"] = email;
            }
            else if (string.Equals(role, "Student", StringComparison.OrdinalIgnoreCase))
            {
                session["StudentFullName"] = displayName ?? "Student Candidate";
                session["StudentEmail"] = email;
            }
        }

        /// <summary>
        /// Completely clears and abandons the authentication session upon logout.
        /// </summary>
        public static void SignOut(HttpSessionState session)
        {
            if (session == null) return;
            session.Clear();
            session.Abandon();
        }

        /// <summary>
        /// Returns the verified route destination for each role.
        /// </summary>
        public static string GetDashboardUrl(string role)
        {
            if (string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase))
            {
                return "~/Admin/AdminDashboard.aspx";
            }
            if (string.Equals(role, "Faculty", StringComparison.OrdinalIgnoreCase))
            {
                return "~/Faculty/Dashboard.aspx";
            }
            if (string.Equals(role, "Student", StringComparison.OrdinalIgnoreCase))
            {
                return "~/Student/Dashboard.aspx";
            }

            return "~/Login.aspx";
        }

        /// <summary>
        /// Server-side role guard for master pages and individual pages.
        /// If not authenticated, redirects to Login.aspx.
        /// If authenticated but lacking the required role, redirects to the user's permitted dashboard.
        /// </summary>
        public static bool CheckAuthorization(HttpSessionState session, HttpResponse response, string requiredRole)
        {
            if (session == null || response == null) return false;

            var userRole = session["UserRole"] as string;

            // Unauthenticated users are redirected to Login.aspx
            if (string.IsNullOrEmpty(userRole))
            {
                response.Redirect("~/Login.aspx", true);
                return false;
            }

            // Role mismatch redirect to authorized dashboard
            if (!string.Equals(userRole, requiredRole, StringComparison.OrdinalIgnoreCase))
            {
                response.Redirect(GetDashboardUrl(userRole), true);
                return false;
            }

            return true;
        }
    }
}
