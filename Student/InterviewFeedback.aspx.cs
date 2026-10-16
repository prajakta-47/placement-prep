using System;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class InterviewFeedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Can inspect query strings e.g. session id or mode
            }
        }
    }
}
