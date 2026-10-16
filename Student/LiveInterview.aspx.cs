using System;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class LiveInterview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Can inspect mode parameter if needed
                string mode = Request.QueryString["mode"];
            }
        }
    }
}
