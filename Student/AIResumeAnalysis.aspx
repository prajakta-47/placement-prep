<%@ Page Title="Resume Analysis Report" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="AIResumeAnalysis.aspx.cs"
    Inherits="PlacementPrep.AIResumeAnalysis" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Resume Analysis Report | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-analysis-container">
        
        <!-- Header -->
        <header class="student-analysis-header">
            <div class="student-viewer-title-group">
                <h1>Resume Analysis Report</h1>
                <span class="student-file-tag">
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                    <span>Document:</span>
                    <asp:Label ID="lblDocName" runat="server" Text="alex_smith_swe_2024.pdf" />
                </span>
                <span class="student-badge-match">Parsed</span>
            </div>

            <div class="student-viewer-actions">
                <asp:LinkButton ID="btnReanalyze" runat="server" CssClass="stu-btn-outline" OnClick="btnReanalyze_Click">
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21.5 2v6h-6M21.34 15.57a10 10 0 1 1-.57-8.38l5.67-5.67"/></svg>
                    <span>Re-Analyze</span>
                </asp:LinkButton>
                <button type="button" class="stu-btn-outline" onclick="window.print();">
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
                    <span>Export PDF</span>
                </button>
                <asp:HyperLink ID="lnkSkillGap" runat="server" CssClass="stu-btn-primary" NavigateUrl="~/Student/SkillGapAnalysis.aspx">
                    <span>View Skill Gaps &rarr;</span>
                </asp:HyperLink>
            </div>
        </header>

        <!-- Notification Panel for Re-Analyze -->
        <asp:Panel ID="pnlNotice" runat="server" Visible="false" CssClass="stu-alert success">
            <asp:Literal ID="litNotice" runat="server" />
        </asp:Panel>

        <!-- Metrics Row: ATS Score & Extracted Skills -->
        <div class="student-analysis-metrics-grid">
            
            <!-- Left: ATS Match Score Circle -->
            <section class="student-score-card">
                <div class="student-score-card-title">
                    <span>ATS Match Score</span>
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="#64748b" stroke-width="1.8"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>
                </div>

                <div class="student-ring-score">
                    <svg viewBox="0 0 100 100">
                        <circle class="ring-bg" cx="50" cy="50" r="45" />
                        <circle class="ring-fill" cx="50" cy="50" r="45" />
                    </svg>
                    <div class="student-ring-text">
                        <strong>78%</strong>
                        <small>Good Match</small>
                    </div>
                </div>

                <div class="student-score-role">
                    Target Role: <strong>Senior Software Engineer</strong>
                </div>
            </section>

            <!-- Right: Extracted Skills Breakdown -->
            <section class="student-skills-breakdown-card">
                <div class="student-extracted-card-header">
                    <h3>
                        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 2 7 12 12 22 7 12 2"/><polyline points="2 17 12 22 22 17"/><polyline points="2 12 12 17 22 12"/></svg>
                        <span>Extracted Skills</span>
                    </h3>
                    <span class="student-pill-count">24 Identified</span>
                </div>

                <div>
                    <strong style="font-size:10px; color:#475569;">Hard Skills (Matched)</strong>
                    <div class="student-matched-chips">
                        <span class="chip-matched">&#10003; React.js</span>
                        <span class="chip-matched">&#10003; TypeScript</span>
                        <span class="chip-matched">&#10003; Node.js</span>
                        <span class="chip-matched">&#10003; AWS</span>
                        <span class="chip-matched">&#10003; PostgreSQL</span>
                    </div>
                </div>

                <div>
                    <strong style="font-size:10px; color:#b91c1c;">Missing Key Terms (Target Role)</strong>
                    <div class="student-missing-chips">
                        <span class="chip-missing">&times; GraphQL</span>
                        <span class="chip-missing">&times; Docker</span>
                        <span class="chip-missing">&times; CI/CD</span>
                    </div>
                </div>

                <div class="student-keyword-tip">
                    <span>Recommended keyword density: 3&ndash;5% for target Senior SWE track</span>
                    <a href="javascript:void(0);" style="color:var(--stu-teal); font-weight:700;">View full syntax breakdown &rarr;</a>
                </div>
            </section>

        </div>

        <!-- 2-Column: Strengths vs Improvement Areas -->
        <div class="student-feedback-2col">
            
            <section class="student-feedback-card strengths">
                <h3 style="color:#059669;">
                    <svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                    <span>Resume Strengths</span>
                </h3>

                <div class="student-feedback-item">
                    <strong>&#10003; Strong Action Verbs</strong>
                    <p>You consistently use high-impact verbs like &ldquo;Architected&rdquo; and &ldquo;Spearheaded&rdquo;.</p>
                </div>

                <div class="student-feedback-item">
                    <strong>&#10003; Quantifiable Metrics</strong>
                    <p>Excellent use of data to back up achievements (e.g., &ldquo;reduced latency by 40%&rdquo;).</p>
                </div>

                <div class="student-feedback-item">
                    <strong>&#10003; Clear Formatting</strong>
                    <p>Your layout is clean and easily parsable by standard ATS systems.</p>
                </div>
            </section>

            <section class="student-feedback-card improvements">
                <h3 style="color:#d97706;">
                    <svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="2"><path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
                    <span>Areas for Improvement</span>
                </h3>

                <div class="student-feedback-item">
                    <strong>! Summary Section is Too Long</strong>
                    <p>Consider condensing the executive summary to 3&ndash;4 impactful sentences focusing on quantifiable outcomes.</p>
                </div>

                <div class="student-feedback-item">
                    <strong>! Missing Soft Skills</strong>
                    <p>Leadership and cross-functional team collaboration aren&rsquo;t explicitly highlighted in your recent experience.</p>
                </div>
            </section>

        </div>

        <!-- AI Action Plan Hero Banner -->
        <section class="student-action-plan-banner">
            <div class="student-action-plan-header">
                <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                <span>AI Action Plan</span>
            </div>

            <div class="student-action-plan-grid">
                
                <div class="student-action-plan-box">
                    <h4>Recommendation 1: Optimize Experience Bullet</h4>
                    <div class="plan-snippet">&ldquo;Worked on the backend API to improve speed.&rdquo;</div>
                    <p class="plan-suggested">
                        <strong>&rarr; Suggested:</strong> &ldquo;Redesigned core RESTful APIs using Node.js, reducing response latency by 35% and supporting 1,000&#43; concurrent requests.&rdquo;
                    </p>
                </div>

                <div class="student-action-plan-box">
                    <h4>Recommendation 2: Keyword Injection</h4>
                    <p style="font-size:9.5px; color:#e2e8f0; margin:0 0 8px;">
                        Add missing critical skills identified for Senior SWE roles to contextually relevant past achievements:
                    </p>
                    <div style="display:flex; flex-wrap:wrap; gap:6px;">
                        <span class="student-skill-chip" style="background:rgba(255,255,255,0.15); color:#6ee7b7; border-color:rgba(255,255,255,0.2);">&#43; System Design</span>
                        <span class="student-skill-chip" style="background:rgba(255,255,255,0.15); color:#6ee7b7; border-color:rgba(255,255,255,0.2);">&#43; Docker / Kubernetes</span>
                        <span class="student-skill-chip" style="background:rgba(255,255,255,0.15); color:#6ee7b7; border-color:rgba(255,255,255,0.2);">&#43; CI/CD Pipelines</span>
                    </div>
                </div>

            </div>
        </section>

    </div>
</asp:Content>
