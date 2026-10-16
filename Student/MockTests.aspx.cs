using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementPrep
{
    public class MockTestItem
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Category { get; set; } // Company, Aptitude, Technical
        public string CategoryTag { get; set; }
        public string Description { get; set; }
        public int DurationMinutes { get; set; }
        public int QuestionCount { get; set; }
        public int AttemptsCount { get; set; }
        public bool IsCompleted { get; set; }
        public int BestScore { get; set; }
        public string PercentileRank { get; set; }
        public int CutoffMark { get; set; }
        public string StatusText { get; set; }
        public string StatusBadgeClass { get; set; }
        public string ActionBtnText { get; set; }
    }

    public partial class MockTests : System.Web.UI.Page
    {
        private static readonly List<MockTestItem> AllMockTests = new List<MockTestItem>
        {
            new MockTestItem
            {
                Id = 1,
                Title = "TCS NQT Comprehensive Mock Test 2026",
                Category = "Company",
                CategoryTag = "TCS NQT NATIONAL BENCHMARK",
                Description = "Complete simulated national qualifier test covering Numerical Ability, Reasoning, Verbal, and Hands-on Coding.",
                DurationMinutes = 90,
                QuestionCount = 80,
                AttemptsCount = 2,
                IsCompleted = true,
                BestScore = 85,
                PercentileRank = "94th",
                CutoffMark = 70,
                StatusText = "Completed: 85%",
                StatusBadgeClass = "easy",
                ActionBtnText = "Retake Test"
            },
            new MockTestItem
            {
                Id = 2,
                Title = "Infosys Specialist Programmer (SP) Assessment",
                Category = "Company",
                CategoryTag = "INFOSYS SPECIALIST DRILL",
                Description = "Rigorous technical assessment designed for System Engineer Specialist and DSE roles with advanced algorithms.",
                DurationMinutes = 180,
                QuestionCount = 55,
                AttemptsCount = 1,
                IsCompleted = true,
                BestScore = 78,
                PercentileRank = "88th",
                CutoffMark = 75,
                StatusText = "Completed: 78%",
                StatusBadgeClass = "medium",
                ActionBtnText = "Retake Test"
            },
            new MockTestItem
            {
                Id = 3,
                Title = "Cognizant GenC Next Aptitude & Technical Suite",
                Category = "Company",
                CategoryTag = "COGNIZANT GENC NEXT",
                Description = "Analytical reasoning, quantitative ability, code snippet debugging, and behavioral campus screening round.",
                DurationMinutes = 100,
                QuestionCount = 65,
                AttemptsCount = 1,
                IsCompleted = true,
                BestScore = 88,
                PercentileRank = "96th",
                CutoffMark = 72,
                StatusText = "Completed: 88%",
                StatusBadgeClass = "easy",
                ActionBtnText = "Retake Test"
            },
            new MockTestItem
            {
                Id = 4,
                Title = "National Campus Diagnostic Full-Length Mock",
                Category = "Aptitude",
                CategoryTag = "ALL-INDIA PLACEMENT BENCHMARK",
                Description = "Comprehensive 100-question multi-section diagnostic test to predict placement percentile across 500+ colleges.",
                DurationMinutes = 120,
                QuestionCount = 100,
                AttemptsCount = 2,
                IsCompleted = true,
                BestScore = 82,
                PercentileRank = "91st",
                CutoffMark = 68,
                StatusText = "Completed: 82%",
                StatusBadgeClass = "easy",
                ActionBtnText = "Retake Test"
            },
            new MockTestItem
            {
                Id = 5,
                Title = "Speed Aptitude Drill: Quant & Logical Sprint",
                Category = "Aptitude",
                CategoryTag = "SPEED BENCHMARK DRILL",
                Description = "High-pressure, rapid-fire sprint assessment testing fast mental calculation, shortcuts, and pattern recognition.",
                DurationMinutes = 45,
                QuestionCount = 50,
                AttemptsCount = 0,
                IsCompleted = false,
                BestScore = 0,
                PercentileRank = "-",
                CutoffMark = 75,
                StatusText = "Not Attempted",
                StatusBadgeClass = "hard",
                ActionBtnText = "Start Test"
            },
            new MockTestItem
            {
                Id = 6,
                Title = "Core Technical Concepts (OS, DBMS, Networks)",
                Category = "Technical",
                CategoryTag = "TECHNICAL CORE MASTERY",
                Description = "Curated multiple-choice and conceptual assessment covering SQL, transactions, processes, threads, and TCP/IP.",
                DurationMinutes = 60,
                QuestionCount = 50,
                AttemptsCount = 1,
                IsCompleted = true,
                BestScore = 90,
                PercentileRank = "97th",
                CutoffMark = 70,
                StatusText = "Completed: 90%",
                StatusBadgeClass = "easy",
                ActionBtnText = "Retake Test"
            }
        };

        protected string SelectedCategory
        {
            get { return ViewState["SelectedCategory"] != null ? (string)ViewState["SelectedCategory"] : "All"; }
            set { ViewState["SelectedCategory"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMockTests();
            }
        }

        private void BindMockTests()
        {
            var query = AllMockTests.AsEnumerable();
            if (SelectedCategory != "All")
            {
                query = query.Where(m => m.Category.Equals(SelectedCategory, StringComparison.OrdinalIgnoreCase));
            }

            rptMockTests.DataSource = query.ToList();
            rptMockTests.DataBind();
        }

        protected void CategoryTab_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            SelectedCategory = btn.CommandArgument;

            btnTabAll.CssClass = "student-filter-tab" + (SelectedCategory == "All" ? " active" : "");
            btnTabCompany.CssClass = "student-filter-tab" + (SelectedCategory == "Company" ? " active" : "");
            btnTabAptitude.CssClass = "student-filter-tab" + (SelectedCategory == "Aptitude" ? " active" : "");
            btnTabTechnical.CssClass = "student-filter-tab" + (SelectedCategory == "Technical" ? " active" : "");

            BindMockTests();
        }
    }
}
