<%@ Page Title="Test Review" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="TestReview.aspx.cs"
    Inherits="PlacementPrep.TestReview" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Test Review | Placement Prep</title>
    <style>
        .palette-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 8px;
            margin-top: 10px;
        }
        .palette-btn {
            height: 32px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: 700;
            text-decoration: none;
            border: 1px solid transparent;
            cursor: pointer;
            transition: all 0.15s ease;
        }
        .palette-btn.correct {
            background: #ecfdf5;
            color: #065f46;
            border-color: #a7f3d0;
        }
        .palette-btn.incorrect {
            background: #fef2f2;
            color: #991b1b;
            border-color: #fecaca;
        }
        .palette-btn.unanswered {
            background: #f8fafc;
            color: #64748b;
            border-color: #e2e8f0;
        }
        .palette-btn.current {
            outline: 2px solid var(--stu-teal);
            font-weight: 900;
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-review-container">
        
        <!-- Breadcrumb & Top Bar -->
        <div style="font-size:11px; color:#64748b; margin-bottom:12px; display:flex; justify-content:space-between; align-items:center;">
            <div>
                <a href="<%= ResolveUrl("~/Student/Quantitative.aspx") %>" style="color:#64748b; text-decoration:none;">Aptitude Practice</a> &rsaquo; 
                <a href="<%= ResolveUrl("~/Student/TestResults.aspx") %>" style="color:#64748b; text-decoration:none;">Test Results</a> &rsaquo; 
                <strong style="color:var(--stu-text);">Detailed Question Review</strong>
            </div>
            <a href="<%= ResolveUrl("~/Student/TestResults.aspx") %>" class="stu-btn-outline" style="font-size:10px; padding:4px 10px;">
                &larr; Back to Results Summary
            </a>
        </div>

        <!-- Filter Tabs -->
        <div class="student-review-filter-bar">
            <asp:LinkButton ID="btnFilterAll" runat="server" CssClass="student-filter-tab active" OnClick="Filter_Click" CommandArgument="All">
                All Questions (50)
            </asp:LinkButton>
            <asp:LinkButton ID="btnFilterIncorrect" runat="server" CssClass="student-filter-tab" OnClick="Filter_Click" CommandArgument="Incorrect">
                Incorrect (5)
            </asp:LinkButton>
            <asp:LinkButton ID="btnFilterCorrect" runat="server" CssClass="student-filter-tab" OnClick="Filter_Click" CommandArgument="Correct">
                Correct (42)
            </asp:LinkButton>
            <asp:LinkButton ID="btnFilterUnanswered" runat="server" CssClass="student-filter-tab" OnClick="Filter_Click" CommandArgument="Unanswered">
                Unanswered (3)
            </asp:LinkButton>
        </div>

        <!-- Review Grid -->
        <div class="student-review-grid">
            
            <!-- Left Pane: Question Card & Solution -->
            <div class="student-question-card">
                <div class="student-question-top">
                    <div style="display:flex; align-items:center; gap:8px;">
                        <span style="font-size:14px; font-weight:800; color:var(--stu-teal);">
                            <asp:Label ID="lblQuestionNumber" runat="server" Text="Question 34 of 50" />
                        </span>
                        <span class="difficulty-badge medium">Medium</span>
                        <span style="font-size:10px; color:#64748b; font-weight:600;">Topic: Time, Speed &amp; Distance</span>
                    </div>
                    <div>
                        <asp:Label ID="lblStatusBadge" runat="server" CssClass="student-badge-incorrect" Text="&#10007; Incorrect (Your Choice: B)" />
                    </div>
                </div>

                <!-- Question Text -->
                <div class="student-question-text">
                    <asp:Literal ID="litQuestionText" runat="server" Text="Two trains running in opposite directions cross a man standing on the platform in 27 seconds and 17 seconds respectively and they cross each other in 23 seconds. The ratio of their speeds is:" />
                </div>

                <!-- Options -->
                <div class="student-options-list">
                    <div class="student-option-box">
                        <div class="student-option-label">
                            <span class="student-option-letter">A</span>
                            <span>1 : 3</span>
                        </div>
                    </div>

                    <div class="student-option-box your-choice">
                        <div class="student-option-label">
                            <span class="student-option-letter">B</span>
                            <span>2 : 3</span>
                        </div>
                        <span style="font-size:9.5px; font-weight:800; color:#dc2626;">YOUR ANSWER</span>
                    </div>

                    <div class="student-option-box correct-choice">
                        <div class="student-option-label">
                            <span class="student-option-letter">C</span>
                            <span>3 : 2</span>
                        </div>
                        <span style="font-size:9.5px; font-weight:800; color:#059669;">&#10003; CORRECT ANSWER</span>
                    </div>

                    <div class="student-option-box">
                        <div class="student-option-label">
                            <span class="student-option-letter">D</span>
                            <span>3 : 4</span>
                        </div>
                    </div>
                </div>

                <!-- Explanation Box -->
                <div class="student-explanation-box">
                    <strong style="color:var(--stu-text); font-size:11px; display:block; margin-bottom:6px;">Step-by-Step Explanation:</strong>
                    <p style="margin:0 0 6px;">Let the speeds of the two trains be <em>x</em> m/sec and <em>y</em> m/sec respectively.</p>
                    <p style="margin:0 0 6px;">Then, length of the first train = <strong>27x</strong> meters, and length of the second train = <strong>17y</strong> meters.</p>
                    <p style="margin:0 0 6px;">When crossing each other in opposite directions, relative speed = <em>(x + y)</em> m/sec.</p>
                    <p style="margin:0 0 6px;">Total distance = 27x + 17y. Time taken = 23 seconds.</p>
                    <p style="margin:0; font-family:Consolas, monospace; background:#fff; padding:6px 10px; border-radius:4px; border:1px solid #e2e8f0; display:inline-block;">
                        (27x + 17y) / (x + y) = 23  &rArr;  27x + 17y = 23x + 23y  &rArr;  4x = 6y  &rArr;  x/y = 3/2
                    </p>
                </div>

                <!-- Shortcut Tip -->
                <div class="student-shortcut-tip">
                    <strong style="display:block; margin-bottom:2px;">&#9889; Speed Shortcut (Alligation Rule):</strong>
                    You can solve this in under 15 seconds using alligation on times: 
                    <br />
                    Train 1 (27) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Train 2 (17)
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mean Time: 23
                    <br />
                    Difference: (23 - 17) = 6 &nbsp;&nbsp;&nbsp;&nbsp; (27 - 23) = 4 &nbsp;&rArr;&nbsp; Ratio = 6 : 4 = <strong>3 : 2</strong>.
                </div>

                <!-- Bottom Navigation within Questions -->
                <div class="student-question-nav">
                    <asp:Button ID="btnPrevQuestion" runat="server" CssClass="stu-btn-outline" Text="&larr; Previous Question" OnClick="btnPrevQuestion_Click" />
                    <span style="font-size:10px; color:#64748b;">Time Spent: <strong style="color:var(--stu-text);">4m 32s</strong> (Benchmark: 1m 15s)</span>
                    <asp:Button ID="btnNextQuestion" runat="server" CssClass="stu-btn-primary" Text="Next Question &rarr;" OnClick="btnNextQuestion_Click" />
                </div>
            </div>

            <!-- Right Pane: Question Palette & Performance Summary -->
            <div style="display:flex; flex-direction:column; gap:16px;">
                
                <!-- Palette Card -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
                            <span>Question Palette</span>
                        </h3>
                        <span style="font-size:10px; color:#64748b;">50 Questions</span>
                    </div>

                    <div style="display:flex; gap:12px; font-size:9.5px; color:#64748b; margin-bottom:6px;">
                        <span><i class="breakdown-dot-correct"></i> 42 Correct</span>
                        <span><i class="breakdown-dot-incorrect"></i> 5 Incorrect</span>
                        <span><i class="breakdown-dot-unanswered"></i> 3 Skipped</span>
                    </div>

                    <!-- Question Numbers Grid (1 to 25 sample display) -->
                    <div class="palette-grid">
                        <asp:Repeater ID="rptQuestionPalette" runat="server">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkPaletteNum" runat="server" 
                                    CssClass='<%# "palette-btn " + Eval("StatusClass") + (Eval("IsCurrent").ToString() == "True" ? " current" : "") %>'
                                    CommandArgument='<%# Eval("Number") %>'
                                    OnClick="PaletteItem_Click">
                                    <%# Eval("Number") %>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <!-- Review Insights -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>
                            <span>Review Takeaway</span>
                        </h3>
                    </div>
                    <p style="font-size:10px; color:#556260; line-height:1.5; margin:0 0 10px;">
                        Your main reason for errors in this test was <strong>time over-allocation</strong> on multi-variable word problems. Applying alligation and ratio shortcuts will save ~10 minutes overall.
                    </p>
                    <a href="<%= ResolveUrl("~/Student/Quantitative.aspx") %>" class="stu-btn-outline" style="width:100%; text-align:center; box-sizing:border-box;">
                        Return to Practice Dashboard
                    </a>
                </div>

            </div>

        </div>

    </div>
</asp:Content>
