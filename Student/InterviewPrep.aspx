<%@ Page Title="Interview Preparation" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="InterviewPrep.aspx.cs"
    Inherits="PlacementPrep.InterviewPrep" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Interview Preparation | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-prep-container">
        
        <!-- Header -->
        <header class="student-aptitude-header">
            <div>
                <div style="display:flex; align-items:center; gap:8px; margin-bottom:6px;">
                    <span class="ai-engine-badge">
                        <span class="engine-pulse"></span>
                        <span>AI Engine v4.2 &bull; Adaptive Evaluator Active</span>
                    </span>
                    <span style="font-size:10px; color:#64748b;">Latency: <strong>38ms</strong></span>
                </div>
                <h1 style="font-size:22px; font-weight:800; margin:0 0 4px; letter-spacing:-0.5px;">Mock Interview Simulation Studio</h1>
                <p style="margin:0; font-size:11px; color:#64748b;">
                    Practice realistic technical and behavioral campus recruitment rounds with real-time feedback, transcripts, and rubric scoring.
                </p>
            </div>

            <!-- Role Selector -->
            <div style="display:flex; align-items:center; gap:8px;">
                <label style="font-size:10.5px; font-weight:700; color:#475569;">Target Role:</label>
                <asp:DropDownList ID="ddlTargetRole" runat="server" CssClass="stu-btn-outline" AutoPostBack="true" OnSelectedIndexChanged="ddlTargetRole_SelectedIndexChanged" style="padding:6px 12px; font-size:11px;">
                    <asp:ListItem Value="Senior Frontend Developer" Selected="True">Senior Frontend Developer</asp:ListItem>
                    <asp:ListItem Value="Full Stack Software Engineer">Full Stack Software Engineer</asp:ListItem>
                    <asp:ListItem Value="Cloud & Backend Specialist">Cloud &amp; Backend Specialist</asp:ListItem>
                    <asp:ListItem Value="AI & Data Engineer">AI &amp; Data Engineer</asp:ListItem>
                </asp:DropDownList>
            </div>
        </header>

        <!-- Metric Summary Cards -->
        <div class="student-metric-triplet" style="margin-bottom:20px;">
            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Interview Readiness Score</small>
                    <strong>78% <span style="font-size:10px; color:#10b981; font-weight:700;">+6% this week</span></strong>
                </div>
            </div>

            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><rect x="4" y="7" width="16" height="13" rx="3"/><path d="M9 7V5a3 3 0 0 1 6 0v2m-3 5v3"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Completed Simulations</small>
                    <strong>4 Sessions <span style="font-size:10px; color:#64748b; font-weight:normal;">(Avg: 82%)</span></strong>
                </div>
            </div>

            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Latest Diagnostic Report</small>
                    <a href="<%= ResolveUrl("~/Student/InterviewFeedback.aspx") %>" style="color:var(--stu-teal); font-size:11px; font-weight:700; text-decoration:none;">
                        View Feedback Report &rarr;
                    </a>
                </div>
            </div>
        </div>

        <!-- Mode Selection Header -->
        <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:12px;">
            <h2 style="font-size:15px; font-weight:800; margin:0; color:var(--stu-text);">Select Interview Mode</h2>
            <a href="<%= ResolveUrl("~/Student/FeedbackHub.aspx") %>" style="font-size:10.5px; color:#64748b; text-decoration:none;">
                View All Past Feedbacks &rsaquo;
            </a>
        </div>

        <!-- Modes 2x2 Grid -->
        <div class="student-modes-grid">
            
            <!-- Mode 1: Technical Core -->
            <div class="student-mode-card featured">
                <div>
                    <div class="student-mode-header">
                        <div class="student-mode-icon">
                            <svg viewBox="0 0 24 24"><rect x="3" y="4" width="18" height="15" rx="2"/><path d="m8 9-3 3 3 2m4 0 3-5m-9 12h10"/></svg>
                        </div>
                        <span class="student-badge-correct">&#9733; Recommended</span>
                    </div>

                    <h3 style="font-size:15px; font-weight:800; margin:10px 0 4px; color:var(--stu-text);">
                        Technical Core &amp; Coding Round
                    </h3>
                    <p style="font-size:11px; color:#556260; margin:0 0 10px; line-height:1.5;">
                        Deep-dive examination focusing on data structures, algorithmic design, space/time complexity trade-offs, and live coding explanations.
                    </p>

                    <div class="student-mode-topics">
                        <span class="student-pill-count">Algorithms</span>
                        <span class="student-pill-count">Big-O Analysis</span>
                        <span class="student-pill-count">OOP Principles</span>
                        <span class="student-pill-count">DBMS</span>
                    </div>
                </div>

                <div style="display:flex; align-items:center; justify-content:space-between; padding-top:12px; border-top:1px solid #f1f2f8;">
                    <span style="font-size:10.5px; color:#64748b;">
                        Duration: <strong>45 Mins</strong> &bull; 4 Stages
                    </span>
                    <a href="<%= ResolveUrl("~/Student/LiveInterview.aspx?mode=technical") %>" class="stu-btn-primary" style="padding:6px 14px; font-size:10.5px; text-decoration:none;">
                        Launch Interview &rarr;
                    </a>
                </div>
            </div>

            <!-- Mode 2: Behavioral & Fit -->
            <div class="student-mode-card">
                <div>
                    <div class="student-mode-header">
                        <div class="student-mode-icon" style="background:#fef3c7; color:#b45309;">
                            <svg viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                        </div>
                        <span class="difficulty-badge medium">STAR Method</span>
                    </div>

                    <h3 style="font-size:15px; font-weight:800; margin:10px 0 4px; color:var(--stu-text);">
                        Behavioral &amp; Culture Fit Round
                    </h3>
                    <p style="font-size:11px; color:#556260; margin:0 0 10px; line-height:1.5;">
                        Practice behavioral inquiries, leadership challenges, conflict resolution, and situational questions evaluated via the STAR rubric.
                    </p>

                    <div class="student-mode-topics">
                        <span class="student-pill-count">Leadership</span>
                        <span class="student-pill-count">Conflict Resolution</span>
                        <span class="student-pill-count">Team Dynamics</span>
                        <span class="student-pill-count">Adaptability</span>
                    </div>
                </div>

                <div style="display:flex; align-items:center; justify-content:space-between; padding-top:12px; border-top:1px solid #f1f2f8;">
                    <span style="font-size:10.5px; color:#64748b;">
                        Duration: <strong>30 Mins</strong> &bull; 3 Stages
                    </span>
                    <a href="<%= ResolveUrl("~/Student/LiveInterview.aspx?mode=behavioral") %>" class="stu-btn-primary" style="padding:6px 14px; font-size:10.5px; text-decoration:none;">
                        Launch Interview &rarr;
                    </a>
                </div>
            </div>

            <!-- Mode 3: System Design -->
            <div class="student-mode-card">
                <div>
                    <div class="student-mode-header">
                        <div class="student-mode-icon" style="background:#ede9fe; color:#6d28d9;">
                            <svg viewBox="0 0 24 24"><rect x="2" y="3" width="20" height="14" rx="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></svg>
                        </div>
                        <span class="difficulty-badge hard">Tier-1 Companies</span>
                    </div>

                    <h3 style="font-size:15px; font-weight:800; margin:10px 0 4px; color:var(--stu-text);">
                        System Design &amp; Architecture
                    </h3>
                    <p style="font-size:11px; color:#556260; margin:0 0 10px; line-height:1.5;">
                        Architect large-scale distributed systems. Discuss horizontal scaling, database partitioning, caching layers, and microservices resilience.
                    </p>

                    <div class="student-mode-topics">
                        <span class="student-pill-count">Microservices</span>
                        <span class="student-pill-count">Redis Caching</span>
                        <span class="student-pill-count">Load Balancing</span>
                        <span class="student-pill-count">CAP Theorem</span>
                    </div>
                </div>

                <div style="display:flex; align-items:center; justify-content:space-between; padding-top:12px; border-top:1px solid #f1f2f8;">
                    <span style="font-size:10.5px; color:#64748b;">
                        Duration: <strong>45 Mins</strong> &bull; 3 Stages
                    </span>
                    <a href="<%= ResolveUrl("~/Student/LiveInterview.aspx?mode=systemdesign") %>" class="stu-btn-primary" style="padding:6px 14px; font-size:10.5px; text-decoration:none;">
                        Launch Interview &rarr;
                    </a>
                </div>
            </div>

            <!-- Mode 4: Business Case & Problem Solving -->
            <div class="student-mode-card">
                <div>
                    <div class="student-mode-header">
                        <div class="student-mode-icon" style="background:#fef2f2; color:#dc2626;">
                            <svg viewBox="0 0 24 24"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>
                        </div>
                        <span class="student-pill-count">Consulting &amp; Tech</span>
                    </div>

                    <h3 style="font-size:15px; font-weight:800; margin:10px 0 4px; color:var(--stu-text);">
                        Business Case &amp; Problem Solving
                    </h3>
                    <p style="font-size:11px; color:#556260; margin:0 0 10px; line-height:1.5;">
                        Tackle quantitative market estimations, product sense, root cause analysis, and product trade-offs asked in campus placement interviews.
                    </p>

                    <div class="student-mode-topics">
                        <span class="student-pill-count">Market Sizing</span>
                        <span class="student-pill-count">Root Cause Analysis</span>
                        <span class="student-pill-count">Product Metrics</span>
                        <span class="student-pill-count">Trade-offs</span>
                    </div>
                </div>

                <div style="display:flex; align-items:center; justify-content:space-between; padding-top:12px; border-top:1px solid #f1f2f8;">
                    <span style="font-size:10.5px; color:#64748b;">
                        Duration: <strong>35 Mins</strong> &bull; 3 Stages
                    </span>
                    <a href="<%= ResolveUrl("~/Student/LiveInterview.aspx?mode=business") %>" class="stu-btn-primary" style="padding:6px 14px; font-size:10.5px; text-decoration:none;">
                        Launch Interview &rarr;
                    </a>
                </div>
            </div>

        </div>

        <!-- Recent History Quick Links -->
        <section class="student-extracted-card">
            <div class="student-extracted-card-header">
                <h3>
                    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                    <span>Recent Simulation Sessions</span>
                </h3>
                <a href="<%= ResolveUrl("~/Student/FeedbackHub.aspx") %>" style="font-size:10px; color:var(--stu-teal); font-weight:700;">View in Feedback Hub &rsaquo;</a>
            </div>

            <div style="display:flex; flex-direction:column; gap:8px;">
                <div style="display:flex; align-items:center; justify-content:space-between; padding:8px 12px; background:#f8fafc; border-radius:6px; font-size:11px;">
                    <div>
                        <strong>Technical Core Simulation #4</strong>
                        <span style="color:#64748b; font-size:10px; margin-left:6px;">Yesterday at 4:30 PM &bull; 45 Mins</span>
                    </div>
                    <div style="display:flex; align-items:center; gap:10px;">
                        <span style="color:#059669; font-weight:700;">Score: 84%</span>
                        <a href="<%= ResolveUrl("~/Student/InterviewFeedback.aspx") %>" class="stu-btn-outline" style="padding:3px 8px; font-size:9.5px;">View Report</a>
                    </div>
                </div>

                <div style="display:flex; align-items:center; justify-content:space-between; padding:8px 12px; background:#f8fafc; border-radius:6px; font-size:11px;">
                    <div>
                        <strong>Behavioral &amp; Fit Interview #2</strong>
                        <span style="color:#64748b; font-size:10px; margin-left:6px;">3 days ago &bull; 30 Mins</span>
                    </div>
                    <div style="display:flex; align-items:center; gap:10px;">
                        <span style="color:#059669; font-weight:700;">Score: 88%</span>
                        <a href="<%= ResolveUrl("~/Student/InterviewFeedback.aspx") %>" class="stu-btn-outline" style="padding:3px 8px; font-size:9.5px;">View Report</a>
                    </div>
                </div>
            </div>
        </section>

    </div>
</asp:Content>
