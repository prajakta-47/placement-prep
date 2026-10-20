using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using PlacementPrep.Models;

namespace PlacementPrep.Faculty
{
    public partial class Companies : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["q"]))
                {
                    txtSearchCompany.Text = Request.QueryString["q"];
                }
                BindCompanies();
            }
        }

        private void BindCompanies()
        {
            var list = FacultyDataStore.Companies.AsEnumerable();

            string query = txtSearchCompany.Text.Trim();
            if (!string.IsNullOrEmpty(query))
            {
                list = list.Where(c =>
                    (c.CompanyName != null && c.CompanyName.IndexOf(query, StringComparison.OrdinalIgnoreCase) >= 0) ||
                    (c.Role != null && c.Role.IndexOf(query, StringComparison.OrdinalIgnoreCase) >= 0) ||
                    (c.Industry != null && c.Industry.IndexOf(query, StringComparison.OrdinalIgnoreCase) >= 0));
            }

            string status = ddlStatusFilter.SelectedValue;
            if (!string.IsNullOrEmpty(status) && status != "ALL")
            {
                list = list.Where(c => string.Equals(c.Status, status, StringComparison.OrdinalIgnoreCase));
            }

            var result = list.ToList();
            rptCompanies.DataSource = result;
            rptCompanies.DataBind();

            litTotalCount.Text = result.Count.ToString();

            // Bind KPI Cards
            var all = FacultyDataStore.Companies;
            litKpiTotalPartners.Text = all.Count.ToString();
            litKpiActiveDrives.Text = all.Count(c => string.Equals(c.Status, "Active", StringComparison.OrdinalIgnoreCase)).ToString();
            decimal maxPkg = all.Count > 0 ? all.Max(c => c.PackageLPA) : 0;
            litKpiMaxPackage.Text = maxPkg.ToString("F1") + " LPA";
            decimal avgCgpa = all.Count > 0 ? all.Average(c => c.MinCgpa) : 0;
            litKpiAvgCgpa.Text = avgCgpa.ToString("F2");
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindCompanies();
        }

        protected void btnSaveCompany_Click(object sender, EventArgs e)
        {
            string name = txtModalName.Text.Trim();
            string industry = txtModalIndustry.Text.Trim();
            string role = txtModalRole.Text.Trim();
            string date = txtModalDate.Text.Trim();
            string status = ddlModalStatus.SelectedValue;

            decimal pkg = 6.5m;
            decimal.TryParse(txtModalPackage.Text.Trim(), out pkg);
            if (pkg <= 0) pkg = 6.5m;

            decimal cgpa = 7.0m;
            decimal.TryParse(txtModalCgpa.Text.Trim(), out cgpa);
            if (cgpa <= 0) cgpa = 7.0m;

            int eligible = 50;
            int.TryParse(txtModalEligible.Text.Trim(), out eligible);

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(role))
            {
                ShowAlert("Please specify both Company Name and Job Role.", true);
                return;
            }

            if (string.IsNullOrEmpty(industry)) industry = "IT Services";
            if (string.IsNullOrEmpty(date)) date = DateTime.Now.AddDays(14).ToString("MMM dd, yyyy");

            var comp = new CompanyModel
            {
                CompanyName = name,
                Industry = industry,
                Role = role,
                PackageLPA = pkg,
                MinCgpa = cgpa,
                DriveDate = date,
                Status = status,
                EligibleCount = eligible > 0 ? eligible : 50
            };

            FacultyDataStore.AddCompany(comp);
            ShowAlert("Successfully registered corporate partner and scheduled campus drive for <strong>" + Server.HtmlEncode(name) + "</strong> (" + pkg.ToString("F1") + " LPA).", false);
            BindCompanies();
        }

        protected void rptCompanies_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteCompany")
            {
                string companyName = e.CommandArgument.ToString();
                if (FacultyDataStore.DeleteCompany(companyName))
                {
                    ShowAlert("Corporate partner <strong>" + Server.HtmlEncode(companyName) + "</strong> and associated placement drives were removed.", false);
                }
                else
                {
                    ShowAlert("Could not find or remove corporate partner.", true);
                }
                BindCompanies();
            }
        }

        private void ShowAlert(string msg, bool isError)
        {
            pnlAlert.Visible = true;
            pnlAlert.CssClass = isError ? "alert-banner alert-error" : "alert-banner alert-success";
            litAlert.Text = msg;
        }
    }
}
