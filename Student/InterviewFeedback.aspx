<%@ Page Title="Interview Feedback Report" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="InterviewFeedback.aspx.cs"
    Inherits="PlacementPrep.InterviewFeedback" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Interview Feedback Report | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-report-container">
        
        <!-- Breadcrumb & Top Bar -->
        <div style="font-size:11px; color:#64748b; margin-bottom:12px; display:flex; justify-content:space-between; align-items:center;">
            <div>
                <a href="<%= ResolveUrl("~/Student/InterviewPrep.aspx") %>" style="color:#64748b; text-decoration:none;">Interview Prep</a> &rsaquo; 
                <span style="color:#64748b;">Evaluation Archive</span> &rsaquo; 
                <strong style="color:var(--stu-text);">Technical Core Mock #4 Evaluation</strong>
            </div>
            <div style="display:flex; gap:8px;">
                <button type="button" class="stu-btn-outline" onclick="window.print();" style="font-size:10px; padding:4px 10px;">
                    <svg viewBox="0 0 24 24" width="12" height="12" fill="none" stroke="currentColor" stroke-width="1.8" style="vertical-align:middle; margin-right:4px;"><polyline points="6 9 6 2 18 2 18 9"/><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/><rect x="6" y="14" width="12" height="8"/></svg>
                    Download Report
                </button>
                <a href="<%= ResolveUrl("~/Student/InterviewPrep.aspx") %>" class="stu-btn-primary" style="font-size:10px; padding:4px 12px; text-decoration:none;">
                    Schedule Next Session &rarr;
                </a>
            </div>
        </div>

        <!-- Session Banner Summary -->
        <section class="student-results-banner">
            <div class="student-results-header">
                <span class="student-badge-correct" style="margin-bottom:6px;">&#10003; Evaluation Completed &bull; Verified by AI Evaluator v4.2</span>
                <h1 style="font-size:22px; font-weight:800; margin:0 0 4px; color:var(--stu-text);">
                    Technical Core Simulation: Stage 1-4 Report
                </h1>
                <p style="margin:0 0 12px; font-size:11.5px; color:#556260; line-height:1.5;">
                    Candidate demonstrated strong mastery in linear data structures, pointer arithmetic, and algorithmic complexity trade-offs. Recommendation: <strong>Clear to Final Interview Rounds</strong>.
                </p>

                <div style="display:flex; flex-wrap:wrap; gap:12px; font-size:11px; color:#64748b;">
                    <span>Role: <strong style="color:var(--stu-text);">Senior Frontend / Full Stack</strong></span> &bull; 
                    <span>Interviewer: <strong style="color:var(--stu-text);">Dr. Sarah Chen (AI)</strong></span> &bull; 
                    <span>Duration: <strong style="color:var(--stu-text);">45 Mins</strong></span> &bull; 
                    <span>Date: <strong style="color:var(--stu-text);">Oct 15, 2026</strong></span>
                </div>
            </div>

            <!-- Overall Score Circle -->
            <div class="student-score-circle-wrap">
                <div class="student-score-circle">
                    <strong>84%</strong>
                    <small>STRONG HIRE</small>
                </div>
            </div>
        </section>

        <!-- Split Grid: Rubrics & Accuracies -->
        <div class="student-results-split" style="margin-top:18px;">
            
            <!-- Left Column: Communication Rubric & Technical Accuracy -->
            <div style="display:flex; flex-direction:column; gap:16px;">
                
                <!-- Communication Rubric Card -->
                <div class="rubric-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                            <span>Communication &amp; Articulation Rubric</span>
                        </h3>
                        <span class="student-pill-count">Evaluation Breakdown</span>
                    </div>

                    <div class="rubric-meter">
                        <div class="rubric-meter-header">
                            <span>Structured Thinking &amp; Framework (STAR)</span>
                            <span style="color:#059669;">88% (Excellent)</span>
                        </div>
                        <div class="student-benchmark-bar"><div class="student-benchmark-fill" style="width:88%;"></div></div>
                    </div>

                    <div class="rubric-meter">
                        <div class="rubric-meter-header">
                            <span>Technical Precision &amp; Terminology</span>
                            <span style="color:#059669;">86% (High)</span>
                        </div>
                        <div class="student-benchmark-bar"><div class="student-benchmark-fill" style="width:86%;"></div></div>
                    </div>

                    <div class="rubric-meter">
                        <div class="rubric-meter-header">
                            <span>Question Inquiry &amp; Active Listening</span>
                            <span style="color:#059669;">92% (Top Tier)</span>
                        </div>
                        <div class="student-benchmark-bar"><div class="student-benchmark-fill" style="width:92%;"></div></div>
                    </div>

                    <div class="rubric-meter">
                        <div class="rubric-meter-header">
                            <span>Conciseness &amp; Filler Word Control</span>
                            <span style="color:#d97706;">78% (Room for Polish)</span>
                        </div>
                        <div class="student-benchmark-bar"><div class="student-benchmark-fill" style="width:78%; background:#f59e0b;"></div></div>
                        <small style="color:#64748b; font-size:9.5px;">Detected 4 filler word instances ("um", "you know") during Stage 2 introduction.</small>
                    </div>
                </div>

                <!-- Technical Accuracy & Problem Discussion Panel -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><polyline points="20 6 9 17 4 12"/></svg>
                            <span>Technical Accuracy &amp; Code Snippets</span>
                        </h3>
                        <span class="student-badge-correct">2/2 Questions Validated</span>
                    </div>

                    <div style="margin-bottom:14px; border-bottom:1px solid #f1f2f8; padding-bottom:12px;">
                        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:4px;">
                            <strong style="color:var(--stu-text); font-size:12px;">Q1: Linked List Cycle Detection (Floyd's Algorithm)</strong>
                            <span class="student-badge-correct">&#10003; 100% Correct</span>
                        </div>
                        <p style="font-size:11px; color:#556260; margin:0 0 6px; line-height:1.5;">
                            Candidate accurately identified that the fast pointer closes the relative distance by 1 node per iteration, guaranteeing meeting in at most <em>k</em> steps.
                        </p>
                        <div class="student-code-block" style="margin:4px 0 0;">
                            // Transcript Note:
                            "Auxiliary space is strictly O(1) since only two pointer references are allocated."
                        </div>
                    </div>

                    <div>
                        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:4px;">
                            <strong style="color:var(--stu-text); font-size:12px;">Q2: Distributed Caching Architecture (Redis)</strong>
                            <span class="difficulty-badge medium">&#9888; 82% Acceptable</span>
                        </div>
                        <p style="font-size:11px; color:#556260; margin:0; line-height:1.5;">
                            Good explanation of Cache-Aside vs Write-Through patterns. Recommendation to deepen explanation on Redlock distributed locking mechanisms.
                        </p>
                    </div>
                </div>

            </div>

            <!-- Right Column: Speaking & Vocal Metrics + Action Recommendations -->
            <div style="display:flex; flex-direction:column; gap:16px;">
                
                <!-- Speaking Pace & Vocal Sentiment -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M12 1a3 3 0 0 0-3 3v8a3 3 0 0 0 6 0V4a3 3 0 0 0-3-3z"/><path d="M19 10v2a7 7 0 0 1-14 0v-2"/><line x1="12" y1="19" x2="12" y2="23"/><line x1="8" y1="23" x2="16" y2="23"/></svg>
                            <span>Speaking Rate &amp; Vocal Sentiment</span>
                        </h3>
                        <span class="ai-engine-badge">Audio AI</span>
                    </div>

                    <div class="vocal-metric-grid">
                        <div class="vocal-card">
                            <small>Speaking Rate</small>
                            <strong style="color:var(--stu-teal);">138 wpm</strong>
                            <span style="font-size:8.5px; color:#059669; display:block; margin-top:2px;">Ideal (130-150)</span>
                        </div>
                        <div class="vocal-card">
                            <small>Vocal Sentiment</small>
                            <strong style="color:#059669;">87%</strong>
                            <span style="font-size:8.5px; color:#059669; display:block; margin-top:2px;">Positive / Confident</span>
                        </div>
                        <div class="vocal-card">
                            <small>Pitch Stability</small>
                            <strong style="color:var(--stu-teal);">94%</strong>
                            <span style="font-size:8.5px; color:#64748b; display:block; margin-top:2px;">Steady Tone</span>
                        </div>
                    </div>
                </div>

                <!-- Targeted Practice Recommendations -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                            <span>Targeted Practice Drills</span>
                        </h3>
                    </div>

                    <div style="display:flex; flex-direction:column; gap:10px;">
                        <div style="padding:10px 12px; background:#f0fdf9; border:1px solid #8fe3d2; border-radius:6px; font-size:10.5px;">
                            <strong style="color:var(--stu-teal); display:block; margin-bottom:2px;">1. Distributed Locking with Redis</strong>
                            <span style="color:#475569;">Practice answering concurrency control, lease renewal, and split-brain scenarios.</span>
                            <div style="margin-top:6px;">
                                <a href="<%= ResolveUrl("~/Student/CodingProblems.aspx") %>" style="color:var(--stu-teal); font-weight:700; text-decoration:none;">
                                    Start 15-Min Focused Drill &rarr;
                                </a>
                            </div>
                        </div>

                        <div style="padding:10px 12px; background:#f8fafc; border:1px solid #e2e8f0; border-radius:6px; font-size:10.5px;">
                            <strong style="color:var(--stu-text); display:block; margin-bottom:2px;">2. Reduce Introductory Fillers</strong>
                            <span style="color:#475569;">Pause 1-2 seconds before speaking to structure thoughts rather than filling silence with vocal fillers.</span>
                        </div>
                    </div>

                    <div style="margin-top:14px; display:flex; flex-direction:column; gap:8px;">
                        <a href="<%= ResolveUrl("~/Student/InterviewPrep.aspx") %>" class="stu-btn-primary" style="text-align:center; box-sizing:border-box;">
                            &larr; Return to Interview Studio
                        </a>
                        <a href="<%= ResolveUrl("~/Student/FeedbackHub.aspx") %>" class="stu-btn-outline" style="text-align:center; box-sizing:border-box;">
                            View Diagnostic Aggregate in Feedback Hub &rarr;
                        </a>
                    </div>
                </div>

            </div>

        </div>

    </div>
</asp:Content>
