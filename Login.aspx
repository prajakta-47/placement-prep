<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="PlacementPrep.Helpers" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (string.Equals(Request.QueryString["logout"], "true", StringComparison.OrdinalIgnoreCase))
            {
                AuthHelper.SignOut(Session);
                pnlAlert.Visible = true;
                pnlAlert.CssClass = "alert-banner alert-success";
                litAlert.Text = "✓ You have been logged out successfully. Please sign in to continue.";
            }
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string pass = txtPassword.Text;

        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(pass))
        {
            pnlAlert.Visible = true;
            pnlAlert.CssClass = "alert-banner alert-error";
            litAlert.Text = "Please enter both Email Address and Password.";
            return;
        }

        string role;
        string displayName;
        if (AuthHelper.ValidateCredentials(email, pass, out role, out displayName))
        {
            AuthHelper.SetAuthSession(Session, email, role, displayName);

            string targetUrl = AuthHelper.GetDashboardUrl(role);
            Response.Redirect(targetUrl, true);
        }
        else
        {
            pnlAlert.Visible = true;
            pnlAlert.CssClass = "alert-banner alert-error";
            litAlert.Text = "Invalid email address or password. Please verify your demo credentials.";
        }
    }
</script>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Placement Prep - Login</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: #ffffff;
            color: #111827;
            min-height: 100vh;
            display: flex;
        }

        .login-layout {
            display: flex;
            width: 100vw;
            min-height: 100vh;
        }

        /* LEFT HERO COLUMN (Docx Page 55 Match) */
        .hero-column {
            flex: 0 0 50%;
            background: #0d766e;
            color: #ffffff;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 60px 70px 50px 70px;
            position: relative;
            overflow: hidden;
        }

        .hero-top {
            max-width: 460px;
        }

        .hero-title {
            font-size: 32px;
            font-weight: 800;
            letter-spacing: -0.02em;
            color: #ffffff;
            margin-bottom: 12px;
            line-height: 1.2;
        }

        .hero-subtitle {
            font-size: 15px;
            line-height: 1.55;
            color: #ccfbf1;
            font-weight: 400;
        }

        .hero-visual {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 30px 0;
        }

        .hero-card-img {
            max-width: 440px;
            width: 100%;
            height: auto;
            border-radius: 18px;
            box-shadow: 0 25px 40px -10px rgba(0, 0, 0, 0.25);
            display: block;
        }

        .hero-bottom-badges {
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            font-weight: 600;
            color: #e6fffa;
        }

        .hero-badge svg {
            width: 18px;
            height: 18px;
            stroke-width: 2.2;
            flex-shrink: 0;
        }

        /* RIGHT FORM COLUMN (Docx Page 55 Match) */
        .form-column {
            flex: 1 1 50%;
            background: #fafbfc;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            padding: 50px 40px 30px 40px;
            overflow-y: auto;
        }

        .form-wrapper {
            width: 100%;
            max-width: 440px;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            box-shadow: 0 4px 16px -2px rgba(15, 23, 42, 0.04);
            padding: 40px 40px 36px 40px;
            margin: auto 0;
        }

        .form-heading {
            font-size: 26px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 6px;
            letter-spacing: -0.015em;
        }

        .form-subheading {
            font-size: 13.5px;
            color: #6b7280;
            margin-bottom: 24px;
        }

        .alert-banner {
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            gap: 8px;
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

        .demo-creds-box {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 14px;
            margin-bottom: 20px;
        }

        .demo-creds-title {
            font-size: 11.5px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            color: #475569;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .demo-creds-tag {
            font-size: 10px;
            font-weight: 600;
            color: #0d766e;
            background: #ccfbf1;
            padding: 2px 6px;
            border-radius: 4px;
        }

        .demo-creds-list {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .demo-cred-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #ffffff;
            border: 1px solid #edf2f7;
            border-radius: 6px;
            padding: 6px 10px;
            font-size: 11.5px;
            transition: all 0.15s ease;
        }

        .demo-cred-item:hover {
            border-color: #0d766e;
            background: #f0fdfa;
        }

        .demo-cred-details {
            display: flex;
            align-items: center;
            gap: 8px;
            overflow: hidden;
        }

        .demo-role-badge {
            font-size: 10.5px;
            font-weight: 700;
            padding: 2px 7px;
            border-radius: 4px;
            flex-shrink: 0;
        }

        .badge-admin { background: #f3e8ff; color: #7e22ce; }
        .badge-faculty { background: #e0f2fe; color: #0369a1; }
        .badge-student { background: #dcfce7; color: #15803d; }

        .demo-cred-text {
            display: flex;
            flex-direction: column;
            line-height: 1.25;
        }

        .demo-cred-text strong {
            font-weight: 600;
            color: #1e293b;
            font-size: 11px;
        }

        .demo-cred-text span {
            font-size: 10.5px;
            color: #64748b;
        }

        .demo-cred-text code {
            font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
            background: #f1f5f9;
            padding: 1px 4px;
            border-radius: 3px;
            color: #0f172a;
            font-size: 10px;
        }

        .demo-autofill-btn {
            background: #f1f5f9;
            border: 1px solid #cbd5e1;
            color: #334155;
            font-size: 11px;
            font-weight: 600;
            padding: 4px 8px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.15s;
            flex-shrink: 0;
        }

        .demo-autofill-btn:hover {
            background: #0d766e;
            border-color: #0d766e;
            color: #ffffff;
        }

        .field-group {
            margin-bottom: 18px;
        }

        .field-label {
            display: block;
            font-size: 12.5px;
            font-weight: 600;
            color: #374151;
            margin-bottom: 7px;
        }

        .field-label-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 7px;
        }

        .forgot-link {
            font-size: 12px;
            font-weight: 600;
            color: #0d766e;
            text-decoration: none;
            transition: color 0.15s;
        }

        .forgot-link:hover {
            color: #0f5c56;
            text-decoration: underline;
        }

        .input-icon-box {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-icon-left {
            position: absolute;
            left: 13px;
            width: 17px;
            height: 17px;
            color: #9ca3af;
            pointer-events: none;
            stroke: currentColor;
            fill: none;
            stroke-width: 1.9;
        }

        .form-text-input {
            width: 100%;
            height: 42px;
            padding: 0 40px 0 40px;
            background: #f9fafb;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 13.5px;
            font-family: inherit;
            color: #111827;
            transition: all 0.15s ease-in-out;
            outline: none;
        }

        .form-text-input:focus {
            background: #ffffff;
            border-color: #0d766e;
            box-shadow: 0 0 0 3px rgba(13, 118, 110, 0.15);
        }

        .toggle-pwd-btn {
            position: absolute;
            right: 12px;
            background: none;
            border: none;
            padding: 0;
            cursor: pointer;
            color: #9ca3af;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: color 0.15s;
        }

        .toggle-pwd-btn:hover {
            color: #4b5563;
        }

        .toggle-pwd-btn svg {
            width: 17px;
            height: 17px;
            stroke: currentColor;
            fill: none;
            stroke-width: 1.9;
        }

        .remember-row {
            display: flex;
            align-items: center;
            gap: 9px;
            margin: 16px 0 20px 0;
        }

        .remember-checkbox {
            width: 16px;
            height: 16px;
            accent-color: #0d766e;
            cursor: pointer;
        }

        .remember-label {
            font-size: 12.5px;
            color: #4b5563;
            cursor: pointer;
            user-select: none;
        }

        .btn-login {
            width: 100%;
            height: 44px;
            background: #0d766e;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 700;
            font-family: inherit;
            cursor: pointer;
            transition: background 0.15s, transform 0.05s;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-login:hover {
            background: #0f5c56;
        }

        .btn-login:active {
            transform: scale(0.99);
        }

        /* DIVIDER */
        .divider-box {
            position: relative;
            text-align: center;
            margin: 24px 0 20px 0;
        }

        .divider-box::before {
            content: "";
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
            background: #e5e7eb;
        }

        .divider-text {
            position: relative;
            background: #ffffff;
            padding: 0 14px;
            font-size: 12px;
            color: #6b7280;
            font-weight: 500;
        }

        /* SOCIAL BUTTONS */
        .social-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 24px;
        }

        .social-btn {
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            background: #ffffff;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            color: #374151;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.15s ease;
        }

        .social-btn:hover {
            background: #f9fafb;
            border-color: #9ca3af;
        }

        .social-btn svg {
            width: 16px;
            height: 16px;
            flex-shrink: 0;
        }

        /* FOOTER REGISTER LINK */
        .register-text {
            text-align: center;
            font-size: 13px;
            color: #4b5563;
        }

        .register-link {
            font-weight: 600;
            color: #0d766e;
            text-decoration: none;
            transition: color 0.15s;
        }

        .register-link:hover {
            color: #0f5c56;
            text-decoration: underline;
        }

        .page-copyright {
            font-size: 12px;
            color: #9ca3af;
            text-align: center;
            margin-top: 20px;
        }

        /* RESPONSIVENESS */
        @media (max-width: 960px) {
            .hero-column {
                display: none;
            }
            .form-column {
                flex: 1 1 100%;
                background: #ffffff;
                padding: 40px 20px;
            }
            .form-wrapper {
                box-shadow: none;
                border: none;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="login-layout">

        <!-- LEFT HERO COLUMN (Matching docx Page 55) -->
        <div class="hero-column">
            <div class="hero-top">
                <h1 class="hero-title">Placement Prep</h1>
                <p class="hero-subtitle">Master the curriculum, refine your skills, and secure your career trajectory.</p>
            </div>

            <div class="hero-visual">
                <img src="Resources/images/login-hero.png" alt="Placement Prep Career Preparation" class="hero-card-img" />
            </div>

            <div class="hero-bottom-badges">
                <div class="hero-badge">
                    <svg viewBox="0 0 24 24" fill="none" stroke="#2dd4bf">
                        <circle cx="12" cy="12" r="10" />
                        <path d="m9 12 2 2 4-4" stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
                    <span>Verified Curriculum</span>
                </div>
                <div class="hero-badge">
                    <svg viewBox="0 0 24 24" fill="none" stroke="#2dd4bf">
                        <path d="M18 20V10" stroke-linecap="round" />
                        <path d="M12 20V4" stroke-linecap="round" />
                        <path d="M6 20v-6" stroke-linecap="round" />
                    </svg>
                    <span>Data-Driven Prep</span>
                </div>
            </div>
        </div>

        <!-- RIGHT FORM COLUMN (Matching docx Page 55) -->
        <div class="form-column">
            <div></div> <!-- Spacing anchor -->

            <div class="form-wrapper">
                <h2 class="form-heading">Welcome Back</h2>
                <p class="form-subheading">Please enter your details to access your dashboard.</p>

                <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert-banner">
                    <asp:Literal ID="litAlert" runat="server" />
                </asp:Panel>

                <!-- Compact Demo Credentials Section -->
                <div class="demo-creds-box">
                    <div class="demo-creds-title">
                        <span>Demo Credentials</span>
                        <span class="demo-creds-tag">1-Click Autofill</span>
                    </div>
                    <div class="demo-creds-list">
                        <div class="demo-cred-item">
                            <div class="demo-cred-details">
                                <span class="demo-role-badge badge-admin">Admin</span>
                                <div class="demo-cred-text">
                                    <strong>admin@placementprep.local</strong>
                                    <span>PW: <code>Admin@123</code></span>
                                </div>
                            </div>
                            <button type="button" class="demo-autofill-btn" onclick="fillCredentials('admin@placementprep.local', 'Admin@123')">Autofill</button>
                        </div>
                        <div class="demo-cred-item">
                            <div class="demo-cred-details">
                                <span class="demo-role-badge badge-faculty">Faculty</span>
                                <div class="demo-cred-text">
                                    <strong>faculty@placementprep.local</strong>
                                    <span>PW: <code>Faculty@123</code></span>
                                </div>
                            </div>
                            <button type="button" class="demo-autofill-btn" onclick="fillCredentials('faculty@placementprep.local', 'Faculty@123')">Autofill</button>
                        </div>
                        <div class="demo-cred-item">
                            <div class="demo-cred-details">
                                <span class="demo-role-badge badge-student">Student</span>
                                <div class="demo-cred-text">
                                    <strong>student@placementprep.local</strong>
                                    <span>PW: <code>Student@123</code></span>
                                </div>
                            </div>
                            <button type="button" class="demo-autofill-btn" onclick="fillCredentials('student@placementprep.local', 'Student@123')">Autofill</button>
                        </div>
                    </div>
                </div>

                <!-- Email Field -->
                <div class="field-group">
                    <label class="field-label" for="<%= txtEmail.ClientID %>">Email Address</label>
                    <div class="input-icon-box">
                        <svg class="input-icon-left" viewBox="0 0 24 24">
                            <rect width="20" height="16" x="2" y="4" rx="2" />
                            <path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7" />
                        </svg>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-text-input" placeholder="candidate@university.edu" TextMode="Email" />
                    </div>
                </div>

                <!-- Password Field with Show/Hide -->
                <div class="field-group">
                    <div class="field-label-row">
                        <label class="field-label" style="margin-bottom:0;" for="<%= txtPassword.ClientID %>">Password</label>
                        <a href="<%= ResolveUrl("~/ForgotPassword.aspx") %>" class="forgot-link">Forgot Password?</a>
                    </div>
                    <div class="input-icon-box">
                        <svg class="input-icon-left" viewBox="0 0 24 24">
                            <rect width="18" height="11" x="3" y="11" rx="2" ry="2" />
                            <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                        </svg>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-text-input" TextMode="Password" placeholder="••••••••" />
                        <button type="button" class="toggle-pwd-btn" id="btnTogglePwd" onclick="togglePasswordVisibility()" aria-label="Toggle password visibility">
                            <svg id="eyeIcon" viewBox="0 0 24 24">
                                <path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z" />
                                <circle cx="12" cy="12" r="3" />
                            </svg>
                        </button>
                    </div>
                </div>

                <!-- Remember Me Checkbox -->
                <div class="remember-row">
                    <input type="checkbox" id="chkRemember" class="remember-checkbox" />
                    <label for="chkRemember" class="remember-label">Remember me for 30 days</label>
                </div>

                <!-- Submit Button -->
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" OnClick="btnLogin_Click" />

                <!-- Social Divider -->
                <div class="divider-box">
                    <span class="divider-text">Or continue with</span>
                </div>

                <!-- Social Buttons -->
                <div class="social-grid">
                    <button type="button" class="social-btn" onclick="alert('Google SSO authentication integration');">
                        <svg viewBox="0 0 24 24">
                            <path fill="#4285F4" d="M23.745 12.27c0-.7-.06-1.4-.19-2.07H12v4.51h6.6c-.29 1.52-1.14 2.8-2.4 3.65v3h3.86c2.26-2.09 3.685-5.17 3.685-9.09z" />
                            <path fill="#34A853" d="M12 24c3.24 0 5.95-1.08 7.93-2.91l-3.86-3c-1.08.72-2.45 1.16-4.07 1.16-3.13 0-5.78-2.11-6.73-4.96H1.29v3.09C3.26 21.3 7.37 24 12 24z" />
                            <path fill="#FBBC05" d="M5.27 14.29c-.25-.72-.38-1.49-.38-2.29s.13-1.57.38-2.29V6.62H1.29C.47 8.24 0 10.06 0 12s.47 3.76 1.29 5.38l3.98-3.09z" />
                            <path fill="#EA4335" d="M12 4.75c1.77 0 3.35.61 4.6 1.8l3.42-3.42C17.95 1.19 15.24 0 12 0 7.37 0 3.26 2.7 1.29 6.62l3.98 3.09c.95-2.85 3.6-4.96 6.73-4.96z" />
                        </svg>
                        <span>Google</span>
                    </button>
                    <button type="button" class="social-btn" onclick="alert('LinkedIn SSO authentication integration');">
                        <svg viewBox="0 0 24 24" fill="#0A66C2">
                            <path d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.28 1.3v-1.11h-2.79v8.37h2.79v-4.93c0-.77.62-1.4 1.39-1.4a1.4 1.4 0 0 1 1.4 1.4v4.93h2.75M6.88 8.56a1.68 1.68 0 0 0 1.68-1.68c0-.93-.75-1.69-1.68-1.69a1.69 1.69 0 0 0-1.69 1.69c0 .93.76 1.68 1.69 1.68m1.39 9.94v-8.37H5.5v8.37h2.77z" />
                        </svg>
                        <span>LinkedIn</span>
                    </button>
                </div>

                <!-- Footer Link -->
                <div class="register-text">
                    Don't have an account? <a href="javascript:void(0);" onclick="alert('Student and Faculty account creation is managed by the University Placement Cell.');" class="register-link">Create an account</a>
                </div>
            </div>

            <!-- Bottom Copyright -->
            <div class="page-copyright">
                &copy; 2024 Placement Prep. All rights reserved.
            </div>
        </div>

    </form>

    <script>
        function togglePasswordVisibility() {
            var input = document.getElementById('<%= txtPassword.ClientID %>');
            var icon = document.getElementById('eyeIcon');
            if (input.type === 'password') {
                input.type = 'text';
                icon.innerHTML = '<path d="m2 2 20 20"/><path d="M9.88 9.88a3 3 0 1 0 4.24 4.24"/><path d="M10.73 5.08A10.43 10.43 0 0 1 12 5c7 0 10 7 10 7a13.16 13.16 0 0 1-1.67 2.68"/><path d="M6.61 6.61A13.526 13.526 0 0 0 2 12s3 7 10 7a9.74 9.74 0 0 0 5.39-1.61"/>';
            } else {
                input.type = 'password';
                icon.innerHTML = '<path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/>';
            }
        }

        function fillCredentials(email, pwd) {
            var emailInput = document.getElementById('<%= txtEmail.ClientID %>');
            var pwdInput = document.getElementById('<%= txtPassword.ClientID %>');
            if (emailInput) {
                emailInput.value = email;
            }
            if (pwdInput) {
                pwdInput.value = pwd;
            }
        }
    </script>
</body>
</html>
