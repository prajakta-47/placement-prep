<%@ Page Language="C#" AutoEventWireup="true" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["logout"] == "true")
        {
            Session.Clear();
            pnlAlert.Visible = true;
            litAlert.Text = "You have been logged out successfully.";
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string role = ddlRole.SelectedValue;
        if (role == "Student")
        {
            Response.Redirect("~/Student/Dashboard.aspx", true);
        }
        else if (role == "Admin")
        {
            Response.Redirect("~/Admin/AdminDashboard.aspx", true);
        }
        else
        {
            Response.Redirect("~/Faculty/Dashboard.aspx", true);
        }
    }
</script>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Placement Prep | Sign In</title>
    <link href="Resources/css/common.css" rel="stylesheet" />
    <style>
        body {
            margin: 0;
            background: #f8fafc;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            box-sizing: border-box;
        }
        .login-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            width: 100%;
            max-width: 420px;
            padding: 32px 36px;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.06), 0 8px 10px -6px rgba(0,0,0,0.04);
        }
        .login-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 24px;
        }
        .brand-icon {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            background: #00685e;
            display: grid;
            place-items: center;
            color: #fff;
        }
        .brand-icon svg {
            width: 22px;
            height: 22px;
            stroke: #fff;
            fill: none;
            stroke-width: 1.8;
        }
        .brand-text strong {
            font-size: 15px;
            font-weight: 800;
            color: #0f172a;
            display: block;
        }
        .brand-text small {
            font-size: 10px;
            color: #64748b;
        }
        h2 {
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 6px;
        }
        p.subtitle {
            font-size: 12px;
            color: #64748b;
            margin: 0 0 20px;
        }
        .form-group {
            margin-bottom: 16px;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }
        label {
            font-size: 11px;
            font-weight: 600;
            color: #334155;
        }
        .input-box {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 12px;
            font-family: inherit;
            box-sizing: border-box;
            background: #f8fafc;
        }
        .input-box:focus {
            outline: none;
            border-color: #00685e;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(0, 104, 94, 0.12);
        }
        .btn-submit {
            width: 100%;
            padding: 11px;
            border-radius: 8px;
            background: #00685e;
            color: #ffffff;
            border: none;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 8px;
            transition: background 0.15s;
        }
        .btn-submit:hover {
            background: #00534b;
        }
        .alert-box {
            background: #ecfdf5;
            border: 1px solid #a7f3d0;
            color: #065f46;
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 11px;
            margin-bottom: 16px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="login-card">
        <div class="login-brand">
            <div class="brand-icon">
                <svg viewBox="0 0 24 24">
                    <path d="M12 2 21 7v10l-9 5-9-5V7z"/>
                    <path d="m6.5 9 5.5-3 5.5 3-5.5 3z"/>
                    <path d="M9 10.5v4l3 1.5 3-1.5v-4"/>
                </svg>
            </div>
            <div class="brand-text">
                <strong>Placement Prep</strong>
                <small>Campus Career Platform</small>
            </div>
        </div>

        <h2>Sign in to your account</h2>
        <p class="subtitle">Access mock tests, curriculum tracks, and campus recruitment drives.</p>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert-box">
            <asp:Literal ID="litAlert" runat="server" />
        </asp:Panel>

        <div class="form-group">
            <label>Select Portal / Role</label>
            <asp:DropDownList ID="ddlRole" runat="server" CssClass="input-box">
                <asp:ListItem Value="Faculty" Text="Faculty &amp; Placement Coordinator" Selected="True" />
                <asp:ListItem Value="Student" Text="Student Portal" />
                <asp:ListItem Value="Admin" Text="Placement Cell Admin" />
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label>Email Address</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="input-box" Text="r.sharma@campus.edu" />
        </div>

        <div class="form-group">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="input-box" TextMode="Password" Text="password123" />
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn-submit" OnClick="btnLogin_Click" />

        <div style="text-align:center; margin-top:18px; font-size:11px; color:#64748b;">
            <span>Default demo credentials pre-filled. Click <strong>Sign In</strong> to proceed.</span>
        </div>
    </form>
</body>
</html>
