using System;
using System.Text;
using System.Web;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class ResumeViewer : System.Web.UI.Page
    {
        private string _currentFileName = "jdoe_resume_v4_final.pdf";
        public string CurrentFileName
        {
            get { return _currentFileName; }
            set { _currentFileName = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string fileParam = Request.QueryString["file"];
                if (!string.IsNullOrWhiteSpace(fileParam))
                {
                    CurrentFileName = PathSanitize(fileParam);
                }

                lblFileName.Text = CurrentFileName;
                lnkGapAnalysis.NavigateUrl = string.Format("~/Student/SkillGapAnalysis.aspx?file={0}", HttpUtility.UrlEncode(CurrentFileName));
                lnkFinalReport.NavigateUrl = string.Format("~/Student/AIResumeAnalysis.aspx?file={0}", HttpUtility.UrlEncode(CurrentFileName));
            }
        }

        private string PathSanitize(string input)
        {
            return System.IO.Path.GetFileName(input);
        }

        protected void btnExportJson_Click(object sender, EventArgs e)
        {
            string fileName = !string.IsNullOrEmpty(lblFileName.Text) ? lblFileName.Text : "resume_extracted.json";
            string exportFileName = System.IO.Path.GetFileNameWithoutExtension(fileName) + "_extracted.json";

            string jsonContent = string.Format(@"{{
  ""documentName"": ""{0}"",
  ""parsedTimestamp"": ""{1}"",
  ""candidate"": {{
    ""name"": ""Alexander Chen"",
    ""email"": ""alex.chen@alum.mit.edu"",
    ""phone"": ""(415) 555-0192"",
    ""experienceYears"": 6,
    ""atsScore"": 98
  }},
  ""education"": [
    {{
      ""degree"": ""Master of Science in Computer Science"",
      ""institution"": ""Stanford University"",
      ""graduationYear"": 2021
    }},
    {{
      ""degree"": ""Bachelor of Science in Software Engineering"",
      ""institution"": ""University of California, Berkeley"",
      ""graduationYear"": 2019
    }}
  ],
  ""experience"": [
    {{
      ""role"": ""Senior Backend Engineer"",
      ""company"": ""TechFlow Systems Inc."",
      ""period"": ""2021 - Present""
    }},
    {{
      ""role"": ""Software Engineer II"",
      ""company"": ""DataSphere Analytics"",
      ""period"": ""2019 - 2021""
    }}
  ],
  ""skills"": [
    ""Python"", ""Kubernetes"", ""React.js"", ""TypeScript"", ""PostgreSQL"", ""AWS"", ""Docker"", ""Go / Golang""
  ]
}}", fileName, DateTime.UtcNow.ToString("o"));

            Response.Clear();
            Response.ContentType = "application/json";
            Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", exportFileName));
            Response.ContentEncoding = Encoding.UTF8;
            Response.Write(jsonContent);
            Response.End();
        }
    }
}
