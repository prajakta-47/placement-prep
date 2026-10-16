<%@ Page Title="Mock Tests" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="MockTests.aspx.cs"
    Inherits="PlacementPrep.MockTests" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Mock Tests | Placement Prep</title>
    <style>
        .mock-card {
            background: #fff;
            border: 1px solid #eeedf5;
            border-radius: 12px;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: 14px;
            transition: all 0.2s ease;
        }
        .mock-card:hover {
            box-shadow: 0 4px 14px rgba(0,0,0,0.05);
            border-color: #cbd5e1;
        }
        .mock-meta-row {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 14px;
            font-size: 10.5px;
            color: #64748b;
        }
        .mock-meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .mock-meta-item svg {
            width: 13px;
            height: 13px;
            stroke: #64748b;
            fill: none;
            stroke-width: 1.8;
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-mock-container">
        
        <!-- Header -->
        <header class="student-aptitude-header">
            <div>
                <div class="student-analyzer-tag" style="margin-bottom:4px;">
                    <span class="tag-dot"></span>
                    <span>EXAM SIMULATION &bull; TIMED COMPANY ASSESSMENTS</span>
                </div>
                <h1 style="font-size:22px; font-weight:800; margin:0 0 4px; letter-spacing:-0.5px;">Placement Mock Tests</h1>
                <p style="margin:0; font-size:11px; color:#64748b;">
                    Simulate real corporate recruitment rounds under strict proctoring and time parameters with immediate percentile feedback.
                </p>
            </div>
        </header>

        <!-- Metric Summary -->
        <div class="student-metric-triplet" style="margin-bottom:18px;">
            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><polygon points="12 2 2 7 12 12 22 7 12 2"/><polyline points="2 17 12 22 22 17"/><polyline points="2 12 12 17 22 12"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Completed Tests</small>
                    <strong>6 Tests <span style="font-size:10px; color:#10b981; font-weight:700;">+2 This Week</span></strong>
                </div>
            </div>

            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Average Score</small>
                    <strong>82.4% <span style="font-size:10px; color:#64748b; font-weight:normal;">(Target: 75%)</span></strong>
                </div>
            </div>

            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Overall Percentile</small>
                    <strong>91.6th <span style="font-size:10px; color:#10b981; font-weight:700;">Top 10%</span></strong>
                </div>
            </div>
        </div>

        <!-- Filter Tabs -->
        <div class="student-review-filter-bar" style="margin-bottom:16px;">
            <asp:LinkButton ID="btnTabAll" runat="server" CssClass="student-filter-tab active" OnClick="CategoryTab_Click" CommandArgument="All">
                All Mock Tests (6)
            </asp:LinkButton>
            <asp:LinkButton ID="btnTabCompany" runat="server" CssClass="student-filter-tab" OnClick="CategoryTab_Click" CommandArgument="Company">
                Company Specific (3)
            </asp:LinkButton>
            <asp:LinkButton ID="btnTabAptitude" runat="server" CssClass="student-filter-tab" OnClick="CategoryTab_Click" CommandArgument="Aptitude">
                Comprehensive Aptitude (2)
            </asp:LinkButton>
            <asp:LinkButton ID="btnTabTechnical" runat="server" CssClass="student-filter-tab" OnClick="CategoryTab_Click" CommandArgument="Technical">
                Core Technical (1)
            </asp:LinkButton>
        </div>

        <!-- Mock Tests Grid -->
        <div class="student-mock-grid">
            <asp:Repeater ID="rptMockTests" runat="server">
                <ItemTemplate>
                    <div class="mock-card">
                        <div>
                            <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:8px;">
                                <span class="student-pill-count"><%# Eval("CategoryTag") %></span>
                                <span class='<%# "difficulty-badge " + Eval("StatusBadgeClass") %>'>
                                    <%# Eval("StatusText") %>
                                </span>
                            </div>

                            <h3 style="font-size:14.5px; font-weight:800; margin:0 0 6px; color:var(--stu-text);">
                                <%# Eval("Title") %>
                            </h3>
                            <p style="font-size:11px; color:#556260; margin:0 0 12px; line-height:1.5;">
                                <%# Eval("Description") %>
                            </p>

                            <!-- Meta info -->
                            <div class="mock-meta-row">
                                <div class="mock-meta-item">
                                    <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                                    <span><%# Eval("DurationMinutes") %> Mins</span>
                                </div>
                                <div class="mock-meta-item">
                                    <svg viewBox="0 0 24 24"><rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 7h8M8 11h2m4 0h2M8 15h2m4 0h2"/></svg>
                                    <span><%# Eval("QuestionCount") %> Questions</span>
                                </div>
                                <div class="mock-meta-item">
                                    <svg viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/></svg>
                                    <span><%# Eval("AttemptsCount") %> Attempts</span>
                                </div>
                            </div>

                            <!-- Progress Score if completed -->
                            <div style='<%# Eval("IsCompleted").ToString() == "True" ? "margin-top:12px; padding:10px 12px; background:#f8fafc; border-radius:6px; border:1px solid #e2e8f0;" : "display:none;" %>'>
                                <div style="display:flex; justify-content:space-between; font-size:10px; font-weight:700; margin-bottom:4px;">
                                    <span>Latest Score: <strong><%# Eval("BestScore") %>%</strong></span>
                                    <span style="color:#059669;"><%# Eval("PercentileRank") %> Percentile</span>
                                </div>
                                <div class="student-benchmark-bar">
                                    <div class="student-benchmark-fill" style='<%# "width:" + Eval("BestScore") + "%;" %>'></div>
                                </div>
                            </div>
                        </div>

                        <!-- Card Action Buttons -->
                        <div style="display:flex; align-items:center; justify-content:space-between; padding-top:12px; border-top:1px solid #f1f2f8; margin-top:6px;">
                            <span style="font-size:10px; color:#64748b;">
                                Cutoff: <strong style="color:var(--stu-text);"><%# Eval("CutoffMark") %>%</strong>
                            </span>
                            <div style="display:flex; gap:8px;">
                                <a href='<%# ResolveUrl("~/Student/TestResults.aspx?mock=" + Eval("Id")) %>' 
                                   class="stu-btn-outline" 
                                   style='<%# Eval("IsCompleted").ToString() == "True" ? "font-size:10px; padding:4px 10px; text-decoration:none;" : "display:none;" %>'>
                                    Review &rsaquo;
                                </a>
                                <a href='<%# ResolveUrl("~/Student/TestResults.aspx?mock=" + Eval("Id")) %>' 
                                   class="stu-btn-primary" 
                                   style="font-size:10px; padding:4px 12px; text-decoration:none;">
                                    <%# Eval("ActionBtnText") %> &rarr;
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>
</asp:Content>
