using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public partial class ManageUsers : Page
    {
        private readonly UserRepository _users = new UserRepository();
        private int _totalPages = 1;

        private int CurrentPageIndex
        {
            get
            {
                int page;
                if (!int.TryParse(hfPageIndex.Value, out page) || page < 1)
                {
                    return 1;
                }

                return page;
            }
            set { hfPageIndex.Value = value.ToString(CultureInfo.InvariantCulture); }
        }

        private int CurrentPageSize
        {
            get
            {
                int size;
                if (!int.TryParse(ddlPageSize.SelectedValue, out size) || size < 1)
                {
                    return 10;
                }

                return size;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                EnsureCurrentAdminSession();

                if (!IsPostBack)
                {
                    BindDepartments();
                    BindPage();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Unable to load User Management: " + ex.Message, true);
            }
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            CurrentPageIndex = 1;
            BindPage();
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            CurrentPageIndex = 1;
            BindPage();
        }

        protected void btnPrevPage_Click(object sender, EventArgs e)
        {
            if (CurrentPageIndex > 1)
            {
                CurrentPageIndex--;
                BindPage();
            }
        }

        protected void btnNextPage_Click(object sender, EventArgs e)
        {
            if (CurrentPageIndex < _totalPages)
            {
                CurrentPageIndex++;
                BindPage();
            }
        }

        protected void rptPages_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "GoPage")
            {
                return;
            }

            int page;
            if (int.TryParse(Convert.ToString(e.CommandArgument), out page))
            {
                CurrentPageIndex = page;
                BindPage();
            }
        }

        protected void btnOpenAdd_Click(object sender, EventArgs e)
        {
            ClearMessage();
            hfEditUserId.Value = "0";
            litModalTitle.Text = "Add User";
            txtFullName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtEnrollmentId.Text = string.Empty;
            txtDepartment.Text = string.Empty;
            txtPassword.Text = string.Empty;
            ddlFormRole.SelectedValue = "Student";
            ddlFormStatus.SelectedValue = "Active";
            pnlPasswordFields.Visible = true;
            rfvPassword.Enabled = true;
            pnlUserModal.Visible = true;
            pnlImportModal.Visible = false;
        }

        protected void btnOpenImport_Click(object sender, EventArgs e)
        {
            ClearMessage();
            pnlImportResult.Visible = false;
            litImportResult.Text = string.Empty;
            pnlImportModal.Visible = true;
            pnlUserModal.Visible = false;
        }

        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            pnlUserModal.Visible = false;
            rfvPassword.Enabled = false;
        }

        protected void btnCloseImport_Click(object sender, EventArgs e)
        {
            pnlImportModal.Visible = false;
        }

        protected void btnSaveUser_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                pnlUserModal.Visible = true;
                return;
            }

            int editId;
            int.TryParse(hfEditUserId.Value, out editId);
            var isNew = editId <= 0;

            var user = new AppUser
            {
                UserId = editId,
                FullName = txtFullName.Text.Trim(),
                Email = txtEmail.Text.Trim(),
                EnrollmentId = txtEnrollmentId.Text.Trim(),
                UserRole = ddlFormRole.SelectedValue,
                Department = txtDepartment.Text.Trim(),
                AccountStatus = ddlFormStatus.SelectedValue
            };

            string validationError;
            if (!UserRepository.ValidateUserForSave(user, isNew, out validationError))
            {
                ShowMessage(validationError, true);
                pnlUserModal.Visible = true;
                return;
            }

            try
            {
                if (_users.EmailExists(user.Email, isNew ? (int?)null : editId))
                {
                    ShowMessage("A user with this email already exists.", true);
                    pnlUserModal.Visible = true;
                    return;
                }

                // Self-suspension guard: prevent administrator from suspending their own active session
                if (!isNew && IsCurrentAdmin(editId) &&
                    string.Equals(user.AccountStatus, "Suspended", StringComparison.OrdinalIgnoreCase))
                {
                    ShowMessage("You cannot suspend your own active administrator account.", true);
                    pnlUserModal.Visible = true;
                    return;
                }

                if (isNew)
                {
                    string passwordError;
                    if (!PasswordHelper.MeetsComplexity(txtPassword.Text, out passwordError))
                    {
                        ShowMessage(passwordError, true);
                        pnlUserModal.Visible = true;
                        return;
                    }

                    var hash = PasswordHelper.HashPassword(txtPassword.Text);
                    _users.CreateUser(user, hash);
                    ShowMessage("User <strong>" + Server.HtmlEncode(user.FullName) + "</strong> created successfully (In-Memory Sample Store).", false);
                }
                else
                {
                    _users.UpdateUser(user);
                    ShowMessage("User <strong>" + Server.HtmlEncode(user.FullName) + "</strong> updated successfully (In-Memory Sample Store).", false);
                }

                pnlUserModal.Visible = false;
                rfvPassword.Enabled = false;
                BindDepartments();
                BindPage();
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, true);
                pnlUserModal.Visible = true;
            }
        }

        protected void btnRunImport_Click(object sender, EventArgs e)
        {
            pnlImportModal.Visible = true;

            if (!fuImport.HasFile)
            {
                ShowImportResult("Please choose a CSV file to import.", true);
                return;
            }

            var extension = Path.GetExtension(fuImport.FileName);
            if (!string.Equals(extension, ".csv", StringComparison.OrdinalIgnoreCase))
            {
                ShowImportResult("Only .csv files are supported.", true);
                return;
            }

            if (fuImport.PostedFile.ContentLength > 2 * 1024 * 1024)
            {
                ShowImportResult("CSV file must be 2 MB or smaller.", true);
                return;
            }

            try
            {
                var rows = ParseCsv(fuImport.PostedFile.InputStream);
                if (rows.Count == 0)
                {
                    ShowImportResult("No data rows found. Ensure the CSV has a header and at least one user row.", true);
                    return;
                }

                var result = _users.ImportUsers(rows, _ => PasswordHelper.GenerateTemporaryPassword());
                var summary = string.Format(
                    CultureInfo.InvariantCulture,
                    "Import finished - Created: {0}, Skipped (duplicates): {1}, Failed: {2}.",
                    result.Created, result.Skipped, result.Failed);

                if (result.Messages.Count > 0)
                {
                    summary += "<ul>" +
                               string.Join("", result.Messages.Take(25).Select(m => "<li>" + Server.HtmlEncode(m) + "</li>")) +
                               "</ul>";
                    if (result.Messages.Count > 25)
                    {
                        summary += "<p>...and " + (result.Messages.Count - 25) + " more messages.</p>";
                    }
                }

                ShowImportResult(summary, result.Failed > 0 && result.Created == 0);
                if (result.Created > 0)
                {
                    ShowMessage(summary.Split(new[] { '-' }, 2)[0].Trim() + " (In-Memory Sample Store).", result.Failed > 0);
                    BindDepartments();
                    BindPage();
                }
            }
            catch (Exception ex)
            {
                ShowImportResult("Import failed: " + Server.HtmlEncode(ex.Message), true);
            }
        }

        protected void rptUsers_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem)
            {
                return;
            }

            var user = (AppUser)e.Item.DataItem;
            var lnkSuspend = (LinkButton)e.Item.FindControl("lnkSuspend");
            if (lnkSuspend == null)
            {
                return;
            }

            if (string.Equals(user.AccountStatus, "Suspended", StringComparison.OrdinalIgnoreCase))
            {
                lnkSuspend.Text = "Activate";
            }
            else
            {
                lnkSuspend.Text = "Suspend";
            }
        }

        protected void rptUsers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int userId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out userId))
            {
                return;
            }

            try
            {
                switch (e.CommandName)
                {
                    case "EditUser":
                        OpenEditModal(userId);
                        break;
                    case "ToggleStatus":
                        ToggleStatus(userId);
                        break;
                    case "ResetPassword":
                        ResetPassword(userId);
                        break;
                }
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, true);
            }
        }

        protected string FormatLastActive(DateTime? lastActiveAt)
        {
            if (!lastActiveAt.HasValue)
            {
                return "-";
            }

            var utc = DateTime.SpecifyKind(lastActiveAt.Value, DateTimeKind.Utc);
            var delta = DateTime.UtcNow - utc;
            if (delta.TotalMinutes < 1) return "Just now";
            if (delta.TotalMinutes < 60) return ((int)delta.TotalMinutes) + "m ago";
            if (delta.TotalHours < 24) return ((int)delta.TotalHours) + "h ago";
            if (delta.TotalDays < 14) return ((int)delta.TotalDays) + "d ago";
            return lastActiveAt.Value.ToString("MMM d, yyyy", CultureInfo.InvariantCulture);
        }

        protected string FormatCreated(DateTime createdAt)
        {
            return createdAt.ToString("MMM d, yyyy", CultureInfo.InvariantCulture);
        }

        private void BindPage()
        {
            var result = _users.SearchUsers(
                txtSearch.Text,
                ddlRole.SelectedValue,
                ddlStatus.SelectedValue,
                ddlDepartment.SelectedValue,
                CurrentPageIndex,
                CurrentPageSize);

            _totalPages = Math.Max(1, result.TotalPages);
            if (CurrentPageIndex > _totalPages)
            {
                CurrentPageIndex = _totalPages;
                result = _users.SearchUsers(
                    txtSearch.Text,
                    ddlRole.SelectedValue,
                    ddlStatus.SelectedValue,
                    ddlDepartment.SelectedValue,
                    CurrentPageIndex,
                    CurrentPageSize);
                _totalPages = Math.Max(1, result.TotalPages);
            }

            rptUsers.DataSource = result.Items;
            rptUsers.DataBind();
            pnlEmpty.Visible = result.Items.Count == 0;

            var start = result.TotalCount == 0 ? 0 : ((result.PageIndex - 1) * result.PageSize) + 1;
            var end = Math.Min(result.PageIndex * result.PageSize, result.TotalCount);
            litPageInfo.Text = string.Format(
                CultureInfo.InvariantCulture,
                "Showing {0} to {1} of {2} users",
                start, end, result.TotalCount);

            btnPrevPage.Enabled = result.PageIndex > 1;
            btnNextPage.Enabled = result.PageIndex < _totalPages;
            BindPageNumbers(result.PageIndex, _totalPages);
            BindKpis();
        }

        private void BindKpis()
        {
            var kpi = _users.GetKpiSummary();
            litTotalAccounts.Text = kpi.TotalAccounts.ToString("N0", CultureInfo.InvariantCulture);
            litFacultyCount.Text = kpi.FacultyMembers.ToString("N0", CultureInfo.InvariantCulture);
            litStudentCount.Text = kpi.EnrolledStudents.ToString("N0", CultureInfo.InvariantCulture);
            litAdminCount.Text = kpi.Administrators.ToString("N0", CultureInfo.InvariantCulture);

            litTotalMeta.Text = "<strong class=\"users-kpi-good\">+3.8%</strong> - capacity verified";
            litFacultyMeta.Text = "<strong>" + kpi.FacultyDepartments + " Depts</strong> - evaluators - 42 online";
            litStudentMeta.Text = "<strong class=\"users-kpi-good\">+12.1%</strong> - Placement Batch '25 - 97.8% verified";
            studentBar.Style["width"] = "97.8%";
        }

        private void BindDepartments()
        {
            var selected = ddlDepartment.SelectedValue;
            ddlDepartment.Items.Clear();
            ddlDepartment.Items.Add(new ListItem("All Departments", "All"));
            foreach (var dept in _users.GetDepartments())
            {
                ddlDepartment.Items.Add(new ListItem(dept, dept));
            }

            if (!string.IsNullOrEmpty(selected) && ddlDepartment.Items.FindByValue(selected) != null)
            {
                ddlDepartment.SelectedValue = selected;
            }
        }

        private void BindPageNumbers(int current, int total)
        {
            var pages = new List<object>();
            var start = Math.Max(1, current - 2);
            var end = Math.Min(total, start + 4);
            start = Math.Max(1, end - 4);

            for (var i = start; i <= end; i++)
            {
                pages.Add(new { PageNumber = i, IsCurrent = i == current });
            }

            rptPages.DataSource = pages;
            rptPages.DataBind();
        }

        private void OpenEditModal(int userId)
        {
            var user = _users.GetById(userId);
            if (user == null)
            {
                ShowMessage("User not found.", true);
                return;
            }

            hfEditUserId.Value = user.UserId.ToString(CultureInfo.InvariantCulture);
            litModalTitle.Text = "Edit User";
            txtFullName.Text = user.FullName;
            txtEmail.Text = user.Email;
            txtEnrollmentId.Text = user.EnrollmentId ?? string.Empty;
            txtDepartment.Text = user.Department ?? string.Empty;
            ddlFormRole.SelectedValue = user.UserRole;
            ddlFormStatus.SelectedValue = user.AccountStatus;
            txtPassword.Text = string.Empty;
            pnlPasswordFields.Visible = false;
            rfvPassword.Enabled = false;
            pnlUserModal.Visible = true;
            pnlImportModal.Visible = false;
        }

        private void ToggleStatus(int userId)
        {
            var user = _users.GetById(userId);
            if (user == null)
            {
                ShowMessage("User not found.", true);
                return;
            }

            var nextStatus = string.Equals(user.AccountStatus, "Active", StringComparison.OrdinalIgnoreCase)
                ? "Suspended"
                : "Active";

            if (string.Equals(nextStatus, "Suspended", StringComparison.OrdinalIgnoreCase) && IsCurrentAdmin(userId))
            {
                ShowMessage("You cannot suspend your own active administrator account.", true);
                return;
            }

            _users.SetAccountStatus(userId, nextStatus);
            ShowMessage(
                string.Equals(nextStatus, "Suspended", StringComparison.OrdinalIgnoreCase)
                    ? "User account for <strong>" + Server.HtmlEncode(user.FullName) + "</strong> suspended."
                    : "User account for <strong>" + Server.HtmlEncode(user.FullName) + "</strong> activated.",
                false);
            BindPage();
        }

        private void ResetPassword(int userId)
        {
            var user = _users.GetById(userId);
            if (user == null)
            {
                ShowMessage("User not found.", true);
                return;
            }

            var temporary = PasswordHelper.GenerateTemporaryPassword();
            var hash = PasswordHelper.HashPassword(temporary);
            _users.ResetPasswordHash(userId, hash);

            // Display temporary password once in banner
            ShowMessage(
                "Temporary password for <strong>" + Server.HtmlEncode(user.FullName) +
                "</strong>: <code>" + Server.HtmlEncode(temporary) +
                "</code>. Copy it now - it will not be shown again. (In-Memory Sample Mode: credentials do not persist across server restarts).",
                false);
        }

        private void EnsureCurrentAdminSession()
        {
            if (Session["UserId"] != null)
            {
                return;
            }

            var adminId = _users.GetPrimaryAdminUserId();
            if (adminId.HasValue)
            {
                Session["UserId"] = adminId.Value;
                Session["UserRole"] = "Admin";
            }
        }

        private bool IsCurrentAdmin(int userId)
        {
            if (Session["UserId"] == null)
            {
                return false;
            }

            int currentId;
            if (!int.TryParse(Convert.ToString(Session["UserId"]), out currentId))
            {
                return false;
            }

            return currentId == userId;
        }

        private static List<AppUser> ParseCsv(Stream stream)
        {
            var users = new List<AppUser>();
            using (var reader = new StreamReader(stream, Encoding.UTF8, true, 1024, true))
            {
                var headerLine = reader.ReadLine();
                if (string.IsNullOrWhiteSpace(headerLine))
                {
                    return users;
                }

                var headers = SplitCsvLine(headerLine)
                    .Select(h => h.Trim().Trim('"').ToLowerInvariant())
                    .ToList();

                RequireHeader(headers, "fullname");
                RequireHeader(headers, "email");
                RequireHeader(headers, "userrole");

                string line;
                while ((line = reader.ReadLine()) != null)
                {
                    if (string.IsNullOrWhiteSpace(line))
                    {
                        continue;
                    }

                    var cols = SplitCsvLine(line);
                    var map = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
                    for (var i = 0; i < headers.Count && i < cols.Count; i++)
                    {
                        map[headers[i]] = cols[i].Trim().Trim('"');
                    }

                    users.Add(new AppUser
                    {
                        FullName = GetMap(map, "fullname"),
                        Email = GetMap(map, "email"),
                        UserRole = GetMap(map, "userrole"),
                        Department = GetMap(map, "department"),
                        EnrollmentId = GetMap(map, "enrollmentid"),
                        AccountStatus = string.IsNullOrWhiteSpace(GetMap(map, "accountstatus"))
                            ? "Active"
                            : GetMap(map, "accountstatus")
                    });
                }
            }

            return users;
        }

        private static void RequireHeader(IList<string> headers, string name)
        {
            if (!headers.Contains(name))
            {
                throw new InvalidOperationException(
                    "CSV is missing required column '" + name + "'. Expected: FullName,Email,UserRole,Department,EnrollmentId.");
            }
        }

        private static string GetMap(Dictionary<string, string> map, string key)
        {
            string value;
            return map.TryGetValue(key, out value) ? value : string.Empty;
        }

        private static List<string> SplitCsvLine(string line)
        {
            var result = new List<string>();
            var current = new StringBuilder();
            var inQuotes = false;

            for (var i = 0; i < line.Length; i++)
            {
                var ch = line[i];
                if (ch == '"')
                {
                    if (inQuotes && i + 1 < line.Length && line[i + 1] == '"')
                    {
                        current.Append('"');
                        i++;
                    }
                    else
                    {
                        inQuotes = !inQuotes;
                    }
                }
                else if (ch == ',' && !inQuotes)
                {
                    result.Add(current.ToString());
                    current.Clear();
                }
                else
                {
                    current.Append(ch);
                }
            }

            result.Add(current.ToString());
            return result;
        }

        private void ShowMessage(string html, bool isError)
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = isError ? "users-alert error" : "users-alert success";
            litMessage.Text = html;
        }

        private void ClearMessage()
        {
            pnlMessage.Visible = false;
            litMessage.Text = string.Empty;
        }

        private void ShowImportResult(string html, bool isError)
        {
            pnlImportResult.Visible = true;
            pnlImportResult.CssClass = isError ? "users-import-result error" : "users-import-result success";
            litImportResult.Text = html;
        }
    }
}
