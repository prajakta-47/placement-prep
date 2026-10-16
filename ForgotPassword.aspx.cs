using System;
using System.Web.UI;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public partial class ForgotPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user arrived via email link containing a token (?token=...)
                string queryToken = Request.QueryString["token"];
                if (!string.IsNullOrWhiteSpace(queryToken))
                {
                    ShowResetStep(queryToken);
                }
                else
                {
                    ShowRequestStep();
                }
            }
        }

        protected void btnSendResetLink_Click(object sender, EventArgs e)
        {
            Page.Validate("RequestGroup");
            if (!Page.IsValid)
            {
                return;
            }

            string email = txtEmail.Text.Trim();
            if (string.IsNullOrWhiteSpace(email))
            {
                ShowAlert("Please enter a valid registered email address.", "alert-error");
                return;
            }

            // Always display a generic response to prevent account enumeration / disclosure
            // Issue token regardless of whether the email is present in the repository,
            // adhering to security best practices.
            var tokenRecord = PasswordResetService.IssueResetToken(email, 30);

            pnlRequestStep.Visible = false;
            pnlTokenNotice.Visible = true;
            litGenericNotice.Text = string.Format(
                "If an account with <strong>{0}</strong> is registered with our placement portal, password reset instructions and a verification token have been dispatched. The reset link is valid for 30 minutes.",
                Server.HtmlEncode(email)
            );

            // Document the backend integration state: SMTP delivery and SQL persistence
            litBackendNote.Text = "<strong>Backend Integration Status:</strong> Live SMTP email delivery and database persistence are currently pending backend integration. For development demonstration and testing, you can proceed directly with the issued verification token below.";

            hfGeneratedToken.Value = tokenRecord.Token;
            lblIssuedToken.Text = tokenRecord.Token;
        }

        protected void btnProceedWithToken_Click(object sender, EventArgs e)
        {
            string token = hfGeneratedToken.Value;
            ShowResetStep(token);
        }

        protected void btnSwitchToToken_Click(object sender, EventArgs e)
        {
            ShowResetStep(string.Empty);
        }

        protected void btnBackToRequest_Click(object sender, EventArgs e)
        {
            ShowRequestStep();
        }

        protected void btnSubmitNewPassword_Click(object sender, EventArgs e)
        {
            Page.Validate("ResetGroup");
            if (!Page.IsValid)
            {
                return;
            }

            string token = txtToken.Text.Trim();
            string newPassword = txtNewPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if (string.IsNullOrWhiteSpace(token))
            {
                ShowAlert("A valid security reset token is required to update your password.", "alert-error");
                return;
            }

            if (!string.Equals(newPassword, confirmPassword, StringComparison.Ordinal))
            {
                ShowAlert("New password and confirmation password do not match.", "alert-error");
                return;
            }

            string complexityError;
            if (!PasswordHelper.MeetsComplexity(newPassword, out complexityError))
            {
                ShowAlert(complexityError, "alert-error");
                return;
            }

            // Execute the secure password reset (validates single-use token, expiry, and hashes password)
            string resetError;
            bool success = PasswordResetService.ExecutePasswordReset(token, newPassword, out resetError);

            if (!success)
            {
                ShowAlert(resetError, "alert-error");
                return;
            }

            // Show success message only after password has actually been verified and reset
            pnlRequestStep.Visible = false;
            pnlTokenNotice.Visible = false;
            pnlResetStep.Visible = false;
            pnlSuccessStep.Visible = true;
            pnlAlert.Visible = false;
        }

        private void ShowRequestStep()
        {
            pnlRequestStep.Visible = true;
            pnlTokenNotice.Visible = false;
            pnlResetStep.Visible = false;
            pnlSuccessStep.Visible = false;
            pnlAlert.Visible = false;
        }

        private void ShowResetStep(string token)
        {
            pnlRequestStep.Visible = false;
            pnlTokenNotice.Visible = false;
            pnlResetStep.Visible = true;
            pnlSuccessStep.Visible = false;
            pnlAlert.Visible = false;

            if (!string.IsNullOrWhiteSpace(token))
            {
                txtToken.Text = token.Trim();
            }
        }

        private void ShowAlert(string message, string cssClass)
        {
            pnlAlert.Visible = true;
            pnlAlert.CssClass = "alert-banner " + cssClass;
            litAlert.Text = message;
        }
    }
}
