using System;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class InterviewPrep : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize default state
            }
        }

        protected void ddlTargetRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Target role changed - can update session or viewstate
            Session["TargetInterviewRole"] = ddlTargetRole.SelectedValue;
        }
    }
}
