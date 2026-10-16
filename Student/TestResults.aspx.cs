using System;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class TestResults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string cat = Request.QueryString["cat"];
                if (!string.IsNullOrEmpty(cat))
                {
                    if (cat == "Logical")
                    {
                        lblTestTitle.Text = "Logical Reasoning Assessment - Result";
                        lblCategoryBreadcrumb.Text = "Logical Reasoning";
                    }
                    else if (cat == "Verbal")
                    {
                        lblTestTitle.Text = "Verbal Ability Assessment - Result";
                        lblCategoryBreadcrumb.Text = "Verbal Ability";
                    }
                    else if (cat == "DI")
                    {
                        lblTestTitle.Text = "Data Interpretation Benchmark - Result";
                        lblCategoryBreadcrumb.Text = "Data Interpretation";
                    }
                }
            }
        }
    }
}
