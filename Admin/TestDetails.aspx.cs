using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Helpers;

namespace PlacementPrep.Admin
{
    public partial class TestDetails : Page
    {
        private readonly TestRepository _testRepo = new TestRepository();
        private readonly QuestionRepository _questionRepo = new QuestionRepository();
        private readonly CodingProblemRepository _codingRepo = new CodingProblemRepository();
        private readonly StudentRepository _studentRepo = new StudentRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int testId = 101;
                int id;
                if (int.TryParse(Request.QueryString["id"], out id) && id > 0)
                {
                    testId = id;
                }

                hfTestId.Value = testId.ToString(CultureInfo.InvariantCulture);
                LoadTestDetails(testId);

                string tab = Request.QueryString["tab"];
                if (string.Equals(tab, "edit", StringComparison.OrdinalIgnoreCase))
                {
                    SwitchTab("edit");
                }
            }
        }

        private void LoadTestDetails(int testId)
        {
            var test = _testRepo.GetById(testId);
            if (test == null)
            {
                ShowMessage("Assessment details were not found.", "users-alert-error");
                return;
            }

            // Header info
            litTestTitle.Text = Server.HtmlEncode(test.Title);
            litTestCodeBadge.Text = "<span class=\"user-id-badge\" style=\"background:#e0e7ff; color:#4338ca;\">" + Server.HtmlEncode(test.TestCode) + "</span>";
            litCompany.Text = Server.HtmlEncode(test.Company);
            litType.Text = Server.HtmlEncode(test.TestType);

            // KPIs
            litKpiMarks.Text = test.TotalMarks.ToString(CultureInfo.InvariantCulture);
            litKpiPassScore.Text = test.PassingPercentage + "%";
            litKpiDuration.Text = test.DurationDisplay;
            litKpiSchedule.Text = Server.HtmlEncode(test.ScheduleDisplay);
            litKpiQuestions.Text = test.TotalQuestions.ToString(CultureInfo.InvariantCulture);
            litKpiStatusPill.Text = "<span class=\"" + test.StatusClass + "\">" + Server.HtmlEncode(test.Status) + "</span>";
            litKpiProctoring.Text = Server.HtmlEncode(test.ProctoringLevel ?? "Strict Lockdown");

            // Overview Tab
            litTargetDept.Text = Server.HtmlEncode(test.TargetDepartment ?? "All Departments");
            litTargetBatch.Text = Server.HtmlEncode(test.TargetBatch ?? "Batch 2025");
            litScheduleDetail.Text = Server.HtmlEncode(test.ScheduleDisplay);
            litNegativeMarkingDisplay.Text = test.NegativeMarking ? "Enabled (" + test.NegativeMarkValue.ToString("0.00", CultureInfo.InvariantCulture) + " penalty)" : "Disabled (No negative score)";
            litShufflingDisplay.Text = test.ShuffleQuestions ? "Enabled (Randomized order)" : "Disabled (Fixed sequence)";
            litDescription.Text = Server.HtmlEncode(string.IsNullOrWhiteSpace(test.Description) ? "No special description provided for this assessment." : test.Description);
            litInstructions.Text = Server.HtmlEncode(string.IsNullOrWhiteSpace(test.Instructions) ? "Standard online test guidelines apply. Ensure high-speed internet and uninterrupted power." : test.Instructions);
            litCreatedBy.Text = Server.HtmlEncode(test.CreatedBy ?? "Admin Superuser");
            litUpdatedAt.Text = test.UpdatedAt.ToString("MMM dd, yyyy", CultureInfo.InvariantCulture);

            // Questions Tab
            BindTestQuestions(test);

            // Roster Tab
            BindStudentRoster(test);

            // Edit Tab pre-fill
            txtEditTitle.Text = test.Title;
            txtEditCompany.Text = test.Company;
            if (ddlEditType.Items.FindByValue(test.TestType) != null)
                ddlEditType.SelectedValue = test.TestType;
            if (ddlEditStatus.Items.FindByValue(test.Status) != null)
                ddlEditStatus.SelectedValue = test.Status;
            txtEditDuration.Text = test.DurationMinutes.ToString(CultureInfo.InvariantCulture);
            txtEditMarks.Text = test.TotalMarks.ToString(CultureInfo.InvariantCulture);
            txtEditScheduledStart.Text = test.ScheduledStart.HasValue ? test.ScheduledStart.Value.ToString("yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture) : string.Empty;
            txtEditScheduledEnd.Text = test.ScheduledEnd.HasValue ? test.ScheduledEnd.Value.ToString("yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture) : string.Empty;
            txtEditInstructions.Text = test.Instructions;
        }

        private void BindTestQuestions(TestItem test)
        {
            var list = new List<object>();

            var aptSample = _questionRepo.SearchQuestions(string.Empty, "Aptitude", "All", "All", 1, 3);
            foreach (var q in aptSample.Items)
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

            var techSample = _questionRepo.SearchQuestions(string.Empty, "Technical", "All", "All", 1, 3);
            foreach (var q in techSample.Items)
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

            var codeSample = _codingRepo.SearchProblems(string.Empty, "All", "All", "All", 1, 2);
            foreach (var p in codeSample.Items)
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

            litTabQuestionCount.Text = list.Count.ToString(CultureInfo.InvariantCulture);
            rptTestQuestions.DataSource = list;
            rptTestQuestions.DataBind();
        }

        private void BindStudentRoster(TestItem test)
        {
            var students = _studentRepo.SearchStudents(string.Empty, "All", "All", "All", "All", 1, 5);
            var roster = new List<object>();
            int idx = 0;
            int maxScore = test.TotalMarks > 0 ? test.TotalMarks : 100;
            int passCutoff = test.PassingPercentage > 0 ? test.PassingPercentage : 65;

            int[] scores = new[] { 88, 92, 62, 78, 54 };

            foreach (var s in students.Items)
            {
                int score = (int)(scores[idx % scores.Length] * (maxScore / 100.0));
                int pct = (int)((score / (double)maxScore) * 100);
                bool passed = pct >= passCutoff;
                int proctorFlags = (idx == 2 || idx == 4) ? 2 : 0;

                roster.Add(new
                {
                    RollNo = s.EnrollmentId,
                    FullName = s.FullName,
                    Department = s.Department,
                    Score = score,
                    MaxScore = maxScore,
                    Percentage = pct,
                    ProctorFlags = proctorFlags,
                    Passed = passed
                });
                idx++;
            }

            litTabStudentCount.Text = roster.Count.ToString(CultureInfo.InvariantCulture);
            rptStudentRoster.DataSource = roster;
            rptStudentRoster.DataBind();
        }

        protected void tabBtn_Click(object sender, EventArgs e)
        {
            var btn = sender as LinkButton;
            if (btn == null) return;
            SwitchTab(btn.CommandArgument);
        }

        private void SwitchTab(string tabKey)
        {
            hfActiveTab.Value = tabKey;

            tabBtnOverview.CssClass = "qb-tab" + (tabKey == "overview" ? " active" : "");
            tabBtnQuestions.CssClass = "qb-tab" + (tabKey == "questions" ? " active" : "");
            tabBtnRoster.CssClass = "qb-tab" + (tabKey == "roster" ? " active" : "");
            tabBtnEdit.CssClass = "qb-tab" + (tabKey == "edit" ? " active" : "");

            pnlTabOverview.Visible = tabKey == "overview";
            pnlTabQuestions.Visible = tabKey == "questions";
            pnlTabRoster.Visible = tabKey == "roster";
            pnlTabEdit.Visible = tabKey == "edit";
        }

        protected void btnPublish_Click(object sender, EventArgs e)
        {
            int testId;
            if (int.TryParse(hfTestId.Value, out testId) && testId > 0)
            {
                _testRepo.PublishTest(testId);
                ShowMessage("Assessment successfully published and active for candidates.", "users-alert-success");
                LoadTestDetails(testId);
            }
        }

        protected void btnRevertDraft_Click(object sender, EventArgs e)
        {
            int testId;
            if (int.TryParse(hfTestId.Value, out testId) && testId > 0)
            {
                _testRepo.RevertToDraft(testId);
                ShowMessage("Assessment reverted to Draft status.", "users-alert-success");
                LoadTestDetails(testId);
            }
        }

        protected void btnSaveEdit_Click(object sender, EventArgs e)
        {
            Page.Validate("EditTestGroup");
            if (!Page.IsValid)
            {
                SwitchTab("edit");
                return;
            }

            int testId;
            if (!int.TryParse(hfTestId.Value, out testId) || testId <= 0)
            {
                return;
            }

            var test = _testRepo.GetById(testId);
            if (test == null) return;

            int duration = 90;
            int.TryParse(txtEditDuration.Text.Trim(), out duration);

            int marks = 100;
            int.TryParse(txtEditMarks.Text.Trim(), out marks);

            DateTime? startDt = null;
            DateTime parsedStart;
            if (DateTime.TryParse(txtEditScheduledStart.Text.Trim(), CultureInfo.InvariantCulture, DateTimeStyles.None, out parsedStart))
            {
                startDt = parsedStart;
            }

            DateTime? endDt = null;
            DateTime parsedEnd;
            if (DateTime.TryParse(txtEditScheduledEnd.Text.Trim(), CultureInfo.InvariantCulture, DateTimeStyles.None, out parsedEnd))
            {
                endDt = parsedEnd;
            }

            test.Title = txtEditTitle.Text.Trim();
            test.Company = txtEditCompany.Text.Trim();
            test.TestType = ddlEditType.SelectedValue;
            test.Status = ddlEditStatus.SelectedValue;
            test.DurationMinutes = duration;
            test.TotalMarks = marks;
            test.ScheduledStart = startDt;
            test.ScheduledEnd = endDt;
            test.Instructions = txtEditInstructions.Text.Trim();

            _testRepo.UpdateTest(test);

            ShowMessage("Assessment configuration updated successfully.", "users-alert-success");
            LoadTestDetails(testId);
            SwitchTab("overview");
        }

        private void ShowMessage(string message, string cssClass)
        {
            litMessage.Text = message;
            pnlMessage.CssClass = "users-alert " + cssClass;
            pnlMessage.Visible = true;
        }
    }
}
