using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using PlacementPrep.Helpers;

namespace PlacementPrep
{
    public class StudentCounselingNote
    {
        public string Author { get; set; }
        public string Timestamp { get; set; }
        public string NoteText { get; set; }
    }

    public partial class StudentDetails : Page
    {
        private readonly StudentRepository _studentRepo = new StudentRepository();

        // In-memory counseling notes repository keyed by student ID
        private static readonly Dictionary<int, List<StudentCounselingNote>> CounselingStore =
            new Dictionary<int, List<StudentCounselingNote>>();

        private static readonly object StoreLock = new object();

        static StudentDetails()
        {
            SeedInitialNotes();
        }

        private static void SeedInitialNotes()
        {
            lock (StoreLock)
            {
                CounselingStore[1] = new List<StudentCounselingNote>
                {
                    new StudentCounselingNote
                    {
                        Author = "Dr. S. K. Verma (Faculty Mentor)",
                        Timestamp = "14 Oct 2026, 11:30 AM",
                        NoteText = "Candidate cleared internal mock interview round 2 with strong performance in DSA and graph traversals. Recommended for Tier 1 Super Dream drives."
                    },
                    new StudentCounselingNote
                    {
                        Author = "Prof. Anita Sharma (TPO Coordinator)",
                        Timestamp = "10 Oct 2026, 04:15 PM",
                        NoteText = "Resume ATS score validated at 91%. Advised candidate to add live deployed links to microservices portfolio project."
                    }
                };

                CounselingStore[2] = new List<StudentCounselingNote>
                {
                    new StudentCounselingNote
                    {
                        Author = "Prof. R. C. Patel (TPO Officer)",
                        Timestamp = "12 Oct 2026, 02:00 PM",
                        NoteText = "Offered package of 42.0 LPA at Microsoft Core Services. Student submitted signed acceptance confirmation letter."
                    }
                };
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int studentId = ResolveStudentId();
                LoadStudent(studentId);
            }
        }

        private int ResolveStudentId()
        {
            int studentId;
            if (int.TryParse(Request.QueryString["id"], out studentId) && studentId > 0)
            {
                return studentId;
            }

            // Fallback to first available student
            var all = _studentRepo.GetAllStudents();
            return all.Count > 0 ? all[0].StudentId : 1;
        }

        private void LoadStudent(int studentId)
        {
            var student = _studentRepo.GetById(studentId);
            if (student == null)
            {
                Response.Redirect("~/Admin/ManageStudents.aspx", true);
                return;
            }

            // Browser & Breadcrumb
            litBrowserTitle.Text = Server.HtmlEncode(student.FullName) + " - Placement Dossier | Placement Prep Admin";
            litBreadcrumbStudent.Text = Server.HtmlEncode(student.FullName);

            // Hero Details
            litHeroName.Text = Server.HtmlEncode(student.FullName);
            litHeroInitials.Text = Server.HtmlEncode(student.Initials);
            pnlStudentAvatar.Attributes["class"] = "details-hero-logo " + (string.IsNullOrEmpty(student.AvatarClass) ? "users-avatar avatar-purple" : student.AvatarClass);

            litHeroEnrollment.Text = Server.HtmlEncode(student.EnrollmentId);
            litHeroDept.Text = Server.HtmlEncode(student.Department);
            litHeroBatch.Text = student.GraduationYear.ToString(CultureInfo.InvariantCulture);

            litHeroElig.Text = Server.HtmlEncode(student.PlacementEligibility);
            badgeHeroElig.Attributes["class"] = student.EligibilityClass;

            litHeroStatus.Text = Server.HtmlEncode(student.PlacementStatus);
            badgeHeroStatus.Attributes["class"] = student.PlacementStatusClass;

            // Telemetry Metric Cards
            litCgpa.Text = student.CgpaDisplay;
            litCgpaStanding.Text = student.Cgpa >= 8.5
                ? "Standing: Top 5% Academic Cohort"
                : (student.Cgpa >= 7.5 ? "Standing: Benchmark Cleared (First Class)" : "Standing: Meets Standard Cutoff");

            litPriScore.Text = student.ReadinessScore.ToString(CultureInfo.InvariantCulture);
            litAtsScore.Text = student.AtsScore.ToString(CultureInfo.InvariantCulture);
            litAssessments.Text = student.AssessmentsCompleted.ToString(CultureInfo.InvariantCulture);

            // Left Column: Academic Credentials
            litEmail.Text = Server.HtmlEncode(student.Email);
            litDeptFull.Text = Server.HtmlEncode(student.Department) + " (Graduating " + student.GraduationYear + ")";
            litStatusDesc.Text = student.PlacementStatus == "Placed"
                ? "Offer Extended & Verified"
                : (student.PlacementStatus == "In Process" ? "Active in Recruitment Pipeline" : "Eligible for Open Drives");

            if (!string.IsNullOrEmpty(student.CompanyPlaced) && student.PackageLpa.HasValue)
            {
                litOfferPackage.Text = "<strong style='color: #059669;'>" + Server.HtmlEncode(student.CompanyPlaced) + " - " +
                                      student.PackageLpa.Value.ToString("0.0", CultureInfo.InvariantCulture) + " LPA</strong>";
            }
            else
            {
                litOfferPackage.Text = "None (Seeking Placement)";
            }

            // Pipeline Applications
            if (student.Applications != null && student.Applications.Count > 0)
            {
                rptApplications.DataSource = student.Applications;
                rptApplications.DataBind();
                rptApplications.Visible = true;
                pnlNoApps.Visible = false;
            }
            else
            {
                rptApplications.Visible = false;
                pnlNoApps.Visible = true;
            }

            // Technical Skills & Repositories
            if (!string.IsNullOrWhiteSpace(student.TechnicalSkills))
            {
                var chips = student.TechnicalSkills
                    .Split(new[] { ',', ';' }, StringSplitOptions.RemoveEmptyEntries)
                    .Select(s => "<span class='dossier-skill-tag'>" + Server.HtmlEncode(s.Trim()) + "</span>");
                litSkillTags.Text = string.Join(" ", chips);
            }
            else
            {
                litSkillTags.Text = "<span class='users-hint'>No verified technical skill tags recorded yet.</span>";
            }

            litGithub.Text = string.IsNullOrEmpty(student.GithubProfile)
                ? "Not provided"
                : "<a href='" + Server.HtmlEncode(student.GithubProfile) + "' target='_blank' class='table-link'>" + Server.HtmlEncode(student.GithubProfile) + " &rarr;</a>";

            litLinkedin.Text = string.IsNullOrEmpty(student.LinkedinProfile)
                ? "Not provided"
                : "<a href='" + Server.HtmlEncode(student.LinkedinProfile) + "' target='_blank' class='table-link'>" + Server.HtmlEncode(student.LinkedinProfile) + " &rarr;</a>";

            // Benchmark Performance Progress Bars
            int apt = Math.Min(100, Math.Max(40, student.ReadinessScore + 3));
            int tech = Math.Min(100, Math.Max(40, student.ReadinessScore - 2));
            int code = Math.Min(100, Math.Max(35, student.ReadinessScore - 5));

            litAptitudeScore.Text = apt + "%";
            barAptitude.Attributes["style"] = "width: " + apt + "%; background: #0d9488;";

            litTechScore.Text = tech + "%";
            barTech.Attributes["style"] = "width: " + tech + "%; background: #2563eb;";

            litCodingScore.Text = code + "%";
            barCoding.Attributes["style"] = "width: " + code + "%; background: #7c3aed;";

            litMockCount.Text = (student.InterviewCount > 0 ? student.InterviewCount : 3) + " Proctored Sessions";

            // Bind Counseling Notes
            BindCounselingNotes(studentId);
        }

        private void BindCounselingNotes(int studentId)
        {
            lock (StoreLock)
            {
                List<StudentCounselingNote> notes;
                if (CounselingStore.TryGetValue(studentId, out notes) && notes.Count > 0)
                {
                    rptCounselingNotes.DataSource = notes;
                    rptCounselingNotes.DataBind();
                    rptCounselingNotes.Visible = true;
                    pnlNoNotes.Visible = false;
                }
                else
                {
                    rptCounselingNotes.Visible = false;
                    pnlNoNotes.Visible = true;
                }
            }
        }

        protected void btnToggleAudit_Click(object sender, EventArgs e)
        {
            int studentId = ResolveStudentId();
            _studentRepo.ToggleEligibility(studentId);

            pnlNotice.Visible = true;
            litNoticeMsg.Text = "Student eligibility status updated successfully in memory.";
            LoadStudent(studentId);
        }

        protected void btnAddCounselingNote_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            int studentId = ResolveStudentId();
            string noteText = (txtCounselingNote.Text ?? string.Empty).Trim();
            if (string.IsNullOrEmpty(noteText))
            {
                return;
            }

            lock (StoreLock)
            {
                if (!CounselingStore.ContainsKey(studentId))
                {
                    CounselingStore[studentId] = new List<StudentCounselingNote>();
                }

                CounselingStore[studentId].Insert(0, new StudentCounselingNote
                {
                    Author = "Admin / TPO Officer",
                    Timestamp = DateTime.Now.ToString("dd MMM yyyy, hh:mm tt", CultureInfo.InvariantCulture),
                    NoteText = noteText
                });
            }

            txtCounselingNote.Text = string.Empty;
            pnlNotice.Visible = true;
            litNoticeMsg.Text = "Counseling observation note logged successfully.";
            BindCounselingNotes(studentId);
        }
    }
}
