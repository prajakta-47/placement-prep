<%@ Page Title="Skill Gap Analysis" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="SkillGapAnalysis.aspx.cs"
    Inherits="PlacementPrep.SkillGapAnalysis" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Skill Gap Analysis | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-gap-container">
        
        <!-- Header -->
        <header class="student-gap-header">
            <div>
                <div class="student-analyzer-tag" style="margin-bottom: 4px;">
                    <span class="tag-dot"></span>
                    <span>ROLE ASSESSMENT &bull; Updated today at 09:42 AM</span>
                </div>
                <h1 style="font-size:22px; font-weight:800; margin:0 0 4px; letter-spacing:-0.5px;">Skill Gap Analysis</h1>
                <p style="margin:0; font-size:11px; color:#64748b;">
                    Benchmarking your current profile against: 
                    <strong style="color:var(--stu-teal);"><asp:Label ID="lblTargetRole" runat="server" Text="Senior Frontend Developer" /></strong>
                </p>
            </div>

            <div class="student-viewer-actions">
                <asp:DropDownList ID="ddlRoleSelector" runat="server" CssClass="stu-btn-outline" AutoPostBack="true" OnSelectedIndexChanged="ddlRoleSelector_SelectedIndexChanged" style="padding:6px 10px;">
                    <asp:ListItem Value="Senior Frontend Developer" Selected="True">Role: Senior Frontend Developer</asp:ListItem>
                    <asp:ListItem Value="Senior Backend Engineer">Role: Senior Backend Engineer</asp:ListItem>
                    <asp:ListItem Value="Full Stack Engineer">Role: Full Stack Engineer</asp:ListItem>
                    <asp:ListItem Value="Data Engineer">Role: Data Engineer</asp:ListItem>
                </asp:DropDownList>

                <button type="button" class="stu-btn-outline" onclick="window.print();">
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
                    <span>Download Report</span>
                </button>
            </div>
        </header>

        <!-- Notification Banner -->
        <asp:Panel ID="pnlActionNotice" runat="server" Visible="false" CssClass="stu-alert success">
            <asp:Literal ID="litActionNotice" runat="server" />
        </asp:Panel>

        <!-- Row 1: Competency Radar vs Identified Skill Gaps -->
        <div class="student-gap-grid">
            
            <!-- Radar Visualization Card -->
            <section class="student-radar-card">
                <div class="student-extracted-card-header" style="width:100%;">
                    <h3>
                        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="10"/><path d="M12 2a14.5 14.5 0 0 0 0 20 14.5 14.5 0 0 0 0-20"/><path d="M2 12h20"/></svg>
                        <span>Competency Radar</span>
                    </h3>
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="#64748b" stroke-width="1.8"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>
                </div>

                <!-- SVG Radar Chart with 6 axes -->
                <div class="student-radar-chart-wrap">
                    <svg viewBox="0 0 300 300" width="100%" height="100%">
                        <!-- Radar Grid Polygons -->
                        <polygon points="150,30 254,90 254,210 150,270 46,210 46,90" fill="none" stroke="#e2e8f0" stroke-width="1" />
                        <polygon points="150,60 228,105 228,195 150,240 72,195 72,105" fill="none" stroke="#e2e8f0" stroke-width="1" />
                        <polygon points="150,90 202,120 202,180 150,210 98,180 98,120" fill="none" stroke="#e2e8f0" stroke-width="1" />
                        <polygon points="150,120 176,135 176,165 150,180 124,165 124,135" fill="none" stroke="#e2e8f0" stroke-width="1" />

                        <!-- Axis Lines -->
                        <line x1="150" y1="150" x2="150" y2="30" stroke="#cbd5e1" stroke-width="1" stroke-dasharray="2,2" />
                        <line x1="150" y1="150" x2="254" y2="90" stroke="#cbd5e1" stroke-width="1" stroke-dasharray="2,2" />
                        <line x1="150" y1="150" x2="254" y2="210" stroke="#cbd5e1" stroke-width="1" stroke-dasharray="2,2" />
                        <line x1="150" y1="150" x2="150" y2="270" stroke="#cbd5e1" stroke-width="1" stroke-dasharray="2,2" />
                        <line x1="150" y1="150" x2="46" y2="210" stroke="#cbd5e1" stroke-width="1" stroke-dasharray="2,2" />
                        <line x1="150" y1="150" x2="46" y2="90" stroke="#cbd5e1" stroke-width="1" stroke-dasharray="2,2" />

                        <!-- Target Role Polygon (Indigo outline) -->
                        <polygon points="150,42 240,98 245,202 150,252 58,205 52,98"
                            fill="rgba(99, 102, 241, 0.08)" stroke="#6366f1" stroke-width="2" stroke-dasharray="4,3" />

                        <!-- Candidate Profile Polygon (Teal filled) -->
                        <polygon points="150,55 210,118 190,175 150,225 80,188 70,115"
                            fill="rgba(8, 121, 110, 0.28)" stroke="#08796e" stroke-width="2.2" />

                        <!-- Axis Labels -->
                        <text x="150" y="20" font-size="9" font-weight="700" text-anchor="middle" fill="#334155">React / Vue</text>
                        <text x="260" y="90" font-size="9" font-weight="700" text-anchor="start" fill="#334155">System Arch</text>
                        <text x="260" y="215" font-size="9" font-weight="700" text-anchor="start" fill="#334155">CSS / Styling</text>
                        <text x="150" y="288" font-size="9" font-weight="700" text-anchor="middle" fill="#334155">State Mgmt</text>
                        <text x="40" y="215" font-size="9" font-weight="700" text-anchor="end" fill="#334155">Performance</text>
                        <text x="40" y="90" font-size="9" font-weight="700" text-anchor="end" fill="#334155">CI / CD</text>
                    </svg>
                </div>

                <div class="student-radar-legend">
                    <span><i class="legend-dot-profile"></i> Your Profile</span>
                    <span><i class="legend-dot-target"></i> Target Role</span>
                </div>

                <div class="student-gap-match-box">
                    <small>Overall Benchmark Match</small>
                    <strong><asp:Label ID="lblOverallMatch" runat="server" Text="68%" /></strong>
                </div>
            </section>

            <!-- Identified Skill Gaps List Card -->
            <section class="student-gaps-list-card">
                <div class="student-extracted-card-header">
                    <h3>
                        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 2 7 12 12 22 7 12 2"/><polyline points="2 17 12 22 22 17"/><polyline points="2 12 12 17 22 12"/></svg>
                        <span>Identified Skill Gaps</span>
                    </h3>
                    <span class="student-badge-priority hard" style="font-size:9px;">4 CRITICAL GAPS</span>
                </div>

                <!-- Gap Item 1 (Hard) -->
                <div class="student-gap-item">
                    <div class="student-gap-item-top">
                        <span class="student-gap-title">
                            <span style="color:#b91c1c;">&#9679;</span>
                            <span>Advanced System Architecture</span>
                        </span>
                        <span class="student-badge-priority hard">HARD</span>
                    </div>
                    <p class="student-gap-desc">
                        Missing evidence of designing large-scale distributed frontend applications. Target role requires micro-frontend experience and monorepo orchestration.
                    </p>
                    <div class="student-gap-meta">
                        <asp:LinkButton ID="btnPlan1" runat="server" CommandArgument="Micro-Frontends Masterclass" OnClick="btnStartPlan_Click">
                            View Learning Path &rarr;
                        </asp:LinkButton>
                        <span>Est. 12 hours prep</span>
                    </div>
                </div>

                <!-- Gap Item 2 (Medium) -->
                <div class="student-gap-item">
                    <div class="student-gap-item-top">
                        <span class="student-gap-title">
                            <span style="color:#b45309;">&#9679;</span>
                            <span>Web Performance Optimization</span>
                        </span>
                        <span class="student-badge-priority medium">MEDIUM</span>
                    </div>
                    <p class="student-gap-desc">
                        Resume lacks metrics regarding Core Web Vitals improvements, bundle reduction, or specific memory leak profiling techniques.
                    </p>
                    <div class="student-gap-meta">
                        <asp:LinkButton ID="btnPlan2" runat="server" CommandArgument="Core Web Vitals Audit" OnClick="btnStartPlan_Click">
                            Take Assessment &rarr;
                        </asp:LinkButton>
                        <span>35-min simulated lab</span>
                    </div>
                </div>

                <!-- Gap Item 3 (Easy) -->
                <div class="student-gap-item">
                    <div class="student-gap-item-top">
                        <span class="student-gap-title">
                            <span style="color:#0369a1;">&#9679;</span>
                            <span>GraphQL APIs</span>
                        </span>
                        <span class="student-badge-priority easy">EASY</span>
                    </div>
                    <p class="student-gap-desc">
                        Current experience focuses heavily on REST. Senior roles increasingly expect GraphQL schema design, Apollo cache manipulation, and batch query proficiency.
                    </p>
                    <div class="student-gap-meta">
                        <asp:LinkButton ID="btnPlan3" runat="server" CommandArgument="GraphQL vs REST Cheatsheet" OnClick="btnStartPlan_Click">
                            View Module &rarr;
                        </asp:LinkButton>
                        <span>Self-paced reading</span>
                    </div>
                </div>

                <div class="student-baseline-bar">
                    <span>&#10003; Closing these gaps raises your hireability score to <strong>94%</strong></span>
                    <a href="javascript:void(0);">View All Gaps (4)</a>
                </div>
            </section>

        </div>

        <!-- Row 2: Recommended Action Plan -->
        <section class="student-action-recommendations">
            <div class="student-action-recommendations-header">
                <div>
                    <h3>Recommended Action Plan</h3>
                    <p style="margin:2px 0 0; font-size:10px; color:#64748b;">
                        Handpicked interactive sessions and guides tailored to clear your specific red flags.
                    </p>
                </div>
                <span class="student-pill-count" style="background:#e6f8f4; color:#0c7c6a; font-weight:800;">
                    &bull; AI Adaptive Sequence
                </span>
            </div>

            <div class="student-action-cards-grid">
                
                <!-- Action Card 1 -->
                <div class="student-action-card">
                    <div>
                        <span class="student-action-type">Module &bull; System Design Track</span>
                        <h4>Micro-Frontends Masterclass</h4>
                        <p>A deep dive into Module Federation, state sharing, independent CI/CD pipelines, and runtime deployment strategies for scale.</p>
                    </div>
                    <div class="student-action-card-footer">
                        <span>Est. 4 hours</span>
                        <asp:Button ID="btnAction1" runat="server" Text="Start Module" CssClass="btn-start" CommandArgument="Micro-Frontends Masterclass" OnClick="btnStartPlan_Click" />
                    </div>
                </div>

                <!-- Action Card 2 -->
                <div class="student-action-card">
                    <div>
                        <span class="student-action-type">Assessment &bull; Hands-on Sandbox</span>
                        <h4>Core Web Vitals Audit</h4>
                        <p>Test your ability to identify and fix rendering bottlenecks, CLS shifts, and hydration lags in a provided broken React application.</p>
                    </div>
                    <div class="student-action-card-footer">
                        <span>Interactive Lab</span>
                        <asp:Button ID="btnAction2" runat="server" Text="Launch Lab" CssClass="btn-start" CommandArgument="Core Web Vitals Audit" OnClick="btnStartPlan_Click" />
                    </div>
                </div>

                <!-- Action Card 3 -->
                <div class="student-action-card">
                    <div>
                        <span class="student-action-type">Quick Read &bull; API Architectures</span>
                        <h4>GraphQL vs REST Cheatsheet</h4>
                        <p>Key differences, query structures, schema stitching, and when to use which architectural style during staff engineering interviews.</p>
                    </div>
                    <div class="student-action-card-footer">
                        <span>15 min read</span>
                        <asp:Button ID="btnAction3" runat="server" Text="Read Now" CssClass="btn-start" CommandArgument="GraphQL vs REST Cheatsheet" OnClick="btnStartPlan_Click" />
                    </div>
                </div>

            </div>
        </section>

    </div>
</asp:Content>
