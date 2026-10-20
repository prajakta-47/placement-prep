using System;
using System.Globalization;
using System.Web.UI;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public partial class Settings : Page
    {
        private readonly SettingsRepository _settingsRepo = new SettingsRepository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (txtUniversityName != null)
                {
                    LoadSettings();
                }
            }
        }

        protected void btnSaveSettings_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                ShowMessage("Please correct validation errors before saving.", true);
                return;
            }

            int duration;
            if (!int.TryParse(txtTestDuration.Text.Trim(), out duration) || duration < 10 || duration > 360)
            {
                ShowMessage("Default test duration must be between 10 and 360 minutes.", true);
                return;
            }

            double penalty;
            if (!double.TryParse(txtNegativeMarking.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out penalty) || penalty < 0 || penalty > 1.0)
            {
                ShowMessage("Negative marking penalty factor must be between 0.00 and 1.00.", true);
                return;
            }

            int tabLimit;
            if (!int.TryParse(txtTabSwitchLimit.Text.Trim(), out tabLimit) || tabLimit < 0 || tabLimit > 20)
            {
                ShowMessage("Tab switch limit must be between 0 and 20.", true);
                return;
            }

            int batch;
            if (!int.TryParse(txtTargetBatch.Text.Trim(), out batch) || batch < 2020 || batch > 2035)
            {
                ShowMessage("Target graduation batch must be between 2020 and 2035.", true);
                return;
            }

            double minCgpa;
            if (!double.TryParse(txtDefaultMinCgpa.Text.Trim(), NumberStyles.Any, CultureInfo.InvariantCulture, out minCgpa) || minCgpa < 0 || minCgpa > 10.0)
            {
                ShowMessage("Default CGPA cutoff must be between 0.00 and 10.00.", true);
                return;
            }

            var item = new PlatformSettingsItem
            {
                UniversityName = txtUniversityName.Text.Trim(),
                PlacementCellEmail = txtPlacementEmail.Text.Trim(),
                DirectorName = txtDirectorName.Text.Trim(),
                CampusAddress = txtCampusAddress.Text.Trim(),
                AccreditationStatus = txtAccreditationStatus.Text.Trim(),
                ActivePlacementYear = txtActiveYear.Text.Trim(),
                TargetGraduationBatch = batch,
                DefaultMinCgpaThreshold = minCgpa,
                DefaultTestDurationMinutes = duration,
                NegativeMarkingFactor = penalty,
                TabSwitchLimit = tabLimit,
                WebcamProctoringPreference = ddlWebcamProctoring.SelectedValue,
                FullscreenLockdownEnabled = chkFullscreenLockdown.Checked,
                NotifyDriveAnnouncements = chkNotifyDrives.Checked,
                NotifyCandidateShortlists = chkNotifyShortlists.Checked,
                NotifyInterviewInvites = chkNotifyInvites.Checked,
                NotifyDailyAdminDigest = chkNotifyDigest.Checked
            };

            _settingsRepo.SaveSettings(item);
            ShowMessage("Platform configuration & season governance parameters updated successfully (In-Memory Sample Store).", false);
        }

        protected void btnResetDefaults_Click(object sender, EventArgs e)
        {
            var defaults = new PlatformSettingsItem();
            _settingsRepo.SaveSettings(defaults);
            LoadSettings();
            ShowMessage("Configuration parameters restored to institutional defaults.", false);
        }

        private void LoadSettings()
        {
            var s = _settingsRepo.GetSettings();

            txtUniversityName.Text = s.UniversityName;
            txtPlacementEmail.Text = s.PlacementCellEmail;
            txtDirectorName.Text = s.DirectorName;
            txtCampusAddress.Text = s.CampusAddress;
            txtAccreditationStatus.Text = s.AccreditationStatus;

            txtActiveYear.Text = s.ActivePlacementYear;
            txtTargetBatch.Text = s.TargetGraduationBatch.ToString(CultureInfo.InvariantCulture);
            txtDefaultMinCgpa.Text = s.DefaultMinCgpaThreshold.ToString("0.00", CultureInfo.InvariantCulture);

            txtTestDuration.Text = s.DefaultTestDurationMinutes.ToString(CultureInfo.InvariantCulture);
            txtNegativeMarking.Text = s.NegativeMarkingFactor.ToString("0.00", CultureInfo.InvariantCulture);
            txtTabSwitchLimit.Text = s.TabSwitchLimit.ToString(CultureInfo.InvariantCulture);

            if (ddlWebcamProctoring.Items.FindByValue(s.WebcamProctoringPreference) != null)
                ddlWebcamProctoring.SelectedValue = s.WebcamProctoringPreference;

            chkFullscreenLockdown.Checked = s.FullscreenLockdownEnabled;

            chkNotifyDrives.Checked = s.NotifyDriveAnnouncements;
            chkNotifyShortlists.Checked = s.NotifyCandidateShortlists;
            chkNotifyInvites.Checked = s.NotifyInterviewInvites;
            chkNotifyDigest.Checked = s.NotifyDailyAdminDigest;
        }

        private void ShowMessage(string message, bool isError)
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = isError ? "users-alert users-alert-error" : "users-alert users-alert-success";
            litMessage.Text = message;
        }
    }
}
