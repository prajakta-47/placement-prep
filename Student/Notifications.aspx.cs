using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementPrep
{
    public partial class Notifications : System.Web.UI.Page
    {
        [Serializable]
        public class NotificationItem
        {
            public int Id { get; set; }
            public string Title { get; set; }
            public string Message { get; set; }
            public string Category { get; set; }
            public string CategoryType { get; set; } // drive, test, interview, academic
            public string TimeAgo { get; set; }
            public string ActionUrl { get; set; }
            public string ActionText { get; set; }
            public string IconHtml { get; set; }
            public bool IsRead { get; set; }
        }

        private List<NotificationItem> NotificationData
        {
            get
            {
                if (Session["StudentNotificationList"] == null)
                {
                    Session["StudentNotificationList"] = GetInitialNotifications();
                }
                return (List<NotificationItem>)Session["StudentNotificationList"];
            }
            set
            {
                Session["StudentNotificationList"] = value;
            }
        }

        private string CurrentFilter
        {
            get { return ViewState["NotifFilter"] != null ? ViewState["NotifFilter"].ToString() : "All"; }
            set { ViewState["NotifFilter"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CurrentFilter = "All";
                BindNotifications();
            }
        }

        private void BindNotifications()
        {
            var list = NotificationData;
            litCountAll.Text = list.Count.ToString();
            litCountUnread.Text = list.Count(n => !n.IsRead).ToString();

            IEnumerable<NotificationItem> filtered = list;
            string filter = CurrentFilter;

            if (filter == "Unread")
            {
                filtered = list.Where(n => !n.IsRead);
            }
            else if (filter == "Drive")
            {
                filtered = list.Where(n => n.CategoryType == "drive");
            }
            else if (filter == "Test")
            {
                filtered = list.Where(n => n.CategoryType == "test");
            }
            else if (filter == "Interview")
            {
                filtered = list.Where(n => n.CategoryType == "interview");
            }
            else if (filter == "Academic")
            {
                filtered = list.Where(n => n.CategoryType == "academic");
            }

            var results = filtered.ToList();
            if (results.Any())
            {
                rptNotifications.DataSource = results;
                rptNotifications.DataBind();
                rptNotifications.Visible = true;
                pnlEmptyState.Visible = false;
            }
            else
            {
                rptNotifications.Visible = false;
                pnlEmptyState.Visible = true;
            }

            UpdateChipStyles(filter);
        }

        private void UpdateChipStyles(string filter)
        {
            chipAll.CssClass = "student-chip-btn" + (filter == "All" ? " active" : "");
            chipUnread.CssClass = "student-chip-btn" + (filter == "Unread" ? " active" : "");
            chipDrives.CssClass = "student-chip-btn" + (filter == "Drive" ? " active" : "");
            chipTests.CssClass = "student-chip-btn" + (filter == "Test" ? " active" : "");
            chipInterviews.CssClass = "student-chip-btn" + (filter == "Interview" ? " active" : "");
            chipAcademic.CssClass = "student-chip-btn" + (filter == "Academic" ? " active" : "");
        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            CurrentFilter = btn.CommandArgument;
            BindNotifications();
        }

        protected void btnResetFilter_Click(object sender, EventArgs e)
        {
            CurrentFilter = "All";
            BindNotifications();
        }

        protected void btnMarkAllRead_Click(object sender, EventArgs e)
        {
            var list = NotificationData;
            foreach (var item in list)
            {
                item.IsRead = true;
            }
            NotificationData = list;
            litNotice.Text = "<strong>All Marked as Read!</strong> All unread alerts have been updated.";
            pnlNotice.Visible = true;
            BindNotifications();
        }

        protected void rptNotifications_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ToggleRead")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                var list = NotificationData;
                var found = list.FirstOrDefault(x => x.Id == id);
                if (found != null)
                {
                    found.IsRead = !found.IsRead;
                    NotificationData = list;
                }
                BindNotifications();
            }
        }

        private List<NotificationItem> GetInitialNotifications()
        {
            return new List<NotificationItem>
            {
                new NotificationItem
                {
                    Id = 1,
                    Title = "Infosys Campus Recruitment Drive 2026 Announced",
                    Message = "Eligible branches: CSE, IT, ECE with CGPA >= 7.5. Diagnostic Aptitude and Coding cutoff scheduled for this Friday.",
                    Category = "Campus Recruitment",
                    CategoryType = "drive",
                    TimeAgo = "25 mins ago",
                    ActionUrl = "~/Student/MockTests.aspx",
                    ActionText = "Attempt Practice Mock",
                    IconHtml = "<svg viewBox='0 0 24 24' width='18' height='18' fill='none' stroke='currentColor' stroke-width='2'><path d='M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z'/></svg>",
                    IsRead = false
                },
                new NotificationItem
                {
                    Id = 2,
                    Title = "AI Technical Interview STAR Rubric Feedback Ready",
                    Message = "Your behavioral and system design answers for SDE-1 have been scored (84/100). Technical clarity scored in the 92nd percentile.",
                    Category = "AI Mock Interview",
                    CategoryType = "interview",
                    TimeAgo = "2 hours ago",
                    ActionUrl = "~/Student/InterviewFeedback.aspx",
                    ActionText = "Review Detailed Feedback",
                    IconHtml = "<svg viewBox='0 0 24 24' width='18' height='18' fill='none' stroke='currentColor' stroke-width='2'><path d='M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z'/></svg>",
                    IsRead = false
                },
                new NotificationItem
                {
                    Id = 3,
                    Title = "New Diagnostic Quantitative Test Assigned: Permutations & Probability",
                    Message = "Faculty Mentor Dr. R. Sharma has unlocked 25 high-frequency questions matching the recent Amazon assessment pattern.",
                    Category = "Diagnostic Tests",
                    CategoryType = "test",
                    TimeAgo = "4 hours ago",
                    ActionUrl = "~/Student/Quantitative.aspx",
                    ActionText = "Start Diagnostic Test",
                    IconHtml = "<svg viewBox='0 0 24 24' width='18' height='18' fill='none' stroke='currentColor' stroke-width='2'><rect x='4' y='3' width='16' height='18' rx='2'/><path d='M8 7h8M8 11h2m4 0h2M8 15h2m4 0h2'/></svg>",
                    IsRead = false
                },
                new NotificationItem
                {
                    Id = 4,
                    Title = "Resume ATS Compatibility Score Updated",
                    Message = "Your updated resume was evaluated with 88% keyword match for Full Stack Developer roles. 2 critical formatting improvements suggested.",
                    Category = "Resume Analyzer",
                    CategoryType = "academic",
                    TimeAgo = "1 day ago",
                    ActionUrl = "~/Student/AIResumeAnalysis.aspx",
                    ActionText = "View Keyword Match",
                    IconHtml = "<svg viewBox='0 0 24 24' width='18' height='18' fill='none' stroke='currentColor' stroke-width='2'><path d='M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z'/><polyline points='14 2 14 8 20 8'/></svg>",
                    IsRead = true
                },
                new NotificationItem
                {
                    Id = 5,
                    Title = "Coding Sandbox: 10 New Dynamic Programming Challenges Added",
                    Message = "LeetCode Medium & Hard equivalents covering Knapsack, Longest Common Subsequence, and Matrix Chain Multiplication are now live.",
                    Category = "Coding Sandbox",
                    CategoryType = "test",
                    TimeAgo = "2 days ago",
                    ActionUrl = "~/Student/CodingProblems.aspx",
                    ActionText = "Solve Problems",
                    IconHtml = "<svg viewBox='0 0 24 24' width='18' height='18' fill='none' stroke='currentColor' stroke-width='2'><rect x='3' y='4' width='18' height='15' rx='2'/><path d='m8 9-3 3 3 2m4 0 3-5'/></svg>",
                    IsRead = true
                },
                new NotificationItem
                {
                    Id = 6,
                    Title = "Weekly Placement Readiness Summary Report Generated",
                    Message = "Congratulations! You completed 4 aptitude assessments and maintained a 94% test completion accuracy rate this week.",
                    Category = "Weekly Summary",
                    CategoryType = "academic",
                    TimeAgo = "3 days ago",
                    ActionUrl = "~/Student/Dashboard.aspx",
                    ActionText = "View Readiness Metrics",
                    IconHtml = "<svg viewBox='0 0 24 24' width='18' height='18' fill='none' stroke='currentColor' stroke-width='2'><circle cx='12' cy='12' r='10'/><path d='m9 12 2 2 4-4'/></svg>",
                    IsRead = true
                }
            };
        }
    }
}
