using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace PlacementPrep
{
    public partial class StudentMaster : System.Web.UI.MasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            PlacementPrep.Helpers.AuthHelper.CheckAuthorization(Session, Response, "Student");
        }
    }
}
