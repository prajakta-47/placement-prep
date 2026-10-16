using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementPrep
{
    public class FeedbackItem
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Category { get; set; } // AI, Code, Mentor
        public string CategoryBadge { get; set; }
        public string DateFormatted { get; set; }
        public int ScorePercent { get; set; }
        public string ScoreBadgeClass { get; set; }
        public string Summary { get; set; }
        public string Strength { get; set; }
        public string Improvement { get; set; }
        public string Verdict { get; set; }
        public string ActionUrl { get; set; }
        public string ActionLabel { get; set; }
    }

    public partial class FeedbackHub : System.Web.UI.Page
    {
        private static readonly List<FeedbackItem> AllFeedbacks = new List<FeedbackItem>
        {
            new FeedbackItem
            {
                Id = 1,
                Title = "Technical Core Mock Interview #4 (Algorithms & Complexity)",
                Category = "AI",
                CategoryBadge = "AI INTERVIEW",
                DateFormatted = "Yesterday, 4:30 PM",
                ScorePercent = 84,
                ScoreBadgeClass = "easy",
                Summary = "Deep dive discussion on Floyd's Cycle Detection algorithm, pointer manipulations, and distributed Redis caching architecture.",
                Strength = "Spot-on derivation of O(N) time and O(1) space complexities without hesitation.",
                Improvement = "Explain distributed lock lease expirations with more depth during caching scenarios.",
                Verdict = "Strong Hire (Recommendation: Clear to Final Round)",
                ActionUrl = "~/Student/InterviewFeedback.aspx",
                ActionLabel = "View Evaluation Report"
            },
            new FeedbackItem
            {
                Id = 2,
                Title = "Behavioral & HR Round Simulation #2 (STAR Leadership)",
                Category = "AI",
                CategoryBadge = "AI INTERVIEW",
                DateFormatted = "3 days ago, 11:15 AM",
                ScorePercent = 88,
                ScoreBadgeClass = "easy",
                Summary = "Evaluated on situational questions regarding handling cross-team sprint blockers and conflicting product priorities.",
                Strength = "High structural alignment with the STAR framework (Situation, Task, Action, Result).",
                Improvement = "Reduce introductory filler words during the initial 30 seconds of response.",
                Verdict = "Strong Hire (Culture Add)",
                ActionUrl = "~/Student/InterviewFeedback.aspx",
                ActionLabel = "View Evaluation Report"
            },
            new FeedbackItem
            {
                Id = 3,
                Title = "Problem #1 Two Sum: Optimal Hash Map Solution",
                Category = "Code",
                CategoryBadge = "AUTOMATED CODE REVIEW",
                DateFormatted = "Oct 14, 2:10 PM",
                ScorePercent = 95,
                ScoreBadgeClass = "easy",
                Summary = "Clean one-pass Dictionary lookup implementation passing all 52 unit test cases and boundary conditions.",
                Strength = "Memory allocation efficiency in top 92.1% percentile of campus submissions.",
                Improvement = "Include guard clauses for null/empty array inputs.",
                Verdict = "Accepted & Verified",
                ActionUrl = "~/Student/ProblemDetails.aspx?id=1",
                ActionLabel = "View Solution"
            },
            new FeedbackItem
            {
                Id = 4,
                Title = "Problem #2 Longest Substring: Sliding Window Review",
                Category = "Code",
                CategoryBadge = "AUTOMATED CODE REVIEW",
                DateFormatted = "Oct 13, 6:45 PM",
                ScorePercent = 78,
                ScoreBadgeClass = "medium",
                Summary = "Sliding window with two pointers. Passed 48/52 test cases before encountering timeout on 10^5 character strings.",
                Strength = "Good grasp of variable-size window mechanics.",
                Improvement = "Replace array scanning with an ASCII lookup table or hash set to avoid inner O(K) lookup.",
                Verdict = "Needs Optimization",
                ActionUrl = "~/Student/ProblemDetails.aspx?id=2",
                ActionLabel = "Review Code"
            },
            new FeedbackItem
            {
                Id = 5,
                Title = "Campus Placement SDE Mock Interview with Prof. K. Verma",
                Category = "Mentor",
                CategoryBadge = "FACULTY MENTOR",
                DateFormatted = "Oct 11, 3:00 PM",
                ScorePercent = 85,
                ScoreBadgeClass = "easy",
                Summary = "1-on-1 faculty technical review covering database indexing (B+ Trees), transactions, and normalized schemas.",
                Strength = "Confident composure and very clear whiteboard communication.",
                Improvement = "Review isolation levels (Repeatable Read vs Serializable).",
                Verdict = "Eligible for Day-1 Companies",
                ActionUrl = "~/Student/InterviewFeedback.aspx",
                ActionLabel = "View Notes"
            }
        };

        protected string CurrentFilter
        {
            get { return ViewState["FeedbackFilter"] != null ? (string)ViewState["FeedbackFilter"] : "All"; }
            set { ViewState["FeedbackFilter"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFeedbacks();
            }
        }

        private void BindFeedbacks()
        {
            var query = AllFeedbacks.AsEnumerable();
            if (CurrentFilter != "All")
            {
                query = query.Where(f => f.Category.Equals(CurrentFilter, StringComparison.OrdinalIgnoreCase));
            }

            rptFeedbacks.DataSource = query.ToList();
            rptFeedbacks.DataBind();
        }

        protected void FilterCategory_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            CurrentFilter = btn.CommandArgument;

            btnFilterAll.CssClass = "student-filter-tab" + (CurrentFilter == "All" ? " active" : "");
            btnFilterAI.CssClass = "student-filter-tab" + (CurrentFilter == "AI" ? " active" : "");
            btnFilterCoding.CssClass = "student-filter-tab" + (CurrentFilter == "Code" ? " active" : "");
            btnFilterMentor.CssClass = "student-filter-tab" + (CurrentFilter == "Mentor" ? " active" : "");

            BindFeedbacks();
        }
    }
}
