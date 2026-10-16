using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Helpers;

namespace PlacementPrep.Admin
{
    public partial class CreateTest : Page
    {
        private readonly TestRepository _testRepo = new TestRepository();
        private readonly QuestionRepository _questionRepo = new QuestionRepository();
        private readonly CodingProblemRepository _codingRepo = new CodingProblemRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDemoQuestions();
                txtScheduledStart.Text = DateTime.UtcNow.AddDays(1).ToString("yyyy-MM-dd 10:00", CultureInfo.InvariantCulture);
                txtScheduledEnd.Text = DateTime.UtcNow.AddDays(1).ToString("yyyy-MM-dd 18:00", CultureInfo.InvariantCulture);
            }
        }

        private void BindDemoQuestions()
        {
            var list = new List<object>();

            // Get top 2 aptitude questions
            var aptResult = _questionRepo.SearchQuestions(string.Empty, "Aptitude", "All", "All", 1, 3);
            foreach (var q in aptResult.Items)
            {
                list.Add(new
                {
                    Code = q.Code,
                    Type = "Aptitude",
                    Title = q.Topic,
                    Snippet = q.PromptSnippet,
                    Difficulty = q.Difficulty,
                    DifficultyClass = q.DifficultyClass,
                    Marks = q.Marks
                });
            }

            // Get top 2 technical questions
            var techResult = _questionRepo.SearchQuestions(string.Empty, "Technical", "All", "All", 1, 3);
            foreach (var q in techResult.Items)
            {
                list.Add(new
                {
                    Code = q.Code,
                    Type = "Technical",
                    Title = q.Topic,
                    Snippet = q.PromptSnippet,
                    Difficulty = q.Difficulty,
                    DifficultyClass = q.DifficultyClass,
                    Marks = q.Marks
                });
            }

            // Get top 2 coding problems
            var codingResult = _codingRepo.SearchProblems(string.Empty, "All", "All", "All", 1, 2);
            foreach (var p in codingResult.Items)
            {
                list.Add(new
                {
                    Code = p.Code,
                    Type = "Coding",
                    Title = p.Title,
                    Snippet = p.StatementSnippet,
                    Difficulty = p.Difficulty,
                    DifficultyClass = p.DifficultyClass,
                    Marks = p.Marks
                });
            }

            rptDemoQuestions.DataSource = list;
            rptDemoQuestions.DataBind();
        }

        protected void btnSaveDraft_Click(object sender, EventArgs e)
        {
            SaveAssessment("Draft");
        }

        protected void btnPublish_Click(object sender, EventArgs e)
        {
            SaveAssessment("Published");
        }

        private void SaveAssessment(string status)
        {
            if (!Page.IsValid)
            {
                return;
            }

            int duration = 90;
            int.TryParse(txtDuration.Text.Trim(), out duration);

            int totalMarks = 100;
            int.TryParse(txtTotalMarks.Text.Trim(), out totalMarks);

            int passingPct = 65;
            int.TryParse(txtPassingPercentage.Text.Trim(), out passingPct);

            double negVal = 0.5;
            double.TryParse(txtNegativeMarkVal.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out negVal);

            DateTime? startDt = null;
            DateTime parsedStart;
            if (DateTime.TryParse(txtScheduledStart.Text.Trim(), CultureInfo.InvariantCulture, DateTimeStyles.None, out parsedStart))
            {
                startDt = parsedStart;
            }

            DateTime? endDt = null;
            DateTime parsedEnd;
            if (DateTime.TryParse(txtScheduledEnd.Text.Trim(), CultureInfo.InvariantCulture, DateTimeStyles.None, out parsedEnd))
            {
                endDt = parsedEnd;
            }

            // Collect selected question codes from cart
            var selectedCodes = new List<string>();
            foreach (RepeaterItem item in rptDemoQuestions.Items)
            {
                var chk = item.FindControl("chkSelectQuestion") as CheckBox;
                var hf = item.FindControl("hfQuestionCode") as HiddenField;
                if (chk != null && chk.Checked && hf != null && !string.IsNullOrWhiteSpace(hf.Value))
                {
                    selectedCodes.Add(hf.Value.Trim());
                }
            }

            var newTest = new TestItem
            {
                Title = txtTitle.Text.Trim(),
                Company = txtCompany.Text.Trim(),
                TestType = ddlTestType.SelectedValue,
                TargetDepartment = ddlTargetDepartment.SelectedValue,
                TargetBatch = ddlTargetBatch.SelectedValue,
                Description = txtDescription.Text.Trim(),
                DurationMinutes = duration,
                TotalMarks = totalMarks,
                TotalQuestions = selectedCodes.Count > 0 ? selectedCodes.Count : 25,
                PassingPercentage = passingPct,
                ProctoringLevel = ddlProctoringLevel.SelectedValue,
                NegativeMarking = chkNegativeMarking.Checked,
                NegativeMarkValue = negVal,
                ShuffleQuestions = chkShuffleQuestions.Checked,
                ScheduledStart = startDt,
                ScheduledEnd = endDt,
                Instructions = txtInstructions.Text.Trim(),
                Status = status,
                CreatedBy = "Admin Superuser",
                SelectedQuestionCodes = selectedCodes
            };

            _testRepo.CreateTest(newTest);

            Response.Redirect("ManageTests.aspx?saved=1");
        }

        private void ShowMessage(string message, string cssClass)
        {
            litMessage.Text = message;
            pnlMessage.CssClass = "users-alert " + cssClass;
            pnlMessage.Visible = true;
        }
    }
}
