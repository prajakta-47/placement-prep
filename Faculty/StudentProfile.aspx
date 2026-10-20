<%@ Page Title="Student Profile & Performance" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="StudentProfile.aspx.cs" Inherits="PlacementPrep.Faculty.StudentProfile" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .profile-hero {
            background: #ffffff;
            border: 1px solid var(--fac-border);
            border-radius: 12px;
            padding: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
            box-shadow: 0 1px 3px rgba(0,0,0,0.03);
            margin-bottom: 20px;
        }

        .profile-hero-left {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .profile-avatar-circle {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--fac-teal), #0284c7);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: 800;
            box-shadow: 0 4px 10px rgba(0, 104, 94, 0.2);
            flex-shrink: 0;
        }

        .profile-meta h1 {
            font-size: 22px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 4px;
            letter-spacing: -0.02em;
        }

        .profile-meta-sub {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 11.5px;
            color: #64748b;
            flex-wrap: wrap;
        }

        .profile-kpi-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 14px;
            margin-bottom: 20px;
        }

        .profile-kpi-card {
            background: #ffffff;
            border: 1px solid var(--fac-border);
            border-radius: 10px;
            padding: 16px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.03);
        }

        .profile-kpi-lbl {
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            color: #64748b;
            margin-bottom: 6px;
        }

        .profile-kpi-val {
            font-size: 24px;
            font-weight: 800;
            color: #0f172a;
            line-height: 1.1;
        }

        .profile-kpi-trend {
            font-size: 11px;
            font-weight: 600;
            margin-top: 6px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .trend-up { color: #059669; }
        .trend-neutral { color: #0284c7; }

        .details-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 18px;
        }

        @media (max-width: 960px) {
            .details-grid {
                grid-template-columns: 1fr;
            }
        }

        .section-card {
            background: #ffffff;
            border: 1px solid var(--fac-border);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 18px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.03);
        }

        .section-title {
            font-size: 14px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 14px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #f1f5f9;
            padding-bottom: 10px;
        }

        .domain-progress-row {
            margin-bottom: 14px;
        }

        .domain-progress-row:last-child {
            margin-bottom: 0;
        }

        .domain-info {
            display: flex;
            justify-content: space-between;
            font-size: 11.5px;
            font-weight: 600;
            margin-bottom: 5px;
            color: #334155;
        }

        .domain-bar-bg {
            height: 8px;
            background: #e2e8f0;
            border-radius: 4px;
            overflow: hidden;
        }

        .domain-bar-fill {
            height: 100%;
            border-radius: 4px;
            background: linear-gradient(90deg, var(--fac-teal), #0d9488);
        }

        .badge-fit {
            background: #e6f9f5;
            color: #00685e;
            padding: 3px 10px;
            border-radius: 6px;
            font-weight: 700;
            font-size: 11px;
        }

        .badge-track {
            background: #e4edff;
            color: #2b4c7e;
            padding: 3px 10px;
            border-radius: 6px;
            font-weight: 700;
            font-size: 11px;
        }

        .badge-review {
            background: #fef2f2;
            color: #b91c1c;
            padding: 3px 10px;
            border-radius: 6px;
            font-weight: 700;
            font-size: 11px;
        }

        .doc-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 12px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            margin-bottom: 8px;
            font-size: 11.5px;
        }

        .doc-item:last-child {
            margin-bottom: 0;
        }

        .skill-chip {
            display: inline-block;
            background: #f1f5f9;
            color: #1e293b;
            font-size: 11px;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 20px;
            margin: 0 4px 6px 0;
            border: 1px solid #e2e8f0;
        }
    </style>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:16px;">

    <!-- Breadcrumb & Top Actions -->
    <div class="profile-page-header">
        <div>
            <div style="font-size:11px; color:#64748b; margin-bottom:4px;">
                <a href="Dashboard.aspx" style="color:var(--fac-teal); text-decoration:none;">Dashboard</a>
                <span> &bull; </span>
                <a href="Students.aspx" style="color:var(--fac-teal); text-decoration:none;">Students</a>
                <span> &bull; </span>
                <span>Candidate Profile</span>
            </div>
            <h1 style="font-size:22px; font-weight:800; color:#0f172a; margin:0;">Student Placement Dossier</h1>
        </div>
        <div style="display:flex; gap:8px;">
            <a href="Students.aspx" class="faculty-export" style="text-decoration:none;">
                &larr; Back to Cohort
            </a>
            <button type="button" class="faculty-export" onclick="window.print()">
                Export Profile (PDF)
            </button>
        </div>
    </div>

    <!-- Alert / Notice Panel -->
    <asp:Panel ID="pnlAlert" runat="server" Visible="false" style="padding:12px 16px; border-radius:8px; font-size:11.5px; background:#ecfdf5; border:1px solid #a7f3d0; color:#065f46;">
        <asp:Literal ID="litAlert" runat="server" />
    </asp:Panel>

    <!-- Student Hero Profile Card (Page 22) -->
    <div class="profile-hero">
        <div class="profile-hero-left">
            <div class="profile-avatar-circle">
                <asp:Literal ID="litAvatarInitials" runat="server" Text="ST" />
            </div>
            <div class="profile-meta">
                <div style="display:flex; align-items:center; gap:10px;">
                    <h1><asp:Literal ID="litStudentName" runat="server" Text="Student Name" /></h1>
                    <asp:Literal ID="litStatusBadge" runat="server" />
                </div>
                <div class="profile-meta-sub">
                    <span><strong>Roll:</strong> <asp:Literal ID="litRollNo" runat="server" /></span>
                    <span>&bull;</span>
                    <span><strong>Department:</strong> <asp:Literal ID="litDepartment" runat="server" /></span>
                    <span>&bull;</span>
                    <span><strong>Academic Cohort:</strong> <asp:Literal ID="litClassYear" runat="server" /></span>
                    <span>&bull;</span>
                    <span><asp:Literal ID="litEmail" runat="server" /></span>
                </div>
            </div>
        </div>
        <div style="display:flex; gap:10px; align-items:center;">
            <a href='mailto:<%= litEmail.Text %>' style="padding:8px 16px; background:#f1f5f9; border:1px solid #cbd5e1; border-radius:6px; font-size:11px; font-weight:600; color:#334155; text-decoration:none;">
                ✉ Message Student
            </a>
            <button type="button" onclick="document.getElementById('noteModal').style.display='grid'" style="padding:8px 16px; background:var(--fac-teal); color:#fff; border:none; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer;">
                ＋ Add Faculty Note
            </button>
        </div>
    </div>

    <!-- Key Performance Indicators Metric Strip -->
    <div class="profile-kpi-grid">
        <div class="profile-kpi-card">
            <div class="profile-kpi-lbl">Current CGPA</div>
            <div class="profile-kpi-val"><asp:Literal ID="litCgpa" runat="server" Text="0.00" /></div>
            <div class="profile-kpi-trend trend-up">✓ Above 7.0 Placement Cutoff</div>
        </div>
        <div class="profile-kpi-card">
            <div class="profile-kpi-lbl">Placement Readiness</div>
            <div class="profile-kpi-val" style="color:var(--fac-teal);"><asp:Literal ID="litReadiness" runat="server" Text="0" />%</div>
            <div class="profile-kpi-trend trend-up">▲ <asp:Literal ID="litTrend" runat="server" Text="+4%" /> vs Last Mock</div>
        </div>
        <div class="profile-kpi-card">
            <div class="profile-kpi-lbl">Batch Percentile / Rank</div>
            <div class="profile-kpi-val">#<asp:Literal ID="litRank" runat="server" Text="1" /></div>
            <div class="profile-kpi-trend trend-neutral">Top 10% in Department</div>
        </div>
        <div class="profile-kpi-card">
            <div class="profile-kpi-lbl">Coding Problems Solved</div>
            <div class="profile-kpi-val"><asp:Literal ID="litSolved" runat="server" Text="0" /></div>
            <div class="profile-kpi-trend trend-up"><asp:Literal ID="litTestsTaken" runat="server" Text="0" /> Assessments Taken</div>
        </div>
    </div>

    <!-- Main Two-Column Content Layout (Page 22 & Page 23) -->
    <div class="details-grid">
        
        <!-- Left Column: Assessment Scores, Coding Stats, Mock Interview Breakdown -->
        <div>
            
            <!-- Aptitude & Cognitive Domain Mastery (Page 23) -->
            <div class="section-card">
                <div class="section-title">
                    <span>Aptitude &amp; Technical Domain Competency</span>
                    <span style="font-size:11px; font-weight:500; color:#64748b;">Average Score: <asp:Literal ID="litAvgScore" runat="server" />%</span>
                </div>
                
                <div class="domain-progress-row">
                    <div class="domain-info">
                        <span>Quantitative Aptitude (Algebra, Probability, Arithmetic)</span>
                        <span><asp:Literal ID="litQuantScore" runat="server" Text="88%" /></span>
                    </div>
                    <div class="domain-bar-bg">
                        <div class="domain-bar-fill" style="width: 88%;"></div>
                    </div>
                </div>

                <div class="domain-progress-row">
                    <div class="domain-info">
                        <span>Logical Reasoning (Puzzles, Blood Relations, Syllogisms)</span>
                        <span><asp:Literal ID="litLogicScore" runat="server" Text="92%" /></span>
                    </div>
                    <div class="domain-bar-bg">
                        <div class="domain-bar-fill" style="width: 92%;"></div>
                    </div>
                </div>

                <div class="domain-progress-row">
                    <div class="domain-info">
                        <span>Verbal Ability (Comprehension &amp; Sentence Correction)</span>
                        <span><asp:Literal ID="litVerbalScore" runat="server" Text="84%" /></span>
                    </div>
                    <div class="domain-bar-bg">
                        <div class="domain-bar-fill" style="width: 84%;"></div>
                    </div>
                </div>

                <div class="domain-progress-row">
                    <div class="domain-info">
                        <span>Core CS Fundamentals (DBMS, OS, Computer Networks)</span>
                        <span><asp:Literal ID="litCoreCsScore" runat="server" Text="90%" /></span>
                    </div>
                    <div class="domain-bar-bg">
                        <div class="domain-bar-fill" style="width: 90%;"></div>
                    </div>
                </div>
            </div>

            <!-- Coding & Algorithmic Performance Details (Page 23) -->
            <div class="section-card">
                <div class="section-title">
                    <span>Coding &amp; Algorithmic Statistics</span>
                    <span style="font-size:11px; font-weight:500; color:#059669;">84% Overall Acceptance</span>
                </div>
                <div style="display:grid; grid-template-columns:repeat(3, 1fr); gap:12px; margin-bottom:14px; text-align:center;">
                    <div style="background:#f0fdf4; border:1px solid #bbf7d0; border-radius:8px; padding:10px;">
                        <div style="font-size:10px; color:#166534; font-weight:700; text-transform:uppercase;">Easy</div>
                        <div style="font-size:18px; font-weight:800; color:#15803d; margin-top:2px;">54 / 60</div>
                    </div>
                    <div style="background:#fefce8; border:1px solid #fef08a; border-radius:8px; padding:10px;">
                        <div style="font-size:10px; color:#854d0e; font-weight:700; text-transform:uppercase;">Medium</div>
                        <div style="font-size:18px; font-weight:800; color:#a16207; margin-top:2px;">68 / 85</div>
                    </div>
                    <div style="background:#fef2f2; border:1px solid #fecaca; border-radius:8px; padding:10px;">
                        <div style="font-size:10px; color:#991b1b; font-weight:700; text-transform:uppercase;">Hard</div>
                        <div style="font-size:18px; font-weight:800; color:#b91c1c; margin-top:2px;">20 / 35</div>
                    </div>
                </div>
                <div style="font-size:11px; color:#475569; display:flex; justify-content:space-between; border-top:1px solid #f1f5f9; padding-top:10px;">
                    <span>Active Practice Streak: <strong>14 Days</strong></span>
                    <span>Favorite Languages: <strong>C#, Java, Python 3</strong></span>
                </div>
            </div>

            <!-- Latest AI Mock Interview Evaluation (Page 23) -->
            <div class="section-card">
                <div class="section-title">
                    <span>Latest AI Mock Interview Session</span>
                    <span class="badge-fit">Strong Hire Potential</span>
                </div>
                <div style="background:#f8fafc; border:1px solid #e2e8f0; border-radius:8px; padding:14px; margin-bottom:12px;">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
                        <strong style="font-size:13px; color:#0f172a;">Technical Core &amp; System Design (Scalable Microservices)</strong>
                        <span style="font-size:11px; color:#64748b;">Completed 2 days ago</span>
                    </div>
                    <p style="font-size:11.5px; color:#475569; margin:0 0 10px; line-height:1.4;">
                        Candidate demonstrated solid knowledge of caching layers, distributed sharding, and ACID transaction boundaries. Articulated STAR framework cleanly during behavioral questions.
                    </p>
                    <div style="display:flex; gap:16px; font-size:11px; color:#334155;">
                        <span>Clarity Score: <strong>86/100</strong></span>
                        <span>Technical Depth: <strong>92/100</strong></span>
                        <span>Tone &amp; Pace: <strong>132 WPM (Optimal)</strong></span>
                    </div>
                </div>
                <button type="button" style="padding:6px 12px; background:#f1f5f9; border:1px solid #cbd5e1; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer;" onclick="alert('Displaying verified transcript for session:\n\nInterviewer: How would you scale an in-memory session cache?\nCandidate: I would use Redis with cluster replication and consistent hashing...')">
                    View Full Interview Transcript
                </button>
            </div>

        </div>

        <!-- Right Column: Document Vault, Verified Skills, Mentorship Notes -->
        <div>
            
            <!-- Document Vault & Resumes (Page 22) -->
            <div class="section-card">
                <div class="section-title">
                    <span>Document Vault</span>
                    <span style="font-size:10px; color:#059669; font-weight:700;">ATS Verified</span>
                </div>
                <div class="doc-item">
                    <div>
                        <strong>Resume_Technical_Core.pdf</strong>
                        <div style="font-size:10px; color:#64748b;">ATS Score: 88% &bull; Updated Sep 2026</div>
                    </div>
                    <button type="button" style="padding:4px 8px; border-radius:4px; font-size:10px; font-weight:600; background:#fff; border:1px solid #cbd5e1; cursor:pointer;" onclick="alert('Streaming verified candidate resume preview.')">
                        Download
                    </button>
                </div>
                <div class="doc-item">
                    <div>
                        <strong>Resume_FullStack_Dev.pdf</strong>
                        <div style="font-size:10px; color:#64748b;">ATS Score: 84% &bull; Updated Aug 2026</div>
                    </div>
                    <button type="button" style="padding:4px 8px; border-radius:4px; font-size:10px; font-weight:600; background:#fff; border:1px solid #cbd5e1; cursor:pointer;" onclick="alert('Streaming verified candidate resume preview.')">
                        Download
                    </button>
                </div>
                <div class="doc-item">
                    <div>
                        <strong>Academic_Transcript_Sem1-6.pdf</strong>
                        <div style="font-size:10px; color:#64748b;">Controller of Exams Verified</div>
                    </div>
                    <button type="button" style="padding:4px 8px; border-radius:4px; font-size:10px; font-weight:600; background:#fff; border:1px solid #cbd5e1; cursor:pointer;" onclick="alert('Opening official grade sheet.')">
                        View
                    </button>
                </div>
            </div>

            <!-- Verified Skills & Competencies (Page 22) -->
            <div class="section-card">
                <div class="section-title">
                    <span>Verified Skill Badges</span>
                </div>
                <div>
                    <asp:Repeater ID="rptSkills" runat="server">
                        <ItemTemplate>
                            <span class="skill-chip"><%# Container.DataItem %></span>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- Faculty Mentorship Notes (Page 23) -->
            <div class="section-card">
                <div class="section-title">
                    <span>Faculty Mentorship &amp; Advising</span>
                </div>
                <div style="font-size:11.5px; color:#475569; background:#fffbeb; border:1px solid #fef3c7; border-radius:8px; padding:12px; margin-bottom:12px;">
                    <strong>Latest Coordinator Note:</strong>
                    <p style="margin:4px 0 0; font-size:11px;">
                        <asp:Literal ID="litFacultyNote" runat="server" Text="Candidate is well-prepared for Tier-1 product placement drives. Recommended to review graph algorithms and system design before Google / Amazon rounds." />
                    </p>
                </div>
                <button type="button" onclick="document.getElementById('noteModal').style.display='grid'" style="width:100%; padding:8px; background:#f1f5f9; border:1px solid #cbd5e1; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer;">
                    Update Mentorship Record
                </button>
            </div>

        </div>

    </div>

</div>

<!-- Faculty Mentorship Note Modal -->
<div id="noteModal" style="display:none; position:fixed; top:0; left:0; right:0; bottom:0; background:rgba(15,23,42,0.6); backdrop-filter:blur(4px); z-index:9999; place-items:center; padding:16px;">
    <div style="background:#fff; border-radius:12px; max-width:440px; width:100%; padding:20px; box-shadow:0 10px 25px rgba(0,0,0,0.15);">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:14px; border-bottom:1px solid #e2e8f0; padding-bottom:10px;">
            <h3 style="margin:0; font-size:15px; font-weight:700;">Add Faculty Mentorship Note</h3>
            <button type="button" onclick="document.getElementById('noteModal').style.display='none'" style="border:none; background:none; font-size:20px; cursor:pointer;">&times;</button>
        </div>
        <div>
            <label style="font-size:11px; font-weight:600; color:#334155; display:block; margin-bottom:4px;">Guidance / Remedial Action Instructions</label>
            <asp:TextBox ID="txtNewNote" runat="server" TextMode="MultiLine" Rows="4" 
                placeholder="Enter counseling guidance, assigned remedial topics, or drive recommendations..."
                style="width:100%; padding:8px; border:1px solid #cbd5e1; border-radius:6px; font-size:11px; box-sizing:border-box;" />
        </div>
        <div style="display:flex; justify-content:flex-end; gap:8px; margin-top:16px; border-top:1px solid #e2e8f0; padding-top:12px;">
            <button type="button" onclick="document.getElementById('noteModal').style.display='none'" style="padding:7px 14px; background:#fff; border:1px solid #cbd5e1; border-radius:6px; font-size:11px; cursor:pointer;">Cancel</button>
            <asp:Button ID="btnSaveNote" runat="server" Text="Save Mentorship Note" OnClick="btnSaveNote_Click" style="padding:7px 14px; background:var(--fac-teal); color:#fff; border:none; border-radius:6px; font-size:11px; font-weight:600; cursor:pointer;" />
        </div>
    </div>
</div>

</asp:Content>
