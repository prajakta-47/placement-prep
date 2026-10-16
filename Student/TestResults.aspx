<%@ Page Title="Test Results" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="TestResults.aspx.cs"
    Inherits="PlacementPrep.TestResults" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Test Results | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-results-container">
        
        <!-- Breadcrumb & Top Tag -->
        <div style="font-size:10px; color:#64748b; margin-bottom:12px;">
            <a href="<%= ResolveUrl("~/Student/MockTests.aspx") %>">Mock Tests</a> &rsaquo; 
            <asp:Label ID="lblCategoryBreadcrumb" runat="server" Text="Quantitative Aptitude Set A" /> &rsaquo; 
            <strong>Result</strong>
        </div>

        <!-- Banner Summary -->
        <section class="student-results-banner">
            <div class="student-results-header">
                <span class="student-badge-correct" style="margin-bottom:6px;">&#10003; Test Completed</span>
                <h1><asp:Label ID="lblTestTitle" runat="server" Text="Quantitative Aptitude Set A" /></h1>
                <p>Excellent work! You have demonstrated strong analytical skills, particularly in the algebraic reasoning sections. Review your detailed breakdown to identify areas for marginal improvement before the final assessment.</p>
                <div style="margin-top:14px; display:flex; gap:10px;">
                    <asp:HyperLink ID="lnkDetailedReview" runat="server" CssClass="stu-btn-primary" NavigateUrl="~/Student/TestReview.aspx">
                        View Detailed Review &rarr;
                    </asp:HyperLink>
                    <asp:HyperLink ID="lnkRetake" runat="server" CssClass="stu-btn-outline" NavigateUrl="~/Student/Quantitative.aspx">
                        Practice More Sets
                    </asp:HyperLink>
                </div>
            </div>

            <div class="student-score-circle-wrap">
                <div class="student-score-circle">
                    <strong>85%</strong>
                    <small>OVERALL SCORE</small>
                </div>
            </div>
        </section>

        <!-- Metric Triplet -->
        <div class="student-metric-triplet">
            
            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Accuracy</small>
                    <strong>92% <span style="font-size:10px; color:#10b981; font-weight:700;">+4%</span></strong>
                </div>
            </div>

            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Time Taken</small>
                    <strong>45m <span style="font-size:10px; color:#64748b; font-weight:normal;">/ 60m</span></strong>
                </div>
            </div>

            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Percentile Rank</small>
                    <strong>94th <span style="font-size:10px; color:#64748b; font-weight:normal;">Cohort</span></strong>
                </div>
            </div>

        </div>

        <!-- Question Breakdown Bar -->
        <section class="student-breakdown-card">
            <div class="student-breakdown-header">
                <span>Question Breakdown</span>
                <div class="student-breakdown-legend">
                    <span><i class="breakdown-dot-correct"></i> Correct: <strong>42</strong></span>
                    <span><i class="breakdown-dot-incorrect"></i> Incorrect: <strong>5</strong></span>
                    <span><i class="breakdown-dot-unanswered"></i> Unanswered: <strong>3</strong></span>
                    <span style="color:#64748b;">(Total: 50 Questions)</span>
                </div>
            </div>

            <div class="student-breakdown-bar">
                <div style="width:84%; background:#10b981;" title="42 Correct"></div>
                <div style="width:10%; background:#ef4444;" title="5 Incorrect"></div>
                <div style="width:6%; background:#cbd5e1;" title="3 Unanswered"></div>
            </div>
        </section>

        <!-- Topic Proficiency & AI Recommendations -->
        <div class="student-results-split">
            
            <section class="student-extracted-card">
                <div class="student-extracted-card-header">
                    <h3>
                        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 2 7 12 12 22 7 12 2"/><polyline points="2 17 12 22 22 17"/><polyline points="2 12 12 17 22 12"/></svg>
                        <span>Topic Proficiency</span>
                    </h3>
                    <span class="student-pill-count">Top Performing</span>
                </div>

                <div style="display:flex; flex-direction:column; gap:12px;">
                    <div>
                        <div style="display:flex; justify-content:space-between; font-size:10px; font-weight:700; margin-bottom:4px;">
                            <span>Algebraic Formulations</span>
                            <span style="color:var(--stu-teal);">96%</span>
                        </div>
                        <div class="student-benchmark-bar"><div class="student-benchmark-fill" style="width:96%;"></div></div>
                    </div>

                    <div>
                        <div style="display:flex; justify-content:space-between; font-size:10px; font-weight:700; margin-bottom:4px;">
                            <span>Permutations &amp; Combinations</span>
                            <span style="color:var(--stu-teal);">88%</span>
                        </div>
                        <div class="student-benchmark-bar"><div class="student-benchmark-fill" style="width:88%;"></div></div>
                    </div>

                    <div>
                        <div style="display:flex; justify-content:space-between; font-size:10px; font-weight:700; margin-bottom:4px;">
                            <span>Data Interpretation Tables</span>
                            <span style="color:#d97706;">74%</span>
                        </div>
                        <div class="student-benchmark-bar"><div class="student-benchmark-fill" style="width:74%; background:#f59e0b;"></div></div>
                    </div>
                </div>
            </section>

            <!-- AI Recommendation Card -->
            <section class="student-extracted-card" style="display:flex; flex-direction:column; justify-content:space-between;">
                <div>
                    <div class="student-extracted-card-header">
                        <h3 style="color:var(--stu-teal);">
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                            <span>AI Recommendation</span>
                        </h3>
                    </div>
                    <strong style="font-size:12px; color:var(--stu-text); display:block; margin-bottom:6px;">Practice Data Interpretation</strong>
                    <p style="font-size:10px; color:#556260; line-height:1.5; margin:0 0 14px;">
                        Questions 34 and 41 consumed over 4.5 minutes each. Focusing on speed matrix shortcuts and chart scanning techniques will increase your overall score projection by up to <strong>&#43;7%</strong>.
                    </p>
                </div>

                <div style="display:flex; align-items:center; justify-content:space-between; padding-top:12px; border-top:1px solid #f1f2f8;">
                    <asp:HyperLink ID="lnkStartDrill" runat="server" CssClass="stu-btn-primary" NavigateUrl="~/Student/TestReview.aspx">
                        Start 15-Min Focused Drill &rarr;
                    </asp:HyperLink>
                    <span style="font-size:9.5px; color:#64748b; font-weight:700;">10 MCQs</span>
                </div>
            </section>

        </div>

    </div>
</asp:Content>
