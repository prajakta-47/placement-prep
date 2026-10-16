using System;
using System.Globalization;
using System.Web.UI;
using PlacementPrep.Helpers;

namespace PlacementPrep.Admin
{
    public partial class AptitudeQuestionEditor : Page
    {
        private readonly QuestionRepository _repo = new QuestionRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int id;
                if (int.TryParse(Request.QueryString["id"], out id) && id > 0)
                {
                    LoadQuestion(id);
                }
            }
        }

        private void LoadQuestion(int id)
        {
            var q = _repo.GetById(id);
            if (q == null)
            {
                ShowMessage("Aptitude question was not found.", "users-alert-error");
                return;
            }

            hfQuestionId.Value = q.QuestionId.ToString(CultureInfo.InvariantCulture);
            litPageTitle.Text = "Edit Aptitude Question (" + Server.HtmlEncode(q.Code) + ")";
            txtCode.Text = q.Code;

            if (ddlTopic.Items.FindByValue(q.Topic) != null)
                ddlTopic.SelectedValue = q.Topic;

            if (ddlDifficulty.Items.FindByValue(q.Difficulty) != null)
                ddlDifficulty.SelectedValue = q.Difficulty;

            txtMarks.Text = q.Marks.ToString(CultureInfo.InvariantCulture);
            txtNegativeMarks.Text = q.NegativeMarks.ToString("0.00", CultureInfo.InvariantCulture);

            if (ddlValidationStatus.Items.FindByValue(q.ValidationStatus) != null)
                ddlValidationStatus.SelectedValue = q.ValidationStatus;

            txtPrompt.Text = q.Prompt;
            txtOptionA.Text = q.OptionA;
            txtOptionB.Text = q.OptionB;
            txtOptionC.Text = q.OptionC;
            txtOptionD.Text = q.OptionD;

            if (ddlCorrectOption.Items.FindByValue(q.CorrectOption) != null)
                ddlCorrectOption.SelectedValue = q.CorrectOption;

            txtExplanation.Text = q.Explanation;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            int questionId = 0;
            int.TryParse(hfQuestionId.Value, out questionId);

            int marks = 2;
            int.TryParse(txtMarks.Text.Trim(), out marks);

            double negMarks = 0.5;
            double.TryParse(txtNegativeMarks.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out negMarks);

            var item = new QuestionItem
            {
                QuestionId = questionId,
                Code = txtCode.Text.Trim(),
                Category = "Aptitude",
                Topic = ddlTopic.SelectedValue,
                Difficulty = ddlDifficulty.SelectedValue,
                Marks = marks,
                NegativeMarks = negMarks,
                ValidationStatus = ddlValidationStatus.SelectedValue,
                Prompt = txtPrompt.Text.Trim(),
                OptionA = txtOptionA.Text.Trim(),
                OptionB = txtOptionB.Text.Trim(),
                OptionC = txtOptionC.Text.Trim(),
                OptionD = txtOptionD.Text.Trim(),
                CorrectOption = ddlCorrectOption.SelectedValue,
                Explanation = txtExplanation.Text.Trim()
            };

            if (questionId > 0)
            {
                _repo.UpdateQuestion(item);
                Response.Redirect("AptitudeQuestions.aspx?saved=1");
            }
            else
            {
                _repo.CreateQuestion(item);
                Response.Redirect("AptitudeQuestions.aspx?created=1");
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
