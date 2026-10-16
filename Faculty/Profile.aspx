<%@ Page Language="C#" AutoEventWireup="true" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("~/Faculty/Settings.aspx", true);
    }
</script>
<!DOCTYPE html>
<html>
<head runat="server"><title>Redirecting...</title></head>
<body><p>Redirecting to <a href="Settings.aspx">Settings</a>...</p></body>
</html>
