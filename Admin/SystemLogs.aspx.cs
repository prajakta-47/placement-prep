using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public partial class SystemLogs : Page
    {
        private readonly AuditLogRepository _logRepo = new AuditLogRepository();
        private int _totalPages = 1;

        private int CurrentPageIndex
        {
            get
            {
                int page;
                return int.TryParse(hfPageIndex.Value, out page) && page > 0 ? page : 1;
            }
            set
            {
                hfPageIndex.Value = Math.Max(1, value).ToString(CultureInfo.InvariantCulture);
            }
        }

        private int CurrentPageSize
        {
            get
            {
                int size;
                return int.TryParse(ddlPageSize.SelectedValue, out size) && size > 0 ? size : 10;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindLogs();
            }
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            CurrentPageIndex = 1;
            BindLogs();
        }

        protected void btnResetFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            ddlModuleFilter.SelectedValue = "All";
            ddlSeverityFilter.SelectedValue = "All";
            CurrentPageIndex = 1;
            BindLogs();
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            CurrentPageIndex = 1;
            BindLogs();
        }

        protected void btnPrevPage_Click(object sender, EventArgs e)
        {
            if (CurrentPageIndex > 1)
            {
                CurrentPageIndex--;
                BindLogs();
            }
        }

        protected void btnNextPage_Click(object sender, EventArgs e)
        {
            if (CurrentPageIndex < _totalPages)
            {
                CurrentPageIndex++;
                BindLogs();
            }
        }

        protected void rptPages_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "GoPage") return;

            int page;
            if (int.TryParse(Convert.ToString(e.CommandArgument), out page))
            {
                CurrentPageIndex = page;
                BindLogs();
            }
        }

        protected void rptLogs_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "ViewDetails") return;

            int eventId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out eventId)) return;

            var log = _logRepo.GetById(eventId);
            if (log == null)
            {
                ShowMessage("Audit log event not found.", true);
                return;
            }

            litModalEventId.Text = log.EventId.ToString(CultureInfo.InvariantCulture);
            litModalAction.Text = Server.HtmlEncode(log.Action);
            litModalModule.Text = Server.HtmlEncode(log.Module);
            litModalTimestamp.Text = log.Timestamp.ToString("yyyy-MM-dd HH:mm:ss") + " UTC";
            litModalIp.Text = Server.HtmlEncode(log.IpAddress);

            litModalSeverity.Text = Server.HtmlEncode(log.Severity);
            badgeModalSeverity.Attributes["class"] = log.SeverityBadgeClass;

            litModalActor.Text = Server.HtmlEncode(log.ActorName) + " (" + Server.HtmlEncode(log.ActorRole) + ")";
            litModalTarget.Text = Server.HtmlEncode(log.TargetEntity);
            litModalMessage.Text = Server.HtmlEncode(log.Message);
            litModalPayload.Text = string.IsNullOrWhiteSpace(log.DetailsJson) ? "{}" : Server.HtmlEncode(log.DetailsJson);

            pnlEventModal.Visible = true;
        }

        protected void btnCloseEventModal_Click(object sender, EventArgs e)
        {
            pnlEventModal.Visible = false;
        }

        protected void btnClearLogs_Click(object sender, EventArgs e)
        {
            _logRepo.ClearLogs();
            ShowMessage("Demonstration audit trail cleared. Reset to baseline system event.", false);
            CurrentPageIndex = 1;
            BindLogs();
        }

        protected void btnExportCsv_Click(object sender, EventArgs e)
        {
            try
            {
                var csv = _logRepo.ExportToCsv(txtSearch.Text, ddlModuleFilter.SelectedValue, ddlSeverityFilter.SelectedValue);
                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=System_Audit_Trail_" + DateTime.UtcNow.ToString("yyyyMMdd_HHmmss") + ".csv");
                Response.Charset = "utf-8";
                Response.ContentType = "text/csv";
                Response.Output.Write(csv);
                Response.Flush();
                Response.End();
            }
            catch (System.Threading.ThreadAbortException)
            {
                // Expected when calling Response.End()
            }
        }

        private void BindLogs()
        {
            var result = _logRepo.Search(
                txtSearch.Text,
                ddlModuleFilter.SelectedValue,
                ddlSeverityFilter.SelectedValue,
                null,
                null,
                CurrentPageIndex,
                CurrentPageSize);

            _totalPages = Math.Max(1, result.TotalPages);
            if (CurrentPageIndex > _totalPages)
            {
                CurrentPageIndex = _totalPages;
                result = _logRepo.Search(
                    txtSearch.Text,
                    ddlModuleFilter.SelectedValue,
                    ddlSeverityFilter.SelectedValue,
                    null,
                    null,
                    CurrentPageIndex,
                    CurrentPageSize);
            }

            rptLogs.DataSource = result.Items;
            rptLogs.DataBind();

            pnlEmpty.Visible = result.TotalCount == 0;
            rptLogs.Visible = result.TotalCount > 0;

            int startRow = result.TotalCount == 0 ? 0 : (result.PageIndex - 1) * result.PageSize + 1;
            int endRow = Math.Min(result.PageIndex * result.PageSize, result.TotalCount);
            litPageInfo.Text = string.Format(CultureInfo.InvariantCulture, "Showing {0}-{1} of {2} log entries", startRow, endRow, result.TotalCount);

            btnPrevPage.Enabled = result.PageIndex > 1;
            btnNextPage.Enabled = result.PageIndex < _totalPages;

            var pages = new List<object>();
            int window = 5;
            int startPage = Math.Max(1, result.PageIndex - window / 2);
            int endPage = Math.Min(_totalPages, startPage + window - 1);
            if (endPage - startPage + 1 < window)
            {
                startPage = Math.Max(1, endPage - window + 1);
            }

            for (int p = startPage; p <= endPage; p++)
            {
                pages.Add(new
                {
                    PageNumber = p,
                    IsCurrent = (p == result.PageIndex)
                });
            }

            rptPages.DataSource = pages;
            rptPages.DataBind();
        }

        private void ShowMessage(string message, bool isError)
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = isError ? "users-alert users-alert-error" : "users-alert users-alert-success";
            litMessage.Text = message;
        }
    }
}
