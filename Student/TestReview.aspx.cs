using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementPrep
{
    public class QuestionPaletteItem
    {
        public int Number { get; set; }
        public string StatusClass { get; set; } // correct, incorrect, unanswered
        public bool IsCurrent { get; set; }
    }

    public partial class TestReview : System.Web.UI.Page
    {
        protected int CurrentQuestionNumber
        {
            get { return ViewState["CurrentQ"] != null ? (int)ViewState["CurrentQ"] : 34; }
            set { ViewState["CurrentQ"] = value; }
        }

        protected string CurrentFilter
        {
            get { return ViewState["CurrentFilter"] != null ? (string)ViewState["CurrentFilter"] : "All"; }
            set { ViewState["CurrentFilter"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPalette();
            }
        }

        private void BindPalette()
        {
            var list = new List<QuestionPaletteItem>();
            for (int i = 1; i <= 25; i++)
            {
                string status = "correct";
                if (i == 14 || i == 22 || i == 34 || i == 41 || i == 48) status = "incorrect";
                else if (i == 18 || i == 29 || i == 45) status = "unanswered";

                // Filter logic
                if (CurrentFilter == "Correct" && status != "correct") continue;
                if (CurrentFilter == "Incorrect" && status != "incorrect") continue;
                if (CurrentFilter == "Unanswered" && status != "unanswered") continue;

                list.Add(new QuestionPaletteItem
                {
                    Number = i,
                    StatusClass = status,
                    IsCurrent = (i == CurrentQuestionNumber)
                });
            }

            rptQuestionPalette.DataSource = list;
            rptQuestionPalette.DataBind();
        }

        protected void Filter_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            CurrentFilter = btn.CommandArgument;

            btnFilterAll.CssClass = "student-filter-tab" + (CurrentFilter == "All" ? " active" : "");
            btnFilterIncorrect.CssClass = "student-filter-tab" + (CurrentFilter == "Incorrect" ? " active" : "");
            btnFilterCorrect.CssClass = "student-filter-tab" + (CurrentFilter == "Correct" ? " active" : "");
            btnFilterUnanswered.CssClass = "student-filter-tab" + (CurrentFilter == "Unanswered" ? " active" : "");

            BindPalette();
        }

        protected void PaletteItem_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            int qNum;
            if (int.TryParse(btn.CommandArgument, out qNum))
            {
                CurrentQuestionNumber = qNum;
                lblQuestionNumber.Text = "Question " + qNum + " of 50";
                BindPalette();
            }
        }

        protected void btnPrevQuestion_Click(object sender, EventArgs e)
        {
            if (CurrentQuestionNumber > 1)
            {
                CurrentQuestionNumber--;
                lblQuestionNumber.Text = "Question " + CurrentQuestionNumber + " of 50";
                BindPalette();
            }
        }

        protected void btnNextQuestion_Click(object sender, EventArgs e)
        {
            if (CurrentQuestionNumber < 50)
            {
                CurrentQuestionNumber++;
                lblQuestionNumber.Text = "Question " + CurrentQuestionNumber + " of 50";
                BindPalette();
            }
        }
    }
}
