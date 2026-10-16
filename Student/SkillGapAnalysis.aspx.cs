using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementPrep
{
    public partial class SkillGapAnalysis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblTargetRole.Text = ddlRoleSelector.SelectedValue;
                lblOverallMatch.Text = "68%";
            }
        }

        protected void ddlRoleSelector_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedRole = ddlRoleSelector.SelectedValue;
            lblTargetRole.Text = selectedRole;

            if (selectedRole.Contains("Backend"))
            {
                lblOverallMatch.Text = "82%";
            }
            else if (selectedRole.Contains("Full Stack"))
            {
                lblOverallMatch.Text = "74%";
            }
            else if (selectedRole.Contains("Data"))
            {
                lblOverallMatch.Text = "61%";
            }
            else
            {
                lblOverallMatch.Text = "68%";
            }

            pnlActionNotice.Visible = true;
            litActionNotice.Text = string.Format("Benchmarking profile against <strong>{0}</strong>. Target competency requirements updated.", HttpUtility.HtmlEncode(selectedRole));
        }

        protected void btnStartPlan_Click(object sender, EventArgs e)
        {
            string actionName = "Recommended Module";
            Button btn = sender as Button;
            LinkButton lbtn = sender as LinkButton;

            if (btn != null)
            {
                actionName = btn.CommandArgument;
            }
            else if (lbtn != null)
            {
                actionName = lbtn.CommandArgument;
            }

            pnlActionNotice.Visible = true;
            litActionNotice.Text = string.Format("<strong>Action Initiated:</strong> Preparing learning module <em>{0}</em> for your custom study plan.", HttpUtility.HtmlEncode(actionName));
        }
    }
}
