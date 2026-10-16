using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementPrep
{
    public class LearningResourceItem
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Category { get; set; } // Aptitude, Coding, Interview, Resume, Core
        public string ResourceType { get; set; } // PDF, Cheatsheet, Video, Interactive
        public string BadgeClass { get; set; }
        public string Difficulty { get; set; }
        public string DifficultyClass { get; set; }
        public string Description { get; set; }
        public string LengthInfo { get; set; }
        public string LastUpdated { get; set; }
        public string ActionLink { get; set; }
        public string ActionText { get; set; }
    }

    public partial class Resources : System.Web.UI.Page
    {
        private static readonly List<LearningResourceItem> ResourceLibrary = new List<LearningResourceItem>
        {
            new LearningResourceItem
            {
                Id = 1,
                Title = "Speed Mathematics & Formula Handbook",
                Category = "Aptitude",
                ResourceType = "Cheatsheet",
                BadgeClass = "cheatsheet",
                Difficulty = "Foundational",
                DifficultyClass = "easy",
                Description = "Essential speed formulas for Time, Speed & Distance, Alligation, Profit-Loss, and Vedic mental arithmetic shortcuts.",
                LengthInfo = "14 Pages PDF",
                LastUpdated = "Oct 2026",
                ActionLink = "~/Student/Quantitative.aspx",
                ActionText = "Practice Concepts"
            },
            new LearningResourceItem
            {
                Id = 2,
                Title = "Data Structures & Algorithmic Patterns Playbook",
                Category = "Coding",
                ResourceType = "Interactive",
                BadgeClass = "interactive",
                Difficulty = "Intermediate",
                DifficultyClass = "medium",
                Description = "14 must-know coding patterns: Sliding Window, Two Pointers, Fast & Slow Pointers, Merge Intervals, and Monotonic Stack.",
                LengthInfo = "Interactive Sandbox",
                LastUpdated = "Oct 2026",
                ActionLink = "~/Student/CodingProblems.aspx",
                ActionText = "Open Problem Set"
            },
            new LearningResourceItem
            {
                Id = 3,
                Title = "The STAR Behavioral Interview Guide",
                Category = "Interview",
                ResourceType = "PDF",
                BadgeClass = "pdf",
                Difficulty = "Comprehensive",
                DifficultyClass = "easy",
                Description = "Framework templates for answering leadership, failure, and conflict resolution inquiries with sample transcript responses.",
                LengthInfo = "22 Pages Guide",
                LastUpdated = "Sep 2026",
                ActionLink = "~/Student/InterviewPrep.aspx",
                ActionText = "Launch Simulation"
            },
            new LearningResourceItem
            {
                Id = 4,
                Title = "High-Impact ATS Tech Resume Blueprint",
                Category = "Resume",
                ResourceType = "Cheatsheet",
                BadgeClass = "cheatsheet",
                Difficulty = "Essential",
                DifficultyClass = "easy",
                Description = "Industry-validated bullet point formulas: Accomplished [X] as measured by [Y] by doing [Z]. Includes 80+ action verbs.",
                LengthInfo = "Template & Checklist",
                LastUpdated = "Oct 2026",
                ActionLink = "~/Student/ResumeAnalyzer.aspx",
                ActionText = "Analyze Resume"
            },
            new LearningResourceItem
            {
                Id = 5,
                Title = "Operating Systems, DBMS & SQL Rapid Revision",
                Category = "Core",
                ResourceType = "PDF",
                BadgeClass = "pdf",
                Difficulty = "Advanced",
                DifficultyClass = "hard",
                Description = "B+ Trees, ACID transactions, Normalization (1NF to BCNF), Deadlocks, Virtual Memory, and Thread Synchronization.",
                LengthInfo = "32 Pages Handbook",
                LastUpdated = "Oct 2026",
                ActionLink = "~/Student/MockTests.aspx",
                ActionText = "Test Knowledge"
            },
            new LearningResourceItem
            {
                Id = 6,
                Title = "System Design & Distributed Scaling Primer",
                Category = "Coding",
                ResourceType = "Interactive",
                BadgeClass = "interactive",
                Difficulty = "Advanced",
                DifficultyClass = "hard",
                Description = "Microservices communication, Redis caching topologies, Consistent Hashing, and Rate Limiter algorithmic breakdowns.",
                LengthInfo = "Architecture Guide",
                LastUpdated = "Oct 2026",
                ActionLink = "~/Student/LiveInterview.aspx?mode=systemdesign",
                ActionText = "Launch Mock Room"
            }
        };

        protected string SelectedCategory
        {
            get { return ViewState["ResourceCat"] != null ? (string)ViewState["ResourceCat"] : "All"; }
            set { ViewState["ResourceCat"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindResources();
            }
        }

        private void BindResources()
        {
            var query = ResourceLibrary.AsEnumerable();

            // Search query
            string search = txtSearchResource.Text.Trim().ToLower();
            if (!string.IsNullOrEmpty(search))
            {
                query = query.Where(r => r.Title.ToLower().Contains(search) || 
                                         r.Description.ToLower().Contains(search) || 
                                         r.Category.ToLower().Contains(search));
            }

            // Category filter
            if (SelectedCategory != "All")
            {
                query = query.Where(r => r.Category.Equals(SelectedCategory, StringComparison.OrdinalIgnoreCase));
            }

            var list = query.ToList();

            if (list.Count == 0)
            {
                pnlResourceCards.Visible = false;
                pnlEmptyState.Visible = true;
            }
            else
            {
                pnlResourceCards.Visible = true;
                pnlEmptyState.Visible = false;
                rptResources.DataSource = list;
                rptResources.DataBind();
            }
        }

        protected void Search_TextChanged(object sender, EventArgs e)
        {
            BindResources();
        }

        protected void Category_SelectedIndexChanged(object sender, EventArgs e)
        {
            SelectedCategory = ddlCategory.SelectedValue;
            UpdateChipActiveState();
            BindResources();
        }

        protected void Chip_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            SelectedCategory = btn.CommandArgument;
            if (ddlCategory.Items.FindByValue(SelectedCategory) != null)
            {
                ddlCategory.SelectedValue = SelectedCategory;
            }
            UpdateChipActiveState();
            BindResources();
        }

        private void UpdateChipActiveState()
        {
            chipAll.CssClass = "student-chip-btn" + (SelectedCategory == "All" ? " active" : "");
            chipAptitude.CssClass = "student-chip-btn" + (SelectedCategory == "Aptitude" ? " active" : "");
            chipCoding.CssClass = "student-chip-btn" + (SelectedCategory == "Coding" ? " active" : "");
            chipInterview.CssClass = "student-chip-btn" + (SelectedCategory == "Interview" ? " active" : "");
            chipResume.CssClass = "student-chip-btn" + (SelectedCategory == "Resume" ? " active" : "");
            chipCore.CssClass = "student-chip-btn" + (SelectedCategory == "Core" ? " active" : "");
        }

        protected void btnResetFilter_Click(object sender, EventArgs e)
        {
            txtSearchResource.Text = string.Empty;
            SelectedCategory = "All";
            ddlCategory.SelectedValue = "All";
            UpdateChipActiveState();
            BindResources();
        }
    }
}
