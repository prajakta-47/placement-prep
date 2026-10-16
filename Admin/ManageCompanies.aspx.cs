using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public partial class ManageCompanies : Page
    {
        private readonly CompanyRepository _companyRepo = new CompanyRepository();
        private readonly PlacementDriveRepository _driveRepo = new PlacementDriveRepository();
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
                BindKpis();
                BindFilters();
                BindPage();
            }
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            CurrentPageIndex = 1;
            BindPage();
        }

        protected void btnResetFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            ddlIndustryFilter.SelectedValue = "All";
            ddlStatusFilter.SelectedValue = "All";
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
            if (e.CommandName != "GoPage") return;

            int page;
            if (int.TryParse(Convert.ToString(e.CommandArgument), out page))
            {
                CurrentPageIndex = page;
                BindPage();
            }
        }

        protected void rptCompanies_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int companyId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out companyId)) return;

            try
            {
                switch (e.CommandName)
                {
                    case "QuickView":
                        OpenDetailsModal(companyId);
                        break;
                    case "EditCompany":
                        OpenEditModal(companyId);
                        break;
                    case "ToggleStatus":
                        _companyRepo.ToggleHiringStatus(companyId);
                        ShowMessage("Hiring status updated for company (In-Memory Sample Store).", false);
                        BindKpis();
                        BindPage();
                        break;
                    case "DeleteCompany":
                        string err;
                        if (_companyRepo.Delete(companyId, out err))
                        {
                            ShowMessage("Company partner removed from directory (In-Memory Sample Store).", false);
                            BindKpis();
                            BindPage();
                        }
                        else
                        {
                            ShowMessage(err, true);
                        }
                        break;
                }
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message, true);
            }
        }

        protected void btnOpenAddCompany_Click(object sender, EventArgs e)
        {
            ClearMessage();
            hfEditCompanyId.Value = "0";
            litModalTitle.Text = "Add Corporate Partner";
            txtCompanyName.Text = string.Empty;
            ddlFormIndustry.SelectedValue = "Software & Internet";
            ddlFormTier.SelectedValue = "Tier 1 (Dream)";
            ddlFormHiringStatus.SelectedValue = "Hiring This Season";
            txtWebsiteUrl.Text = "https://";
            txtRecruiterName.Text = string.Empty;
            txtRecruiterEmail.Text = string.Empty;
            txtRecruiterPhone.Text = string.Empty;
            txtAvgPackage.Text = "12.0";
            txtHighestPackage.Text = "24.0";
            txtLocations.Text = "Bangalore, Hyderabad";
            txtAbout.Text = string.Empty;

            pnlCompanyModal.Visible = true;
            pnlDetailsModal.Visible = false;
        }

        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            pnlCompanyModal.Visible = false;
        }

        protected void btnCloseDetails_Click(object sender, EventArgs e)
        {
            pnlDetailsModal.Visible = false;
        }

        protected void btnSaveCompany_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                pnlCompanyModal.Visible = true;
                return;
            }

            int editId;
            int.TryParse(hfEditCompanyId.Value, out editId);
            var isNew = editId <= 0;

            var companyName = txtCompanyName.Text.Trim();

            // Duplicate check
            if (_companyRepo.CompanyExists(companyName, isNew ? (int?)null : editId))
            {
                ShowMessage("A corporate partner with the name <strong>" + Server.HtmlEncode(companyName) + "</strong> is already registered.", true);
                pnlCompanyModal.Visible = true;
                return;
            }

            double avgPkg;
            if (!double.TryParse(txtAvgPackage.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out avgPkg) || avgPkg < 0 || avgPkg > 150)
            {
                ShowMessage("Average package must be between 0.0 and 150.0 LPA.", true);
                pnlCompanyModal.Visible = true;
                return;
            }

            double maxPkg;
            if (!double.TryParse(txtHighestPackage.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out maxPkg) || maxPkg < 0 || maxPkg > 150)
            {
                ShowMessage("Highest package must be between 0.0 and 150.0 LPA.", true);
                pnlCompanyModal.Visible = true;
                return;
            }

            if (maxPkg < avgPkg)
            {
                ShowMessage("Highest package cannot be lower than average package.", true);
                pnlCompanyModal.Visible = true;
                return;
            }

            string err;
            if (isNew)
            {
                var newCompany = new CompanyItem
                {
                    CompanyName = companyName,
                    Industry = ddlFormIndustry.SelectedValue,
                    Tier = ddlFormTier.SelectedValue,
                    HiringStatus = ddlFormHiringStatus.SelectedValue,
                    WebsiteUrl = txtWebsiteUrl.Text.Trim(),
                    RecruiterName = txtRecruiterName.Text.Trim(),
                    RecruiterEmail = txtRecruiterEmail.Text.Trim(),
                    RecruiterPhone = txtRecruiterPhone.Text.Trim(),
                    AveragePackageLpa = avgPkg,
                    HighestPackageLpa = maxPkg,
                    Locations = txtLocations.Text.Trim(),
                    About = txtAbout.Text.Trim(),
                    ActiveDrivesCount = 0,
                    TotalOffersMade = 0
                };

                if (_companyRepo.Add(newCompany, out err))
                {
                    ShowMessage("Corporate partner <strong>" + Server.HtmlEncode(companyName) + "</strong> added successfully (In-Memory Sample Store).", false);
                    pnlCompanyModal.Visible = false;
                    BindKpis();
                    BindFilters();
                    BindPage();
                }
                else
                {
                    ShowMessage(err, true);
                    pnlCompanyModal.Visible = true;
                }
            }
            else
            {
                var existing = _companyRepo.GetById(editId);
                if (existing == null)
                {
                    ShowMessage("Company record not found.", true);
                    return;
                }

                existing.CompanyName = companyName;
                existing.Industry = ddlFormIndustry.SelectedValue;
                existing.Tier = ddlFormTier.SelectedValue;
                existing.HiringStatus = ddlFormHiringStatus.SelectedValue;
                existing.WebsiteUrl = txtWebsiteUrl.Text.Trim();
                existing.RecruiterName = txtRecruiterName.Text.Trim();
                existing.RecruiterEmail = txtRecruiterEmail.Text.Trim();
                existing.RecruiterPhone = txtRecruiterPhone.Text.Trim();
                existing.AveragePackageLpa = avgPkg;
                existing.HighestPackageLpa = maxPkg;
                existing.Locations = txtLocations.Text.Trim();
                existing.About = txtAbout.Text.Trim();

                if (_companyRepo.Update(existing, out err))
                {
                    ShowMessage("Corporate partner <strong>" + Server.HtmlEncode(companyName) + "</strong> updated successfully (In-Memory Sample Store).", false);
                    pnlCompanyModal.Visible = false;
                    BindKpis();
                    BindFilters();
                    BindPage();
                }
                else
                {
                    ShowMessage(err, true);
                    pnlCompanyModal.Visible = true;
                }
            }
        }

        private void OpenDetailsModal(int companyId)
        {
            var company = _companyRepo.GetById(companyId);
            if (company == null)
            {
                ShowMessage("Company record not found.", true);
                return;
            }

            litDetailsInitials.Text = Server.HtmlEncode(company.Initials);
            litDetailsName.Text = Server.HtmlEncode(company.CompanyName);
            litDetailsIndustry.Text = Server.HtmlEncode(company.Industry);
            litDetailsLocations.Text = Server.HtmlEncode(company.Locations);

            if (!string.IsNullOrWhiteSpace(company.WebsiteUrl))
            {
                lnkDetailsWebsite.HRef = company.WebsiteUrl;
                lnkDetailsWebsite.Visible = true;
            }
            else
            {
                lnkDetailsWebsite.Visible = false;
            }

            litDetailsTier.Text = Server.HtmlEncode(company.Tier);
            badgeDetailsTier.Attributes["class"] = company.TierClass;

            litDetailsStatus.Text = Server.HtmlEncode(company.HiringStatus);
            badgeDetailsStatus.Attributes["class"] = company.StatusClass;

            litDetailsAvgPackage.Text = company.AveragePackageLpa.ToString("0.0", CultureInfo.InvariantCulture);
            litDetailsHighestPackage.Text = company.HighestPackageLpa.ToString("0.0", CultureInfo.InvariantCulture);
            litDetailsActiveDrives.Text = company.ActiveDrivesCount.ToString(CultureInfo.InvariantCulture);
            litDetailsTotalOffers.Text = company.TotalOffersMade.ToString(CultureInfo.InvariantCulture);

            litDetailsRecruiterName.Text = Server.HtmlEncode(company.RecruiterName);
            litDetailsRecruiterEmail.Text = Server.HtmlEncode(company.RecruiterEmail);
            litDetailsRecruiterPhone.Text = Server.HtmlEncode(company.RecruiterPhone);
            litDetailsAbout.Text = Server.HtmlEncode(company.About);

            btnFullDetailsPage.HRef = ResolveUrl("~/Admin/CompanyDetails.aspx?id=" + company.CompanyId);

            // Associated placement drives
            var drives = _driveRepo.GetByCompanyName(company.CompanyName);
            if (drives != null && drives.Count > 0)
            {
                var sb = new System.Text.StringBuilder();
                sb.Append("<div class='table-scroll'><table class='users-table compact-table'>");
                sb.Append("<thead><tr><th>Drive Code &amp; Role</th><th>Drive Date</th><th>Status</th><th>Openings</th><th>Package</th><th>Actions</th></tr></thead><tbody>");
                foreach (var d in drives)
                {
                    sb.Append("<tr>");
                    sb.AppendFormat("<td><strong>{0}</strong><br/><small class='text-muted'>{1}</small></td>",
                        Server.HtmlEncode(d.DriveCode), Server.HtmlEncode(d.JobRole));
                    sb.AppendFormat("<td>{0}</td>", d.DriveDate.ToString("MMM dd, yyyy"));
                    sb.AppendFormat("<td><span class='{0}'><i></i>{1}</span></td>", d.StatusClass, Server.HtmlEncode(d.DriveStatus));
                    sb.AppendFormat("<td><strong>{0}</strong></td>", d.Openings);
                    sb.AppendFormat("<td>{0}</td>", Server.HtmlEncode(d.PackageDisplay));
                    sb.AppendFormat("<td><a href='{0}' class='table-link'>View Drive &rarr;</a></td>",
                        ResolveUrl("~/Admin/DriveDetails.aspx?id=" + d.DriveId));
                    sb.Append("</tr>");
                }
                sb.Append("</tbody></table></div>");
                litDetailsDrivesHtml.Text = sb.ToString();
            }
            else
            {
                litDetailsDrivesHtml.Text = "<p class='users-hint'>No placement drives currently registered for this company.</p>";
            }

            pnlDetailsModal.Visible = true;
            pnlCompanyModal.Visible = false;
        }

        private void OpenEditModal(int companyId)
        {
            var company = _companyRepo.GetById(companyId);
            if (company == null)
            {
                ShowMessage("Company record not found.", true);
                return;
            }

            hfEditCompanyId.Value = company.CompanyId.ToString(CultureInfo.InvariantCulture);
            litModalTitle.Text = "Edit Corporate Partner (" + company.CompanyName + ")";
            txtCompanyName.Text = company.CompanyName;

            if (ddlFormIndustry.Items.FindByValue(company.Industry) != null)
                ddlFormIndustry.SelectedValue = company.Industry;

            if (ddlFormTier.Items.FindByValue(company.Tier) != null)
                ddlFormTier.SelectedValue = company.Tier;

            if (ddlFormHiringStatus.Items.FindByValue(company.HiringStatus) != null)
                ddlFormHiringStatus.SelectedValue = company.HiringStatus;

            txtWebsiteUrl.Text = company.WebsiteUrl;
            txtRecruiterName.Text = company.RecruiterName;
            txtRecruiterEmail.Text = company.RecruiterEmail;
            txtRecruiterPhone.Text = company.RecruiterPhone;
            txtAvgPackage.Text = company.AveragePackageLpa.ToString("0.0", CultureInfo.InvariantCulture);
            txtHighestPackage.Text = company.HighestPackageLpa.ToString("0.0", CultureInfo.InvariantCulture);
            txtLocations.Text = company.Locations;
            txtAbout.Text = company.About;

            pnlCompanyModal.Visible = true;
            pnlDetailsModal.Visible = false;
        }

        private void BindKpis()
        {
            var kpis = _companyRepo.GetKpiSummary();
            litKpiTotalCompanies.Text = kpis.TotalCompanies.ToString(CultureInfo.InvariantCulture);
            litKpiActiveHiring.Text = kpis.ActiveHiringCount.ToString(CultureInfo.InvariantCulture);
            litKpiActiveDrives.Text = kpis.ActiveDrivesCount.ToString(CultureInfo.InvariantCulture);
            litKpiOffersPlaced.Text = kpis.TotalOffersPlaced.ToString(CultureInfo.InvariantCulture);
        }

        private void BindFilters()
        {
            var selInd = ddlIndustryFilter.SelectedValue;
            ddlIndustryFilter.Items.Clear();
            ddlIndustryFilter.Items.Add(new ListItem("All Industries", "All"));
            foreach (var ind in _companyRepo.GetIndustries())
            {
                ddlIndustryFilter.Items.Add(new ListItem(ind, ind));
            }
            if (!string.IsNullOrEmpty(selInd) && ddlIndustryFilter.Items.FindByValue(selInd) != null)
                ddlIndustryFilter.SelectedValue = selInd;
        }

        private void BindPage()
        {
            var result = _companyRepo.Search(
                txtSearch.Text,
                ddlIndustryFilter.SelectedValue,
                ddlStatusFilter.SelectedValue,
                CurrentPageIndex,
                CurrentPageSize);

            _totalPages = Math.Max(1, result.TotalPages);
            if (CurrentPageIndex > _totalPages)
            {
                CurrentPageIndex = _totalPages;
                result = _companyRepo.Search(
                    txtSearch.Text,
                    ddlIndustryFilter.SelectedValue,
                    ddlStatusFilter.SelectedValue,
                    CurrentPageIndex,
                    CurrentPageSize);
            }

            rptCompanies.DataSource = result.Items;
            rptCompanies.DataBind();

            pnlEmpty.Visible = result.TotalCount == 0;
            rptCompanies.Visible = result.TotalCount > 0;

            int startRow = result.TotalCount == 0 ? 0 : (result.PageIndex - 1) * result.PageSize + 1;
            int endRow = Math.Min(result.PageIndex * result.PageSize, result.TotalCount);
            litPageInfo.Text = string.Format(CultureInfo.InvariantCulture, "Showing {0}-{1} of {2} companies", startRow, endRow, result.TotalCount);

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

        private void ClearMessage()
        {
            pnlMessage.Visible = false;
            litMessage.Text = string.Empty;
        }
    }
}
