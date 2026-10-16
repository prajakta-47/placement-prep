<%@ Page Language="C#" AutoEventWireup="true" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("~/Faculty/Dashboard.aspx", true);
    }
</script>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Placement Prep - Redirecting</title>
</head>
<body>
    <p>Redirecting to <a href="Faculty/Dashboard.aspx">Faculty Portal</a>...</p>
</body>
</html>
