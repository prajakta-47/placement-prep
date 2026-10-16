using System;
using System.Web.UI;
using PlacementPrep.Models;

namespace PlacementPrep.Faculty
{
    public partial class Settings : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSettings();
            }
        }

        private void LoadSettings()
        {
            var s = FacultyDataStore.GetSettings();
            txtFullName.Text = s.FullName;
            txtDesignation.Text = s.Designation;
            txtDepartment.Text = s.Department;
            txtEmail.Text = s.Email;
            txtPhone.Text = s.Phone;
            txtOfficeLocation.Text = s.OfficeLocation;

            chkDailyEmail.Checked = s.DailySummaryEmail;
            chkProctorSms.Checked = s.InstantProctorSms;
            chkWeeklyDigest.Checked = s.WeeklyDigest;
            chkRegistrationAlert.Checked = s.StudentRegistrationAlert;

            if (ddlInferenceModel.Items.FindByValue(s.DefaultInferenceModel) != null)
            {
                ddlInferenceModel.SelectedValue = s.DefaultInferenceModel;
            }
            txtCutoff.Text = s.BenchmarkPassingCutoff.ToString();
            chkNegativeMarking.Checked = s.DefaultNegativeMarking;
            chkShuffle.Checked = s.ShuffleQuestions;
            chkTwoFactor.Checked = s.TwoFactorAuth;
        }

        protected void btnSaveAccount_Click(object sender, EventArgs e)
        {
            var s = FacultyDataStore.GetSettings();
            s.FullName = txtFullName.Text.Trim();
            s.Designation = txtDesignation.Text.Trim();
            s.Department = txtDepartment.Text.Trim();
            s.Email = txtEmail.Text.Trim();
            s.Phone = txtPhone.Text.Trim();
            s.OfficeLocation = txtOfficeLocation.Text.Trim();
            FacultyDataStore.SaveSettings(s);

            ShowSuccess("Account preferences updated successfully.");
        }

        protected void btnSaveNotifications_Click(object sender, EventArgs e)
        {
            var s = FacultyDataStore.GetSettings();
            s.DailySummaryEmail = chkDailyEmail.Checked;
            s.InstantProctorSms = chkProctorSms.Checked;
            s.WeeklyDigest = chkWeeklyDigest.Checked;
            s.StudentRegistrationAlert = chkRegistrationAlert.Checked;
            FacultyDataStore.SaveSettings(s);

            ShowSuccess("Notification channels and alert thresholds saved.");
        }

        protected void btnSaveSecurity_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtNewPassword.Text))
            {
                if (txtNewPassword.Text != txtConfirmPassword.Text)
                {
                    pnlSuccess.CssClass = "alert-toast";
                    pnlSuccess.Style["background"] = "#fef2f2";
                    pnlSuccess.Style["color"] = "#b91c1c";
                    pnlSuccess.Style["border-color"] = "#fca5a5";
                    litSuccessMessage.Text = "New password and confirmation password do not match.";
                    pnlSuccess.Visible = true;
                    return;
                }
            }

            var s = FacultyDataStore.GetSettings();
            s.TwoFactorAuth = chkTwoFactor.Checked;
            FacultyDataStore.SaveSettings(s);

            ShowSuccess("Security credentials and authentication policies updated.");
        }

        protected void btnSavePreferences_Click(object sender, EventArgs e)
        {
            var s = FacultyDataStore.GetSettings();
            s.DefaultInferenceModel = ddlInferenceModel.SelectedValue;
            int cutoff;
            if (int.TryParse(txtCutoff.Text, out cutoff))
            {
                s.BenchmarkPassingCutoff = cutoff;
            }
            s.DefaultNegativeMarking = chkNegativeMarking.Checked;
            s.ShuffleQuestions = chkShuffle.Checked;
            FacultyDataStore.SaveSettings(s);

            ShowSuccess("Portal and assessment engine defaults saved.");
        }

        private void ShowSuccess(string msg)
        {
            pnlSuccess.CssClass = "alert-toast";
            pnlSuccess.Style["background"] = "#ecfdf5";
            pnlSuccess.Style["color"] = "#065f46";
            pnlSuccess.Style["border-color"] = "#a7f3d0";
            litSuccessMessage.Text = "✓ " + msg;
            pnlSuccess.Visible = true;
        }
    }
}
