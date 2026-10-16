<%@ Page Title="Feedback Hub" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="FeedbackHub.aspx.cs"
    Inherits="PlacementPrep.FeedbackHub" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Feedback Hub | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-feedback-container">
        
        <!-- Hero Score Card -->
        <div class="feedback-score-hero">
            <div>
                <span class="feedback-score-pill">
                    <span class="tag-dot" style="background:#fff;"></span>
                    <span>DIAGNOSTIC AGGREGATE &bull; EVALUATION ENGINE V4.2</span>
                </span>
                <h2>Overall Placement Readiness: 86 / 100</h2>
                <p style="margin:0; font-size:11.5px; opacity:0.9; max-width:640px; line-height:1.5;">
                    Synthesized from your 12 evaluated sessions across AI mock technical interviews, automated coding submissions, and faculty mentor feedback.
                </p>
            </div>

            <div style="display:flex; align-items:center; gap:12px;">
                <div style="background:rgba(255,255,255,0.15); border-radius:10px; padding:12px 18px; text-align:center;">
                    <div style="font-size:20px; font-weight:800;">Top 8%</div>
                    <small style="font-size:9.5px; opacity:0.85;">CAMPUS COHORT</small>
                </div>
                <a href="<%= ResolveUrl("~/Student/InterviewPrep.aspx") %>" class="stu-btn-outline" style="background:#fff; color:var(--stu-teal); font-weight:700; border:0; padding:10px 16px;">
                    Start New Practice &rarr;
                </a>
            </div>
        </div>

        <!-- Filter Bar -->
        <div class="student-review-filter-bar">
            <asp:LinkButton ID="btnFilterAll" runat="server" CssClass="student-filter-tab active" OnClick="FilterCategory_Click" CommandArgument="All">
                All Feedback (5)
            </asp:LinkButton>
            <asp:LinkButton ID="btnFilterAI" runat="server" CssClass="student-filter-tab" OnClick="FilterCategory_Click" CommandArgument="AI">
                AI Interviews (2)
            </asp:LinkButton>
            <asp:LinkButton ID="btnFilterCoding" runat="server" CssClass="student-filter-tab" OnClick="FilterCategory_Click" CommandArgument="Code">
                Code Reviews (2)
            </asp:LinkButton>
            <asp:LinkButton ID="btnFilterMentor" runat="server" CssClass="student-filter-tab" OnClick="FilterCategory_Click" CommandArgument="Mentor">
                Mentor Sessions (1)
            </asp:LinkButton>
        </div>

        <!-- Grid Layout: Left Feedbacks, Right Competency & Radar -->
        <div class="feedback-grid-layout">
            
            <!-- Left Column: Feedback Cards List -->
            <div>
                <asp:Repeater ID="rptFeedbacks" runat="server">
                    <ItemTemplate>
                        <div class="feedback-card-item">
                            <div style="display:flex; align-items:center; justify-content:space-between;">
                                <div style="display:flex; align-items:center; gap:8px;">
                                    <span class="student-pill-count"><%# Eval("CategoryBadge") %></span>
                                    <span style="font-size:10px; color:#64748b;"><%# Eval("DateFormatted") %></span>
                                </div>
                                <span class='<%# "difficulty-badge " + Eval("ScoreBadgeClass") %>'>
                                    Score: <%# Eval("ScorePercent") %>%
                                </span>
                            </div>

                            <div>
                                <h3 style="font-size:14px; font-weight:800; margin:0 0 4px; color:var(--stu-text);">
                                    <%# Eval("Title") %>
                                </h3>
                                <p style="font-size:11px; color:#475569; margin:0 0 8px; line-height:1.5;">
                                    <%# Eval("Summary") %>
                                </p>
                            </div>

                            <!-- Highlights & Recommendation -->
                            <div style="background:#f8fafc; border:1px solid #e2e8f0; border-radius:6px; padding:10px 12px; font-size:10.5px;">
                                <strong style="color:var(--stu-text); display:block; margin-bottom:2px;">Key Evaluator Feedback:</strong>
                                <span style="color:#059669; font-weight:600;">&#10003; Strength:</span> <%# Eval("Strength") %><br />
                                <span style="color:#d97706; font-weight:600;">&#9888; Area to Polish:</span> <%# Eval("Improvement") %>
                            </div>

                            <div style="display:flex; align-items:center; justify-content:space-between; padding-top:10px; border-top:1px solid #f1f2f8;">
                                <span style="font-size:10px; color:#64748b;">
                                    Verdict: <strong style="color:var(--stu-teal);"><%# Eval("Verdict") %></strong>
                                </span>
                                <a href='<%# ResolveUrl(Eval("ActionUrl").ToString()) %>' class="stu-btn-outline" style="font-size:9.5px; padding:4px 10px;">
                                    <%# Eval("ActionLabel") %> &rarr;
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- Right Column: Competency Matrix & Radar Visualization -->
            <div style="display:flex; flex-direction:column; gap:16px;">
                
                <!-- Competency Matrix -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
                            <span>Competency Matrix</span>
                        </h3>
                        <span class="student-pill-count">Multi-Round</span>
                    </div>

                    <div style="display:flex; flex-direction:column; gap:10px; margin-top:4px;">
                        <div>
                            <div class="competency-row">
                                <strong>Data Structures &amp; Algorithms</strong>
                                <span style="color:#059669; font-weight:700;">92% (High)</span>
                            </div>
                            <div class="student-benchmark-bar"><div class="student-benchmark-fill" style="width:92%;"></div></div>
                        </div>

                        <div>
                            <div class="competency-row">
                                <strong>Behavioral (STAR Method)</strong>
                                <span style="color:#059669; font-weight:700;">88% (High)</span>
                            </div>
                            <div class="student-benchmark-bar"><div class="student-benchmark-fill" style="width:88%;"></div></div>
                        </div>

                        <div>
                            <div class="competency-row">
                                <strong>DBMS &amp; SQL Querying</strong>
                                <span style="color:#059669; font-weight:700;">85% (Proficient)</span>
                            </div>
                            <div class="student-benchmark-bar"><div class="student-benchmark-fill" style="width:85%;"></div></div>
                        </div>

                        <div>
                            <div class="competency-row">
                                <strong>Communication &amp; Articulation</strong>
                                <span style="color:var(--stu-teal); font-weight:700;">84% (Good)</span>
                            </div>
                            <div class="student-benchmark-bar"><div class="student-benchmark-fill" style="width:84%;"></div></div>
                        </div>

                        <div>
                            <div class="competency-row">
                                <strong>Distributed Systems Design</strong>
                                <span style="color:#d97706; font-weight:700;">74% (Growth)</span>
                            </div>
                            <div class="student-benchmark-bar"><div class="student-benchmark-fill" style="width:74%; background:#f59e0b;"></div></div>
                        </div>
                    </div>
                </div>

                <!-- Cognitive Balance Radar Visualization -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                            <span>Cognitive Balance Radar</span>
                        </h3>
                    </div>

                    <!-- SVG Pentagon Radar Chart -->
                    <div style="display:flex; justify-content:center; padding:10px 0;">
                        <svg width="220" height="190" viewBox="0 0 220 190">
                            <!-- Background Web Pentagons -->
                            <polygon points="110,15 200,75 168,170 52,170 20,75" fill="none" stroke="#e2e8f0" stroke-width="1"/>
                            <polygon points="110,40 175,85 152,150 68,150 45,85" fill="none" stroke="#e2e8f0" stroke-width="1"/>
                            <polygon points="110,65 150,95 136,130 84,130 70,95" fill="none" stroke="#e2e8f0" stroke-width="1"/>
                            <!-- Axes -->
                            <line x1="110" y1="95" x2="110" y2="15" stroke="#cbd5e1" stroke-width="1"/>
                            <line x1="110" y1="95" x2="200" y2="75" stroke="#cbd5e1" stroke-width="1"/>
                            <line x1="110" y1="95" x2="168" y2="170" stroke="#cbd5e1" stroke-width="1"/>
                            <line x1="110" y1="95" x2="52" y2="170" stroke="#cbd5e1" stroke-width="1"/>
                            <line x1="110" y1="95" x2="20" y2="75" stroke="#cbd5e1" stroke-width="1"/>
                            <!-- Student Profile Polygon -->
                            <polygon points="110,25 185,80 156,155 64,152 35,80" fill="rgba(8, 121, 110, 0.25)" stroke="#08796e" stroke-width="2"/>
                            <!-- Axis Labels -->
                            <text x="110" y="10" font-size="8.5" font-weight="700" text-anchor="middle" fill="#475569">Analytical (92%)</text>
                            <text x="204" y="78" font-size="8.5" font-weight="700" text-anchor="start" fill="#475569">Speed (84%)</text>
                            <text x="172" y="182" font-size="8.5" font-weight="700" text-anchor="middle" fill="#475569">Code (95%)</text>
                            <text x="48" y="182" font-size="8.5" font-weight="700" text-anchor="middle" fill="#475569">Delivery (84%)</text>
                            <text x="16" y="78" font-size="8.5" font-weight="700" text-anchor="end" fill="#475569">Design (74%)</text>
                        </svg>
                    </div>

                    <p style="font-size:10px; color:#556260; margin:4px 0 0; line-height:1.45; text-align:center;">
                        High analytical rigor and code quality balance. Focusing on system scaling patterns will round out your profile for top-tier software firms.
                    </p>
                </div>

            </div>

        </div>

    </div>
</asp:Content>
