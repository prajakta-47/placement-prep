<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="PlacementPrep.ForgotPassword" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Placement Prep - Password Recovery</title>
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

        /* LEFT HERO COLUMN */
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

        /* RIGHT FORM COLUMN */
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
            margin-bottom: 22px;
            line-height: 1.5;
        }

        .alert-banner {
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 12.5px;
            font-weight: 600;
            margin-bottom: 18px;
            display: flex;
            align-items: flex-start;
            gap: 8px;
            line-height: 1.4;
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

        .alert-info {
            background: #f0fdfa;
            border: 1px solid #99f6e4;
            color: #0f766e;
        }

        .notice-card {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 14px 16px;
            margin-bottom: 20px;
            font-size: 12.5px;
            color: #334155;
            line-height: 1.5;
        }

        .notice-token-box {
            background: #ffffff;
            border: 1px dashed #cbd5e1;
            border-radius: 6px;
            padding: 8px 10px;
            margin: 10px 0;
            font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
            font-size: 11px;
            color: #0f766e;
            word-break: break-all;
            user-select: all;
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

        .input-icon-box {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-icon-left {
            position: absolute;
            left: 14px;
            width: 18px;
            height: 18px;
            color: #9ca3af;
            stroke-width: 1.8;
            fill: none;
            stroke: currentColor;
            pointer-events: none;
        }

        .form-text-input {
            width: 100%;
            height: 44px;
            padding: 0 42px 0 42px;
            font-size: 14px;
            font-family: inherit;
            color: #111827;
            background: #ffffff;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            outline: none;
            transition: all 0.15s ease;
        }

        .form-text-input:focus {
            border-color: #0d766e;
            box-shadow: 0 0 0 3px rgba(13, 118, 110, 0.15);
        }

        .toggle-pwd-btn {
            position: absolute;
            right: 12px;
            background: none;
            border: none;
            padding: 4px;
            color: #9ca3af;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
        }

        .toggle-pwd-btn:hover {
            color: #4b5563;
        }

        .toggle-pwd-btn svg {
            width: 18px;
            height: 18px;
            stroke-width: 2;
            fill: none;
            stroke: currentColor;
        }

        .val-error {
            display: block;
            color: #dc2626;
            font-size: 11.5px;
            font-weight: 500;
            margin-top: 5px;
        }

        .password-hints {
            font-size: 11px;
            color: #64748b;
            margin-top: 5px;
            line-height: 1.35;
        }

        .btn-login {
            width: 100%;
            height: 44px;
            background: #0d766e;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.15s ease, box-shadow 0.15s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-top: 6px;
        }

        .btn-login:hover {
            background: #0f5c56;
            box-shadow: 0 4px 12px rgba(13, 118, 110, 0.25);
        }

        .btn-secondary {
            background: #f1f5f9;
            color: #334155;
            border: 1px solid #cbd5e1;
        }

        .btn-secondary:hover {
            background: #e2e8f0;
            color: #0f172a;
            box-shadow: none;
        }

        .switch-step-link {
            display: block;
            text-align: center;
            font-size: 12px;
            color: #0d766e;
            font-weight: 600;
            margin-top: 14px;
            cursor: pointer;
            background: none;
            border: none;
            text-decoration: underline;
        }

        .switch-step-link:hover {
            color: #0f5c56;
        }

        .back-login-row {
            text-align: center;
            margin-top: 24px;
            padding-top: 20px;
            border-top: 1px solid #f1f5f9;
            font-size: 13px;
            color: #6b7280;
        }

        .back-login-row a {
            color: #0d766e;
            font-weight: 700;
            text-decoration: none;
        }

        .back-login-row a:hover {
            text-decoration: underline;
        }

        .success-box {
            text-align: center;
            padding: 10px 0;
        }

        .success-icon-circle {
            width: 56px;
            height: 56px;
            background: #dcfce7;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px auto;
            color: #16a34a;
        }

        .success-icon-circle svg {
            width: 28px;
            height: 28px;
            stroke-width: 2.4;
            fill: none;
            stroke: currentColor;
        }

        .page-copyright {
            font-size: 12px;
            color: #9ca3af;
            text-align: center;
            margin-top: 30px;
        }

        @media (max-width: 992px) {
            .hero-column { display: none; }
            .form-column { flex: 0 0 100%; padding: 40px 20px; }
            .form-wrapper { box-shadow: none; border: none; padding: 0; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="login-layout">

        <!-- LEFT HERO COLUMN -->
        <div class="hero-column">
            <div class="hero-top">
                <div style="display:flex; align-items:center; gap:10px; margin-bottom:28px;">
                    <span style="display:inline-flex; align-items:center; justify-content:center; width:36px; height:36px; background:#115e59; border-radius:8px;">
                        <svg viewBox="0 0 24 24" fill="none" stroke="#2dd4bf" stroke-width="2" style="width:20px; height:20px;">
                            <path d="M12 2 21 7v10l-9 5-9-5V7z" />
                            <path d="m6.5 9 5.5-3 5.5 3-5.5 3z" />
                            <path d="M9 10.5v4l3 1.5 3-1.5v-4" />
                        </svg>
                    </span>
                    <strong style="font-size:18px; letter-spacing:-0.01em;">Placement Prep</strong>
                </div>
                <h1 class="hero-title">Secure Password Recovery</h1>
                <p class="hero-subtitle">
                    Regain access to your institutional placement preparation portal, mock tests, verified curricula, and analytics.
                </p>
            </div>

            <div class="hero-visual">
                <img src="Resources/images/login-hero.png" alt="Placement Prep Career Preparation" class="hero-card-img" />
            </div>

            <div class="hero-bottom-badges">
                <div class="hero-badge">
                    <svg viewBox="0 0 24 24" fill="none" stroke="#2dd4bf">
                        <rect width="18" height="11" x="3" y="11" rx="2" ry="2" />
                        <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                    </svg>
                    <span>Encrypted Reset Tokens</span>
                </div>
                <div class="hero-badge">
                    <svg viewBox="0 0 24 24" fill="none" stroke="#2dd4bf">
                        <circle cx="12" cy="12" r="10" />
                        <path d="m9 12 2 2 4-4" stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
                    <span>Account Security First</span>
                </div>
            </div>
        </div>

        <!-- RIGHT FORM COLUMN -->
        <div class="form-column">
            <div></div> <!-- Spacer -->

            <div class="form-wrapper">

                <!-- Alert Banner -->
                <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert-banner">
                    <asp:Literal ID="litAlert" runat="server" />
                </asp:Panel>

                <!-- STEP 1: Request Password Reset -->
                <asp:Panel ID="pnlRequestStep" runat="server">
                    <h2 class="form-heading">Forgot Password</h2>
                    <p class="form-subheading">Enter your registered email address and we'll dispatch single-use recovery instructions.</p>

                    <div class="field-group">
                        <label class="field-label" for="<%= txtEmail.ClientID %>">Registered University Email</label>
                        <div class="input-icon-box">
                            <svg class="input-icon-left" viewBox="0 0 24 24">
                                <rect width="20" height="16" x="2" y="4" rx="2" />
                                <path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7" />
                            </svg>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-text-input" placeholder="student@placementprep.local" TextMode="Email" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationGroup="RequestGroup" Display="Dynamic" CssClass="val-error"
                            ErrorMessage="Registered email address is required." />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationGroup="RequestGroup" Display="Dynamic" CssClass="val-error"
                            ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                            ErrorMessage="Please enter a valid email address format (e.g. name@domain.com)." />
                    </div>

                    <asp:Button ID="btnSendResetLink" runat="server" Text="Send Reset Instructions" CssClass="btn-login"
                        ValidationGroup="RequestGroup" OnClick="btnSendResetLink_Click" />

                    <asp:LinkButton ID="btnSwitchToToken" runat="server" CssClass="switch-step-link" CausesValidation="false"
                        OnClick="btnSwitchToToken_Click">Already have a verification token? Enter it here &rarr;</asp:LinkButton>
                </asp:Panel>

                <!-- STEP 1 CONFIRMATION: Token Issued / Generic Notice -->
                <asp:Panel ID="pnlTokenNotice" runat="server" Visible="false">
                    <h2 class="form-heading">Instructions Dispatched</h2>
                    <p class="form-subheading">Request processed securely.</p>

                    <div class="notice-card">
                        <asp:Literal ID="litGenericNotice" runat="server" />
                    </div>

                    <div class="notice-card" style="background:#f0fdfa; border-color:#99f6e4; color:#0f766e;">
                        <asp:Literal ID="litBackendNote" runat="server" />
                        <div class="notice-token-box">
                            Token: <asp:Label ID="lblIssuedToken" runat="server" />
                        </div>
                        <asp:HiddenField ID="hfGeneratedToken" runat="server" />
                    </div>

                    <asp:Button ID="btnProceedWithToken" runat="server" Text="Proceed to Reset Password &rarr;" CssClass="btn-login"
                        OnClick="btnProceedWithToken_Click" />
                </asp:Panel>

                <!-- STEP 2: Enter Token and New Password -->
                <asp:Panel ID="pnlResetStep" runat="server" Visible="false">
                    <h2 class="form-heading">Set New Password</h2>
                    <p class="form-subheading">Provide your verification token and choose a strong new password.</p>

                    <!-- Token Input -->
                    <div class="field-group">
                        <label class="field-label" for="<%= txtToken.ClientID %>">Verification Token</label>
                        <div class="input-icon-box">
                            <svg class="input-icon-left" viewBox="0 0 24 24">
                                <circle cx="12" cy="12" r="10" />
                                <path d="m4.93 4.93 4.24 4.24" />
                                <path d="m14.83 14.83 4.24 4.24" />
                                <circle cx="12" cy="12" r="4" />
                            </svg>
                            <asp:TextBox ID="txtToken" runat="server" CssClass="form-text-input" placeholder="Paste single-use security token" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvToken" runat="server" ControlToValidate="txtToken"
                            ValidationGroup="ResetGroup" Display="Dynamic" CssClass="val-error"
                            ErrorMessage="Security reset token is required." />
                    </div>

                    <!-- New Password Input -->
                    <div class="field-group">
                        <label class="field-label" for="<%= txtNewPassword.ClientID %>">New Password</label>
                        <div class="input-icon-box">
                            <svg class="input-icon-left" viewBox="0 0 24 24">
                                <rect width="18" height="11" x="3" y="11" rx="2" ry="2" />
                                <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                            </svg>
                            <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-text-input" TextMode="Password" placeholder="Minimum 8 characters" />
                            <button type="button" class="toggle-pwd-btn" onclick="togglePasswordVisibility('<%= txtNewPassword.ClientID %>', 'eyeIcon1')" aria-label="Toggle password visibility">
                                <svg id="eyeIcon1" viewBox="0 0 24 24">
                                    <path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z" />
                                    <circle cx="12" cy="12" r="3" />
                                </svg>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword"
                            ValidationGroup="ResetGroup" Display="Dynamic" CssClass="val-error"
                            ErrorMessage="New password is required." />
                        <asp:RegularExpressionValidator ID="revNewPassword" runat="server" ControlToValidate="txtNewPassword"
                            ValidationGroup="ResetGroup" Display="Dynamic" CssClass="val-error"
                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z\d]).{8,}$"
                            ErrorMessage="Password must be at least 8 characters and include uppercase, lowercase, number, and special character." />
                        <div class="password-hints">
                            Must be at least 8 characters with uppercase, lowercase, digit, and symbol.
                        </div>
                    </div>

                    <!-- Confirm Password Input -->
                    <div class="field-group">
                        <label class="field-label" for="<%= txtConfirmPassword.ClientID %>">Confirm New Password</label>
                        <div class="input-icon-box">
                            <svg class="input-icon-left" viewBox="0 0 24 24">
                                <rect width="18" height="11" x="3" y="11" rx="2" ry="2" />
                                <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                            </svg>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-text-input" TextMode="Password" placeholder="Confirm your new password" />
                            <button type="button" class="toggle-pwd-btn" onclick="togglePasswordVisibility('<%= txtConfirmPassword.ClientID %>', 'eyeIcon2')" aria-label="Toggle password visibility">
                                <svg id="eyeIcon2" viewBox="0 0 24 24">
                                    <path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z" />
                                    <circle cx="12" cy="12" r="3" />
                                </svg>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                            ValidationGroup="ResetGroup" Display="Dynamic" CssClass="val-error"
                            ErrorMessage="Please confirm your new password." />
                        <asp:CompareValidator ID="cvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtNewPassword" Operator="Equal" Type="String"
                            ValidationGroup="ResetGroup" Display="Dynamic" CssClass="val-error"
                            ErrorMessage="Passwords do not match." />
                    </div>

                    <asp:Button ID="btnSubmitNewPassword" runat="server" Text="Update Password" CssClass="btn-login"
                        ValidationGroup="ResetGroup" OnClick="btnSubmitNewPassword_Click" />

                    <asp:LinkButton ID="btnBackToRequest" runat="server" CssClass="switch-step-link" CausesValidation="false"
                        OnClick="btnBackToRequest_Click">&larr; Request a different reset link</asp:LinkButton>
                </asp:Panel>

                <!-- STEP 3: Success Confirmation -->
                <asp:Panel ID="pnlSuccessStep" runat="server" Visible="false">
                    <div class="success-box">
                        <div class="success-icon-circle">
                            <svg viewBox="0 0 24 24">
                                <path d="M20 6 9 17l-5-5" stroke-linecap="round" stroke-linejoin="round" />
                            </svg>
                        </div>
                        <h2 class="form-heading" style="text-align:center;">Password Updated!</h2>
                        <p class="form-subheading" style="text-align:center; margin-bottom:16px;">
                            Your account password has been securely hashed and updated. You can now access your dashboard using your new credentials.
                        </p>
                        <a href="<%= ResolveUrl("~/Login.aspx") %>" class="btn-login" style="text-decoration:none;">Proceed to Login</a>
                    </div>
                </asp:Panel>

                <!-- Return to Login Footer -->
                <div class="back-login-row">
                    Remember your password? <a href="<%= ResolveUrl("~/Login.aspx") %>">Back to Sign In</a>
                </div>

            </div>

            <!-- Bottom Copyright -->
            <div class="page-copyright">
                &copy; 2024 Placement Prep. All rights reserved.
            </div>
        </div>

    </form>

    <script type="text/javascript">
        function togglePasswordVisibility(inputId, iconId) {
            var input = document.getElementById(inputId);
            var icon = document.getElementById(iconId);
            if (!input || !icon) return;

            if (input.type === 'password') {
                input.type = 'text';
                icon.innerHTML = '<path d="m2 2 20 20"/><path d="M9.88 9.88a3 3 0 1 0 4.24 4.24"/><path d="M10.73 5.08A10.43 10.43 0 0 1 12 5c7 0 10 7 10 7a13.16 13.16 0 0 1-1.67 2.68"/><path d="M6.61 6.61A13.526 13.526 0 0 0 2 12s3 7 10 7a9.74 9.74 0 0 0 5.39-1.61"/>';
            } else {
                input.type = 'password';
                icon.innerHTML = '<path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/>';
            }
        }
    </script>
</body>
</html>
