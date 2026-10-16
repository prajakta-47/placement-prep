<%@ Page Language="C#" AutoEventWireup="true" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["logout"] == "true")
            {
                Session.Clear();
                pnlAlert.Visible = true;
                pnlAlert.CssClass = "alert-box alert-success";
                litAlert.Text = "✓ You have been logged out successfully. Please sign in to continue.";
            }
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string role = ddlRole.SelectedValue;
        string email = txtEmail.Text.Trim();
        string pass = txtPassword.Text.Trim();

        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(pass))
        {
            pnlAlert.Visible = true;
            pnlAlert.CssClass = "alert-box alert-error";
            litAlert.Text = "Please enter both Email Address and Password.";
            return;
        }

        Session["UserRole"] = role;
        Session["UserEmail"] = email;

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
            padding: 24px 16px;
            box-sizing: border-box;
        }
        .login-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            width: 100%;
            max-width: 440px;
            padding: 32px 36px;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.06), 0 8px 10px -6px rgba(0,0,0,0.04);
            box-sizing: border-box;
        }
        .login-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
        }
        .brand-icon {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            background: #00685e;
            display: grid;
            place-items: center;
            color: #fff;
            flex-shrink: 0;
        }
        .brand-icon svg {
            width: 24px;
            height: 24px;
            stroke: #fff;
            fill: none;
            stroke-width: 1.8;
        }
        .brand-text strong {
            font-size: 16px;
            font-weight: 800;
            color: #0f172a;
            display: block;
        }
        .brand-text small {
            font-size: 11px;
            color: #64748b;
        }
        h2 {
            font-size: 20px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 6px;
            letter-spacing: -0.01em;
        }
        p.subtitle {
            font-size: 12px;
            color: #64748b;
            margin: 0 0 20px;
            line-height: 1.4;
        }
        .form-group {
            margin-bottom: 16px;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }
        label {
            font-size: 12px;
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
            color: #1e293b;
            transition: all 0.15s ease;
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
            padding: 12px 14px;
            border-radius: 8px;
            font-size: 12px;
            margin-bottom: 18px;
            font-weight: 600;
        }
        .alert-success {
            background: #ecfdf5;
            border: 1px solid #a7f3d0;
            color: #065f46;
        }
        .alert-error {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #991b1b;
        }
        /* Demo Credentials Quick-Fill */
        .demo-credentials-box {
            margin-top: 24px;
            padding-top: 18px;
            border-top: 1px solid #f1f5f9;
        }
        .demo-title {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #64748b;
            margin-bottom: 10px;
        }
        .demo-pills {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .demo-pill {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 8px 12px;
            border-radius: 8px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            cursor: pointer;
            transition: all 0.15s ease;
            text-align: left;
        }
        .demo-pill:hover {
            background: #f1f5f9;
            border-color: #00685e;
        }
        .demo-role {
            font-size: 12px;
            font-weight: 700;
            color: #0f172a;
        }
        .demo-email {
            font-size: 11px;
            color: #64748b;
        }
        .demo-tag {
            font-size: 10px;
            font-weight: 600;
            padding: 2px 7px;
            border-radius: 4px;
            background: #e2e8f0;
            color: #475569;
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
                <small>Campus Career Platform (Academic Year 2024-25)</small>
            </div>
        </div>

        <h2>Sign In to Placement Prep</h2>
        <p class="subtitle">Access student assessment tracking, curriculum tuning, and campus recruitment drives.</p>

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
            <asp:TextBox ID="txtPassword" runat="server" CssClass="input-box" TextMode="Password" Text="faculty123" />
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Sign In to Portal" CssClass="btn-submit" OnClick="btnLogin_Click" />

        <!-- Quick-Fill Demo Credentials -->
        <div class="demo-credentials-box">
            <div class="demo-title">⚡ Quick Test Credentials (Click to Fill)</div>
            <div class="demo-pills">
                <div class="demo-pill" onclick="fillCreds('Faculty', 'r.sharma@campus.edu', 'faculty123')">
                    <div>
                        <div class="demo-role">Faculty / Placement Coordinator</div>
                        <div class="demo-email">r.sharma@campus.edu</div>
                    </div>
                    <span class="demo-tag">Faculty Portal</span>
                </div>

                <div class="demo-pill" onclick="fillCreds('Student', 'aarav.sharma@campus.edu', 'student123')">
                    <div>
                        <div class="demo-role">Student (Batch 2025)</div>
                        <div class="demo-email">aarav.sharma@campus.edu</div>
                    </div>
                    <span class="demo-tag">Student Portal</span>
                </div>

                <div class="demo-pill" onclick="fillCreds('Admin', 'admin@campus.edu', 'admin123')">
                    <div>
                        <div class="demo-role">Placement Cell Admin</div>
                        <div class="demo-email">admin@campus.edu</div>
                    </div>
                    <span class="demo-tag">Admin Portal</span>
                </div>
            </div>
        </div>
    </form>

    <script>
        function fillCreds(role, email, pass) {
            document.getElementById('<%= ddlRole.ClientID %>').value = role;
            document.getElementById('<%= txtEmail.ClientID %>').value = email;
            document.getElementById('<%= txtPassword.ClientID %>').value = pass;
        }
    </script>
</body>
</html>
