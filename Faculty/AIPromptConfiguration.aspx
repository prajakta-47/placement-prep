<%@ Page Language="C#" AutoEventWireup="true" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("~/Faculty/AIConfig.aspx", true);
    }
</script>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Redirecting to AI Config...</title>
</head>
<body>
    <p>Redirecting to <a href="AIConfig.aspx">AI Configuration</a>...</p>
</body>
</html>
