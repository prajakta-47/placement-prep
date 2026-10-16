using System;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["StudentFullName"] != null)
                {
                    lblProfileName.Text = Session["StudentFullName"].ToString();
                }
                if (Session["StudentAvatarUrl"] != null)
                {
                    imgProfileAvatar.ImageUrl = Session["StudentAvatarUrl"].ToString();
                    imgProfileAvatar.Visible = true;
                    litProfileInitials.Visible = false;
                }
            }
        }
    }
}
