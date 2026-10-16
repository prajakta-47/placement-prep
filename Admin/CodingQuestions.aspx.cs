using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Helpers;

namespace PlacementPrep.Admin
{
    public partial class CodingQuestions : Page
    {
        private readonly CodingProblemRepository _repo = new CodingProblemRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindKpis();
                BindTopics();
                BindProblems();
            }
        }

        private void BindKpis()
        {
            var summary = _repo.GetKpiSummary();
            litTotalProblems.Text = summary.TotalProblems.ToString("N0", CultureInfo.InvariantCulture);
            litEasyCount.Text = summary.EasyCount.ToString("N0", CultureInfo.InvariantCulture);
            litMediumCount.Text = summary.MediumCount.ToString("N0", CultureInfo.InvariantCulture);
            litHardCount.Text = summary.HardCount.ToString("N0", CultureInfo.InvariantCulture);
        }

        private void BindTopics()
        {
            var topics = _repo.GetTopics();
            ddlTopic.Items.Clear();
            ddlTopic.Items.Add(new ListItem("All Topics", "All"));
            foreach (var t in topics)
            {
                ddlTopic.Items.Add(new ListItem(t, t));
            }
        }

        private void BindProblems()
        {
            int pageIndex = 1;
            int.TryParse(hfPageIndex.Value, out pageIndex);
            if (pageIndex < 1) pageIndex = 1;

            int pageSize = 10;
            int.TryParse(ddlPageSize.SelectedValue, out pageSize);
            if (pageSize < 1) pageSize = 10;

            string query = txtSearch.Text.Trim();
            string topic = ddlTopic.SelectedValue;
            string difficulty = ddlDifficulty.SelectedValue;
            string status = ddlStatus.SelectedValue;

            var result = _repo.SearchProblems(query, topic, difficulty, status, pageIndex, pageSize);

            if (result.Items.Count == 0)
            {
                rptProblems.Visible = false;
                pnlEmptyState.Visible = true;
                litShowingStart.Text = "0";
                litShowingEnd.Text = "0";
                litTotalCount.Text = "0";
                rptPageNumbers.DataSource = null;
                rptPageNumbers.DataBind();
                return;
            }

            rptProblems.Visible = true;
            pnlEmptyState.Visible = false;
            rptProblems.DataSource = result.Items;
            rptProblems.DataBind();

            int start = ((result.PageIndex - 1) * result.PageSize) + 1;
            int end = Math.Min(result.PageIndex * result.PageSize, result.TotalCount);
            litShowingStart.Text = start.ToString(CultureInfo.InvariantCulture);
            litShowingEnd.Text = end.ToString(CultureInfo.InvariantCulture);
            litTotalCount.Text = result.TotalCount.ToString("N0", CultureInfo.InvariantCulture);

            btnPrevPage.Enabled = result.PageIndex > 1;
            btnNextPage.Enabled = result.PageIndex < result.TotalPages;

            var pages = new List<object>();
            for (int p = 1; p <= result.TotalPages; p++)
            {
                pages.Add(new { PageNumber = p, IsCurrent = p == result.PageIndex });
            }
            rptPageNumbers.DataSource = pages;
            rptPageNumbers.DataBind();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            hfPageIndex.Value = "1";
            BindProblems();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            ddlTopic.SelectedIndex = 0;
            ddlDifficulty.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
            hfPageIndex.Value = "1";
            BindProblems();
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfPageIndex.Value = "1";
            BindProblems();
        }

        protected void btnPrevPage_Click(object sender, EventArgs e)
        {
            int pageIndex = 1;
            int.TryParse(hfPageIndex.Value, out pageIndex);
            if (pageIndex > 1)
            {
                hfPageIndex.Value = (pageIndex - 1).ToString(CultureInfo.InvariantCulture);
                BindProblems();
            }
        }

        protected void btnNextPage_Click(object sender, EventArgs e)
        {
            int pageIndex = 1;
            int.TryParse(hfPageIndex.Value, out pageIndex);
            hfPageIndex.Value = (pageIndex + 1).ToString(CultureInfo.InvariantCulture);
            BindProblems();
        }

        protected void rptPageNumbers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "GoToPage")
            {
                hfPageIndex.Value = e.CommandArgument.ToString();
                BindProblems();
            }
        }

        protected void rptProblems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int problemId = Convert.ToInt32(e.CommandArgument, CultureInfo.InvariantCulture);

            if (e.CommandName == "Preview")
            {
                ShowPreviewModal(problemId);
            }
            else if (e.CommandName == "ToggleAudit")
            {
                _repo.ToggleStatus(problemId);
                ShowMessage("Coding problem status toggled successfully.", "users-alert-success");
                BindProblems();
            }
            else if (e.CommandName == "DeleteProblem")
            {
                _repo.DeleteProblem(problemId);
                ShowMessage("Coding problem removed from question bank.", "users-alert-success");
                BindProblems();
            }
        }

        private void ShowPreviewModal(int problemId)
        {
            var p = _repo.GetById(problemId);
            if (p == null) return;

            litPreviewCode.Text = p.Code;
            litPreviewTitle.Text = p.Title;
            litPreviewTopic.Text = p.Topic;
            litPreviewDifficulty.Text = p.Difficulty;
            litPreviewStatement.Text = p.Statement;
            litPreviewInputFormat.Text = string.IsNullOrWhiteSpace(p.InputFormat) ? "Standard console input." : p.InputFormat;
            litPreviewOutputFormat.Text = string.IsNullOrWhiteSpace(p.OutputFormat) ? "Standard console output." : p.OutputFormat;
            litPreviewConstraints.Text = string.IsNullOrWhiteSpace(p.Constraints) ? "Standard platform limits apply." : p.Constraints;
            litPreviewSampleInput.Text = string.IsNullOrWhiteSpace(p.SampleInput) ? "(None)" : p.SampleInput;
            litPreviewSampleOutput.Text = string.IsNullOrWhiteSpace(p.SampleOutput) ? "(None)" : p.SampleOutput;
            litPreviewExplanation.Text = string.IsNullOrWhiteSpace(p.Explanation) ? "Follow sample input logic." : p.Explanation;
            litPreviewStarterCode.Text = string.IsNullOrWhiteSpace(p.StarterCode) ? "// Write your solution here" : p.StarterCode;
            litPreviewMarks.Text = p.Marks.ToString(CultureInfo.InvariantCulture);
            litPreviewTestCases.Text = p.TestCaseCount.ToString(CultureInfo.InvariantCulture);
            litPreviewStatus.Text = p.Status;

            pnlPreviewModal.Visible = true;
        }

        protected void btnClosePreview_Click(object sender, EventArgs e)
        {
            pnlPreviewModal.Visible = false;
        }

        private void ShowMessage(string message, string cssClass)
        {
            litMessage.Text = message;
            pnlMessage.CssClass = "users-alert " + cssClass;
            pnlMessage.Visible = true;
        }
    }
}
