using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PlacementPrep
{
    [Serializable]
    public class ResumeUploadItem
    {
        public string FileName { get; set; }
        public string UploadTimeAgo { get; set; }
        public string StatusText { get; set; }
        public bool IsSuccess { get; set; }
    }

    public partial class ResumeAnalyzer : System.Web.UI.Page
    {
        private const int MaxFileSizeBytes = 5 * 1024 * 1024; // 5 MB
        private readonly string[] AllowedExtensions = { ".pdf", ".docx", ".doc" };

        protected void Page_Load(object sender, EventArgs e)
        {
            // Use standard WebForms validation without requiring external script resource mappings
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (Page.Form != null)
            {
                Page.Form.Enctype = "multipart/form-data";
            }

            if (!IsPostBack)
            {
                LoadRecentUploads();
            }
        }

        private void LoadRecentUploads()
        {
            var uploads = Session["RecentUploads"] as List<ResumeUploadItem>;
            if (uploads == null)
            {
                uploads = new List<ResumeUploadItem>
                {
                    new ResumeUploadItem
                    {
                        FileName = "J_Doe_Resume_Tech.pdf",
                        UploadTimeAgo = "Analyzed 2 days ago",
                        StatusText = "Analyzed",
                        IsSuccess = true
                    },
                    new ResumeUploadItem
                    {
                        FileName = "Resume_Draft_v2.doc",
                        UploadTimeAgo = "Low readability score",
                        StatusText = "Low Readability",
                        IsSuccess = false
                    }
                };
                Session["RecentUploads"] = uploads;
            }

            rptRecentUploads.DataSource = uploads;
            rptRecentUploads.DataBind();
            lblStoredCount.Text = string.Format("{0} of 10 stored", uploads.Count);
        }

        protected void cvFileSize_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (fileUploadResume.HasFile)
            {
                args.IsValid = fileUploadResume.PostedFile.ContentLength <= MaxFileSizeBytes;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            pnlAlert.Visible = false;

            if (!fileUploadResume.HasFile)
            {
                ShowAlert("Please select a resume file to upload.", false);
                return;
            }

            string fileExtension = Path.GetExtension(fileUploadResume.FileName).ToLowerInvariant();
            if (!AllowedExtensions.Contains(fileExtension))
            {
                ShowAlert("Invalid file format. Only PDF and DOCX files are supported.", false);
                return;
            }

            if (fileUploadResume.PostedFile.ContentLength > MaxFileSizeBytes)
            {
                ShowAlert("The selected file exceeds the maximum allowed upload size of 5 MB.", false);
                return;
            }

            try
            {
                string uploadFolder = Server.MapPath("~/App_Data/Uploads");
                if (!Directory.Exists(uploadFolder))
                {
                    Directory.CreateDirectory(uploadFolder);
                }

                string originalFileName = Path.GetFileName(fileUploadResume.FileName);
                string uniqueFileName = string.Format("{0:yyyyMMddHHmmss}_{1}", DateTime.Now, originalFileName);
                string savePath = Path.Combine(uploadFolder, uniqueFileName);

                fileUploadResume.SaveAs(savePath);

                var uploads = Session["RecentUploads"] as List<ResumeUploadItem> ?? new List<ResumeUploadItem>();
                uploads.Insert(0, new ResumeUploadItem
                {
                    FileName = originalFileName,
                    UploadTimeAgo = "Uploaded just now",
                    StatusText = "Ready for analysis",
                    IsSuccess = true
                });

                if (uploads.Count > 10)
                {
                    uploads = uploads.Take(10).ToList();
                }
                Session["RecentUploads"] = uploads;

                rptRecentUploads.DataSource = uploads;
                rptRecentUploads.DataBind();
                lblStoredCount.Text = string.Format("{0} of 10 stored", uploads.Count);

                string viewerUrl = ResolveUrl(string.Format("~/Student/ResumeViewer.aspx?file={0}", HttpUtility.UrlEncode(originalFileName)));
                ShowAlert(string.Format("Resume <strong>{0}</strong> uploaded successfully. <a href='{1}' class='stu-alert-link'>Open in Resume Viewer &rarr;</a>", HttpUtility.HtmlEncode(originalFileName), viewerUrl), true);
            }
            catch (Exception ex)
            {
                ShowAlert(string.Format("Upload failed: {0}", HttpUtility.HtmlEncode(ex.Message)), false);
            }
        }

        private void ShowAlert(string htmlMessage, bool isSuccess)
        {
            pnlAlert.Visible = true;
            pnlAlert.CssClass = isSuccess ? "stu-alert success" : "stu-alert error";
            litAlertMessage.Text = htmlMessage;
        }
    }
}
