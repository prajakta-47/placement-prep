<%@ Page Language="C#" AutoEventWireup="true" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string role = Session["UserRole"] as string;
        if (!string.IsNullOrEmpty(role))
        {
            Response.Redirect(PlacementPrep.Helpers.AuthHelper.GetDashboardUrl(role), true);
        }
        else
        {
            Response.Redirect("~/Login.aspx", true);
        }
    }
</script>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Placement Prep - Redirecting</title>
</head>
<body>
    <p>Redirecting to <a href="Login.aspx">Login</a>...</p>
</body>
</html>
