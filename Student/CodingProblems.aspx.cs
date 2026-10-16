using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementPrep
{
    public class ProblemItem
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Topic { get; set; }
        public string Difficulty { get; set; }
        public string DifficultyClass { get; set; }
        public double AcceptanceRate { get; set; }
        public string Companies { get; set; }
        public string Status { get; set; }
        public string StatusClass { get; set; }
        public string StatusIcon { get; set; }
        public string ActionText { get; set; }

        public string CompanyBadgesHtml
        {
            get
            {
                if (string.IsNullOrEmpty(Companies)) return "";
                var tags = Companies.Split(',');
                return string.Join(" ", tags.Select(t => "<span class=\"company-chip\">" + t.Trim() + "</span>"));
            }
        }
    }

    public partial class CodingProblems : System.Web.UI.Page
    {
        private static readonly List<ProblemItem> AllProblemSet = new List<ProblemItem>
        {
            new ProblemItem { Id = 1, Title = "Two Sum", Topic = "Arrays & Hash Table", Difficulty = "Easy", DifficultyClass = "easy", AcceptanceRate = 54.2, Companies = "Amazon, Google, TCS", Status = "Solved", StatusClass = "solved", StatusIcon = "&#10003;", ActionText = "Review" },
            new ProblemItem { Id = 2, Title = "Longest Substring Without Repeating Characters", Topic = "Strings & Sliding Window", Difficulty = "Medium", DifficultyClass = "medium", AcceptanceRate = 36.8, Companies = "Amazon, Infosys, Meta", Status = "Attempted", StatusClass = "attempted", StatusIcon = "&#9681;", ActionText = "Solve" },
            new ProblemItem { Id = 3, Title = "Valid Parentheses", Topic = "Stack & Strings", Difficulty = "Easy", DifficultyClass = "easy", AcceptanceRate = 42.1, Companies = "Microsoft, Wipro, Accenture", Status = "Solved", StatusClass = "solved", StatusIcon = "&#10003;", ActionText = "Review" },
            new ProblemItem { Id = 4, Title = "Container With Most Water", Topic = "Two Pointers & Greedy", Difficulty = "Medium", DifficultyClass = "medium", AcceptanceRate = 56.4, Companies = "Adobe, Amazon, Cognizant", Status = "Todo", StatusClass = "todo", StatusIcon = "&#9675;", ActionText = "Solve" },
            new ProblemItem { Id = 5, Title = "Merge Intervals", Topic = "Arrays & Sorting", Difficulty = "Medium", DifficultyClass = "medium", AcceptanceRate = 48.7, Companies = "Google, TCS Digital, Capgemini", Status = "Todo", StatusClass = "todo", StatusIcon = "&#9675;", ActionText = "Solve" },
            new ProblemItem { Id = 6, Title = "Reverse Linked List", Topic = "Linked List", Difficulty = "Easy", DifficultyClass = "easy", AcceptanceRate = 75.9, Companies = "Infosys, Wipro, IBM", Status = "Solved", StatusClass = "solved", StatusIcon = "&#10003;", ActionText = "Review" },
            new ProblemItem { Id = 7, Title = "Search in Rotated Sorted Array", Topic = "Binary Search", Difficulty = "Medium", DifficultyClass = "medium", AcceptanceRate = 40.5, Companies = "Microsoft, Amazon", Status = "Todo", StatusClass = "todo", StatusIcon = "&#9675;", ActionText = "Solve" },
            new ProblemItem { Id = 8, Title = "Coin Change", Topic = "Dynamic Programming", Difficulty = "Medium", DifficultyClass = "medium", AcceptanceRate = 44.0, Companies = "Amazon, Google", Status = "Todo", StatusClass = "todo", StatusIcon = "&#9675;", ActionText = "Solve" },
            new ProblemItem { Id = 9, Title = "Trapping Rain Water", Topic = "Two Pointers & Stack", Difficulty = "Hard", DifficultyClass = "hard", AcceptanceRate = 28.3, Companies = "Google, Amazon, Microsoft", Status = "Todo", StatusClass = "todo", StatusIcon = "&#9675;", ActionText = "Solve" },
            new ProblemItem { Id = 10, Title = "Lowest Common Ancestor of Binary Tree", Topic = "Trees & Recursion", Difficulty = "Medium", DifficultyClass = "medium", AcceptanceRate = 61.2, Companies = "Meta, Amazon, TCS", Status = "Todo", StatusClass = "todo", StatusIcon = "&#9675;", ActionText = "Solve" }
        };

        protected string SelectedTopic
        {
            get { return ViewState["SelectedTopic"] != null ? (string)ViewState["SelectedTopic"] : "All"; }
            set { ViewState["SelectedTopic"] = value; }
        }

        protected int CurrentPage
        {
            get { return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 1; }
            set { ViewState["CurrentPage"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProblems();
            }
        }

        private void BindProblems()
        {
            var query = AllProblemSet.AsEnumerable();

            // Search filter
            string search = txtSearchProblem.Text.Trim().ToLower();
            if (!string.IsNullOrEmpty(search))
            {
                query = query.Where(p => p.Title.ToLower().Contains(search) || 
                                         p.Topic.ToLower().Contains(search) || 
                                         p.Companies.ToLower().Contains(search));
            }

            // Difficulty filter
            string diff = ddlDifficulty.SelectedValue;
            if (diff != "All")
            {
                query = query.Where(p => p.Difficulty.Equals(diff, StringComparison.OrdinalIgnoreCase));
            }

            // Status filter
            string status = ddlStatus.SelectedValue;
            if (status != "All")
            {
                query = query.Where(p => p.Status.Equals(status, StringComparison.OrdinalIgnoreCase));
            }

            // Topic filter
            if (SelectedTopic != "All")
            {
                query = query.Where(p => p.Topic.IndexOf(SelectedTopic, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            var list = query.ToList();
            lblProblemCount.Text = "1 - " + list.Count + " of " + AllProblemSet.Count;

            rptProblems.DataSource = list;
            rptProblems.DataBind();
        }

        protected void FilterChanged(object sender, EventArgs e)
        {
            CurrentPage = 1;
            BindProblems();
        }

        protected void TopicChip_Click(object sender, EventArgs e)
        {
            var chip = (LinkButton)sender;
            SelectedTopic = chip.CommandArgument;

            // Reset active styles on chip buttons
            chipAll.CssClass = "student-chip-btn" + (SelectedTopic == "All" ? " active" : "");
            chipArrays.CssClass = "student-chip-btn" + (SelectedTopic == "Arrays" ? " active" : "");
            chipStrings.CssClass = "student-chip-btn" + (SelectedTopic == "Strings" ? " active" : "");
            chipTwoPointers.CssClass = "student-chip-btn" + (SelectedTopic == "Two Pointers" ? " active" : "");
            chipLinkedList.CssClass = "student-chip-btn" + (SelectedTopic == "Linked List" ? " active" : "");
            chipStack.CssClass = "student-chip-btn" + (SelectedTopic == "Stack" ? " active" : "");
            chipBinarySearch.CssClass = "student-chip-btn" + (SelectedTopic == "Binary Search" ? " active" : "");
            chipDP.CssClass = "student-chip-btn" + (SelectedTopic == "Dynamic Programming" ? " active" : "");
            chipTrees.CssClass = "student-chip-btn" + (SelectedTopic == "Trees" ? " active" : "");

            CurrentPage = 1;
            BindProblems();
        }

        protected void PageChange_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            string arg = btn.CommandArgument;
            if (arg == "Prev" && CurrentPage > 1) CurrentPage--;
            else if (arg == "Next" && CurrentPage < 3) CurrentPage++;
            else if (int.TryParse(arg, out int p)) CurrentPage = p;

            btnPage1.CssClass = "page-link-btn" + (CurrentPage == 1 ? " active" : "");
            btnPage2.CssClass = "page-link-btn" + (CurrentPage == 2 ? " active" : "");
            btnPage3.CssClass = "page-link-btn" + (CurrentPage == 3 ? " active" : "");

            BindProblems();
        }
    }
}
