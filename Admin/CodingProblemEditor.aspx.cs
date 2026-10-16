using System;
using System.Globalization;
using System.Web.UI;
using PlacementPrep.Helpers;

namespace PlacementPrep.Admin
{
    public partial class CodingProblemEditor : Page
    {
        private readonly CodingProblemRepository _repo = new CodingProblemRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int id;
                if (int.TryParse(Request.QueryString["id"], out id) && id > 0)
                {
                    LoadProblem(id);
                }
            }
        }

        private void LoadProblem(int id)
        {
            var p = _repo.GetById(id);
            if (p == null)
            {
                ShowMessage("Coding problem was not found.", "users-alert-error");
                return;
            }

            hfProblemId.Value = p.ProblemId.ToString(CultureInfo.InvariantCulture);
            litPageTitle.Text = "Edit Coding Problem (" + Server.HtmlEncode(p.Code) + ")";
            txtTitle.Text = p.Title;
            txtCode.Text = p.Code;

            if (ddlTopic.Items.FindByValue(p.Topic) != null)
                ddlTopic.SelectedValue = p.Topic;
            else
                ddlTopic.Items.Add(new System.Web.UI.WebControls.ListItem(p.Topic, p.Topic) { Selected = true });

            if (ddlDifficulty.Items.FindByValue(p.Difficulty) != null)
                ddlDifficulty.SelectedValue = p.Difficulty;

            txtMarks.Text = p.Marks.ToString(CultureInfo.InvariantCulture);
            txtTestCaseCount.Text = p.TestCaseCount.ToString(CultureInfo.InvariantCulture);

            if (ddlStatus.Items.FindByValue(p.Status) != null)
                ddlStatus.SelectedValue = p.Status;

            txtStatement.Text = p.Statement;
            txtInputFormat.Text = p.InputFormat;
            txtOutputFormat.Text = p.OutputFormat;
            txtConstraints.Text = p.Constraints;
            txtSampleInput.Text = p.SampleInput;
            txtSampleOutput.Text = p.SampleOutput;
            txtExplanation.Text = p.Explanation;
            txtStarterCode.Text = p.StarterCode;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            int problemId = 0;
            int.TryParse(hfProblemId.Value, out problemId);

            int marks = 50;
            int.TryParse(txtMarks.Text.Trim(), out marks);

            int testCases = 15;
            int.TryParse(txtTestCaseCount.Text.Trim(), out testCases);

            var item = new CodingProblemItem
            {
                ProblemId = problemId,
                Title = txtTitle.Text.Trim(),
                Code = txtCode.Text.Trim(),
                Topic = ddlTopic.SelectedValue,
                Difficulty = ddlDifficulty.SelectedValue,
                Marks = marks,
                TestCaseCount = testCases,
                Status = ddlStatus.SelectedValue,
                Statement = txtStatement.Text.Trim(),
                InputFormat = txtInputFormat.Text.Trim(),
                OutputFormat = txtOutputFormat.Text.Trim(),
                Constraints = txtConstraints.Text.Trim(),
                SampleInput = txtSampleInput.Text.Trim(),
                SampleOutput = txtSampleOutput.Text.Trim(),
                Explanation = txtExplanation.Text.Trim(),
                StarterCode = txtStarterCode.Text.Trim()
            };

            if (problemId > 0)
            {
                _repo.UpdateProblem(item);
                Response.Redirect("CodingQuestions.aspx?saved=1");
            }
            else
            {
                _repo.CreateProblem(item);
                Response.Redirect("CodingQuestions.aspx?created=1");
            }
        }

        private void ShowMessage(string message, string cssClass)
        {
            litMessage.Text = message;
            pnlMessage.CssClass = "users-alert " + cssClass;
            pnlMessage.Visible = true;
        }
    }
}
