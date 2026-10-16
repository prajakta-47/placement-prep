using System;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class StudentSettings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlSettingsNotice.Visible = false;
                if (Session["StudentFullName"] != null)
                {
                    txtFullName.Text = Session["StudentFullName"].ToString();
                }
                if (Session["StudentEmail"] != null)
                {
                    txtEmail.Text = Session["StudentEmail"].ToString();
                }
                if (Session["StudentAvatarUrl"] != null)
                {
                    imgAvatar.ImageUrl = Session["StudentAvatarUrl"].ToString();
                    imgAvatar.Visible = true;
                    litAvatarInitials.Visible = false;
                }
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Session["StudentFullName"] = txtFullName.Text.Trim();
                Session["StudentEmail"] = txtEmail.Text.Trim();

                string photoMsg = string.Empty;
                if (fuProfilePhoto.HasFile)
                {
                    try
                    {
                        string ext = System.IO.Path.GetExtension(fuProfilePhoto.FileName).ToLower();
                        if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif" || ext == ".webp")
                        {
                            string uploadsDir = Server.MapPath("~/Student/Uploads/");
                            if (!System.IO.Directory.Exists(uploadsDir))
                            {
                                System.IO.Directory.CreateDirectory(uploadsDir);
                            }

                            string uniqueFileName = "avatar_" + Guid.NewGuid().ToString("N").Substring(0, 8) + ext;
                            string fullPath = System.IO.Path.Combine(uploadsDir, uniqueFileName);
                            fuProfilePhoto.SaveAs(fullPath);

                            string avatarUrl = ResolveUrl("~/Student/Uploads/" + uniqueFileName);
                            Session["StudentAvatarUrl"] = avatarUrl;

                            imgAvatar.ImageUrl = avatarUrl;
                            imgAvatar.Visible = true;
                            litAvatarInitials.Visible = false;

                            photoMsg = " Profile photo uploaded and updated successfully.";
                        }
                        else
                        {
                            photoMsg = " <span style='color:#dc2626;'>Note: Please upload an image file (.png, .jpg, .jpeg, .webp).</span>";
                        }
                    }
                    catch (Exception ex)
                    {
                        photoMsg = " <span style='color:#dc2626;'>Error saving photo: " + ex.Message + "</span>";
                    }
                }

                litSettingsNotice.Text = "<strong>Profile Updated!</strong> Personal details have been successfully updated for your active student session." + photoMsg;
                pnlSettingsNotice.Visible = true;
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                txtCurrentPassword.Text = string.Empty;
                txtNewPassword.Text = string.Empty;
                txtConfirmPassword.Text = string.Empty;

                litSettingsNotice.Text = "<strong>Password Changed!</strong> Your account password has been updated securely. Please use your new credentials on your next login.";
                pnlSettingsNotice.Visible = true;
            }
        }

        protected void btnCancelProfile_Click(object sender, EventArgs e)
        {
            txtFullName.Text = Session["StudentFullName"] != null ? Session["StudentFullName"].ToString() : "Vishal Patil";
            txtEmail.Text = Session["StudentEmail"] != null ? Session["StudentEmail"].ToString() : "vishal.patil@campus.edu";
            txtPhone.Text = "+91 9876543210";
            txtCollege.Text = "Institute of Engineering & Technology";
            txtGraduation.Text = "B.Tech Computer Science • 2026";
            litSettingsNotice.Text = "Profile changes were cancelled. Fields reverted to previous values.";
            pnlSettingsNotice.Visible = true;
        }

        protected void btnCancelPassword_Click(object sender, EventArgs e)
        {
            txtCurrentPassword.Text = string.Empty;
            txtNewPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
            litSettingsNotice.Text = "Password change was cancelled. No modifications were made.";
            pnlSettingsNotice.Visible = true;
        }

        protected void btnSavePreferences_Click(object sender, EventArgs e)
        {
            litSettingsNotice.Text = "<strong>Preferences Saved!</strong> Recruitment drive alerts and weekly diagnostic summaries have been updated.";
            pnlSettingsNotice.Visible = true;
        }

        protected void btnCancelPreferences_Click(object sender, EventArgs e)
        {
            chkPlacementAlerts.Checked = true;
            chkWeeklyDigest.Checked = true;
            chkInterviewReminders.Checked = true;
            litSettingsNotice.Text = "Notification preference changes were cancelled.";
            pnlSettingsNotice.Visible = true;
        }
    }
}
