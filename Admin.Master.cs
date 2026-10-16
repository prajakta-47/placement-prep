using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class AdminMaster : MasterPage
    {
        /// <summary>
        /// Sidebar / bottom nav keys mapped to page file names (related detail pages
        /// highlight their parent). Matching is case-insensitive and file-name based
        /// so it survives postbacks and query-string changes.
        /// </summary>
        private static readonly Dictionary<string, string[]> SideNavPages =
            new Dictionary<string, string[]>(StringComparer.OrdinalIgnoreCase)
            {
                {
                    "overview",
                    new[] { "admindashboard.aspx" }
                },
                {
                    "users",
                    new[] { "manageusers.aspx", "adduser.aspx", "edituser.aspx", "userdetails.aspx" }
                },
                {
                    "questions",
                    new[]
                    {
                        "questionbank.aspx",
                        "centralquestionbank.aspx",
                        "aptitudequestions.aspx",
                        "technicalquestions.aspx",
                        "codingproblems.aspx",
                        "codingquestions.aspx",
                        "aptitudequestioneditor.aspx",
                        "technicalquestioneditor.aspx",
                        "codingproblemeditor.aspx",
                        "addquestion.aspx",
                        "editquestion.aspx"
                    }
                },
                {
                    "tests",
                    new[]
                    {
                        "managetests.aspx",
                        "createassessment.aspx",
                        "createtest.aspx",
                        "questionselection.aspx",
                        "assessmentpreview.aspx",
                        "testdetails.aspx"
                    }
                },
                {
                    "students",
                    new[] { "managestudents.aspx", "studentdetails.aspx", "studentdossier.aspx" }
                },
                {
                    "companies",
                    new[]
                    {
                        "managecompanies.aspx",
                        "companydetails.aspx",
                        "managedrives.aspx",
                        "placementdrives.aspx",
                        "drivedetails.aspx",
                        "addcompany.aspx",
                        "editcompany.aspx"
                    }
                },
                {
                    "reports",
                    new[] { "reports.aspx", "analytics.aspx" }
                },
                {
                    "logs",
                    new[] { "systemlogs.aspx" }
                },
                {
                    "help",
                    new[] { "help.aspx", "helpcenter.aspx" }
                },
                {
                    "settings",
                    new[] { "settings.aspx" }
                }
            };

        /// <summary>
        /// Top header nav keys matching Figma reference (Dashboard, Question Bank, Tests, Students, Companies).
        /// </summary>
        private static readonly Dictionary<string, string[]> TopNavPages =
            new Dictionary<string, string[]>(StringComparer.OrdinalIgnoreCase)
            {
                {
                    "dashboard",
                    new[] { "admindashboard.aspx" }
                },
                {
                    "questions",
                    new[]
                    {
                        "questionbank.aspx",
                        "centralquestionbank.aspx",
                        "aptitudequestions.aspx",
                        "technicalquestions.aspx",
                        "codingproblems.aspx",
                        "codingquestions.aspx",
                        "aptitudequestioneditor.aspx",
                        "technicalquestioneditor.aspx",
                        "codingproblemeditor.aspx",
                        "addquestion.aspx",
                        "editquestion.aspx"
                    }
                },
                {
                    "tests",
                    new[]
                    {
                        "managetests.aspx",
                        "createassessment.aspx",
                        "createtest.aspx",
                        "questionselection.aspx",
                        "assessmentpreview.aspx",
                        "testdetails.aspx"
                    }
                },
                {
                    "students",
                    new[] { "managestudents.aspx", "studentdetails.aspx", "studentdossier.aspx" }
                },
                {
                    "companies",
                    new[]
                    {
                        "managecompanies.aspx",
                        "companydetails.aspx",
                        "managedrives.aspx",
                        "placementdrives.aspx",
                        "drivedetails.aspx",
                        "addcompany.aspx",
                        "editcompany.aspx"
                    }
                },
                {
                    "curriculum",
                    new[] { "curriculum.aspx" }
                },
                {
                    "analytics",
                    new[] { "reports.aspx", "analytics.aspx" }
                }
            };

        private string _currentPage;

        protected void Page_Init(object sender, EventArgs e)
        {
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.Charset = "utf-8";

            PlacementPrep.Helpers.AuthHelper.CheckAuthorization(Session, Response, "Admin");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Resolve on every request (including postbacks) so the active highlight stays correct.
            _currentPage = GetCurrentPageFileName();

            if (Page != null && !string.IsNullOrWhiteSpace(Page.Title) && !Page.Title.Contains("Placement Prep"))
            {
                Page.Title = Page.Title + " | Placement Prep Admin";
            }
        }

        protected string GetSideNavClass(string navKey)
        {
            return IsNavActive(SideNavPages, navKey) ? "admin-side-link active" : "admin-side-link";
        }

        protected string GetBottomNavClass(string navKey)
        {
            return IsNavActive(SideNavPages, navKey)
                ? "admin-bottom-link active"
                : "admin-bottom-link";
        }

        protected string GetTopNavClass(string navKey)
        {
            return IsNavActive(TopNavPages, navKey) ? "admin-top-link active" : "admin-top-link";
        }

        private bool IsNavActive(Dictionary<string, string[]> map, string navKey)
        {
            if (string.IsNullOrEmpty(_currentPage))
            {
                _currentPage = GetCurrentPageFileName();
            }

            string[] pages;
            if (!map.TryGetValue(navKey, out pages) || pages == null || pages.Length == 0)
            {
                return false;
            }

            return pages.Any(p =>
                string.Equals(p, _currentPage, StringComparison.OrdinalIgnoreCase));
        }

        private string GetCurrentPageFileName()
        {
            var path = Request.AppRelativeCurrentExecutionFilePath;
            if (string.IsNullOrEmpty(path))
            {
                path = Request.Path;
            }

            return Path.GetFileName(path) ?? string.Empty;
        }
    }
}
