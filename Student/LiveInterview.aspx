<%@ Page Title="Live Interview Session" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="LiveInterview.aspx.cs"
    Inherits="PlacementPrep.LiveInterview" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Live Interview Session | Placement Prep</title>
    <script type="text/javascript">
        var isSessionEnded = false;

        function toggleMic(btn) {
            btn.classList.toggle('muted');
            var isMuted = btn.classList.contains('muted');
            btn.title = isMuted ? "Unmute Microphone" : "Mute Microphone";
            var label = document.getElementById("mic-status-label");
            if (label) label.innerText = isMuted ? "MUTED" : "MIC ON";
        }

        function toggleCamera(btn) {
            btn.classList.toggle('muted');
            var isOff = btn.classList.contains('muted');
            btn.title = isOff ? "Turn Camera On" : "Turn Camera Off";
            var camBox = document.getElementById("candidate-cam-display");
            var label = document.getElementById("cam-status-label");
            if (camBox) {
                camBox.style.opacity = isOff ? "0.3" : "1";
            }
            if (label) label.innerText = isOff ? "CAM OFF" : "HD 720p";
        }

        function toggleSpeaker(btn) {
            btn.classList.toggle('muted');
            btn.title = btn.classList.contains('muted') ? "Unmute Speaker" : "Mute Speaker";
        }

        function endInterviewSession() {
            if (isSessionEnded) {
                openEvaluationModal();
                return;
            }
            isSessionEnded = true;

            // 1. Update Video Stage
            var interviewerCard = document.getElementById("interviewer-video-card");
            if (interviewerCard) interviewerCard.classList.add("concluded");
            var candidateCard = document.getElementById("candidate-cam-display");
            if (candidateCard) candidateCard.classList.add("concluded");

            var interviewerStatus = document.getElementById("interviewer-status-label");
            if (interviewerStatus) interviewerStatus.innerText = "SESSION CONCLUDED";

            var camStatus = document.getElementById("cam-status-label");
            if (camStatus) camStatus.innerText = "FEED STOPPED";

            // 2. Update Stage Tracker
            var trackerBadge = document.getElementById("stage-tracker-badge");
            if (trackerBadge) {
                trackerBadge.innerHTML = '<span style="width:6px; height:6px; border-radius:50%; background:#10b981; display:inline-block;"></span> <span>EVALUATION COMPLETED &bull; SESSION #4</span>';
            }

            var stageProgression = document.getElementById("stage-progression-bar");
            if (stageProgression) {
                stageProgression.innerHTML = 
                    '<span class="stage-pill" style="background:#ecfdf5; color:#065f46;">&#10003; 1. Intro</span>' +
                    '<span class="stage-pill" style="background:#ecfdf5; color:#065f46;">&#10003; 2. Algorithms</span>' +
                    '<span class="stage-pill" style="background:#ecfdf5; color:#065f46;">&#10003; 3. Architecture</span>' +
                    '<span class="stage-pill current" style="background:#08796e; color:#fff; border-color:#08796e;">&#10003; 4. Wrap-up</span>';
            }

            var timerLabel = document.getElementById("session-elapsed-timer");
            if (timerLabel) {
                timerLabel.innerHTML = 'Elapsed: <strong style="color:#059669;">18:45 (Completed)</strong> / 45:00';
            }

            // 3. Update Controls Bar
            var liveActions = document.getElementById("live-call-actions");
            var endedActions = document.getElementById("ended-call-actions");
            if (liveActions) liveActions.style.display = "none";
            if (endedActions) endedActions.style.display = "flex";

            // 4. Append Interviewer Wrap-up to Live Transcript
            var transcriptPanel = document.getElementById("live-transcript-panel");
            if (transcriptPanel && !document.getElementById("wrapup-bubble")) {
                var bubble = document.createElement("div");
                bubble.id = "wrapup-bubble";
                bubble.className = "transcript-bubble interviewer";
                bubble.style.borderLeft = "3px solid #08796e";
                bubble.innerHTML = 
                    '<small style="font-size:9.5px; font-weight:700; color:#08796e;">Dr. Sarah Chen &bull; 18:45 (Simulation Wrap-Up)</small>' +
                    '<div class="transcript-text" style="color:#0f172a; font-weight:500;">' +
                    'Thank you for walking through your approach! That concludes all 4 technical stages. Your code complexity proofs, communication clarity, and problem decomposition have been synthesized into your evaluation report.' +
                    '</div>';
                transcriptPanel.appendChild(bubble);
                transcriptPanel.scrollTop = transcriptPanel.scrollHeight;
            }

            // 5. Open In-Interview Performance Evaluation Modal
            openEvaluationModal();
        }

        function openEvaluationModal() {
            var modal = document.getElementById("interviewEvaluationModal");
            if (modal) modal.classList.add("show");
        }

        function closeEvaluationModal() {
            var modal = document.getElementById("interviewEvaluationModal");
            if (modal) modal.classList.remove("show");
        }

        function restartInterviewSession() {
            window.location.href = window.location.pathname;
        }

        document.addEventListener("DOMContentLoaded", function () {
            var params = new URLSearchParams(window.location.search);
            if (params.get("completed") === "1" || params.get("ended") === "1") {
                endInterviewSession();
            }
        });
    </script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-live-container">
        
        <!-- Live Stage Progress Bar -->
        <div class="live-stage-tracker">
            <div style="display:flex; align-items:center; gap:10px;">
                <span class="ai-engine-badge" id="stage-tracker-badge">
                    <span class="engine-pulse"></span>
                    <span>LIVE SIMULATION &bull; SESSION #4</span>
                </span>
                <strong style="color:var(--stu-text); font-size:12px;">Technical Core &amp; Algorithmic Design</strong>
            </div>

            <!-- Stages Progression -->
            <div style="display:flex; align-items:center; gap:6px;" id="stage-progression-bar">
                <span class="stage-pill" style="background:#ecfdf5; color:#065f46;">&#10003; 1. Introduction</span>
                <span class="stage-pill current">&bull; 2. Algorithms &amp; Complexity</span>
                <span class="stage-pill">3. Architecture Trade-offs</span>
                <span class="stage-pill">4. Wrap-up</span>
            </div>

            <div style="font-size:11px; font-weight:700; color:#64748b;" id="session-elapsed-timer">
                Elapsed: <strong style="color:var(--stu-text);">18:45</strong> / 45:00
            </div>
        </div>

        <!-- Live Layout Grid -->
        <div class="student-live-grid">
            
            <!-- Left Pane: Video Feeds & Controls -->
            <div>
                
                <!-- Video Stage (2 feeds side by side) -->
                <div class="student-video-stage">
                    
                    <!-- Interviewer Feed -->
                    <div class="video-frame-card" id="interviewer-video-card">
                        <div class="video-status-overlay">
                            <span style="width:6px; height:6px; border-radius:50%; background:#ef4444; display:inline-block;"></span>
                            <span id="interviewer-status-label">INTERVIEWER LIVE</span>
                        </div>

                        <!-- AI Interviewer Visual -->
                        <div style="text-align:center;">
                            <div style="width:72px; height:72px; border-radius:50%; background:linear-gradient(135deg, #08796e 0%, #14b8a6 100%); margin:0 auto 10px; display:grid; place-items:center; box-shadow:0 0 0 4px rgba(20,184,166,0.25);">
                                <svg viewBox="0 0 24 24" width="36" height="36" fill="none" stroke="#fff" stroke-width="1.8"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                            </div>
                            <div style="font-size:12px; font-weight:700; color:#f8fafc;">Dr. Sarah Chen</div>
                            <small style="color:#94a3b8; font-size:9.5px;">AI Technical Hiring Lead</small>
                        </div>

                        <div class="video-name-tag">Interviewer: Dr. Sarah Chen</div>
                        <div class="speaking-pulse" title="Voice activity detected">
                            <span style="height:6px;"></span>
                            <span style="height:14px;"></span>
                            <span style="height:10px;"></span>
                            <span style="height:12px;"></span>
                        </div>
                    </div>

                    <!-- Candidate Feed (You) -->
                    <div class="video-frame-card" id="candidate-cam-display">
                        <div class="video-status-overlay">
                            <span style="width:6px; height:6px; border-radius:50%; background:#10b981; display:inline-block;"></span>
                            <span id="cam-status-label">HD 720p</span>
                        </div>

                        <!-- Candidate Placeholder Visual -->
                        <div style="text-align:center;">
                            <div style="width:72px; height:72px; border-radius:50%; background:#334155; margin:0 auto 10px; display:grid; place-items:center; border:2px solid #475569;">
                                <svg viewBox="0 0 24 24" width="36" height="36" fill="none" stroke="#94a3b8" stroke-width="1.8"><circle cx="12" cy="8" r="4"/><path d="M5 20a7 7 0 0 1 14 0"/></svg>
                            </div>
                            <div style="font-size:12px; font-weight:700; color:#f8fafc;">Candidate Self-View</div>
                            <small style="color:#94a3b8; font-size:9.5px;" id="mic-status-label">MIC ON</small>
                        </div>

                        <div class="video-name-tag">You (Candidate)</div>
                    </div>

                </div>

                <!-- Controls Bar -->
                <div class="live-controls-bar">
                    <div style="display:flex; align-items:center; gap:10px;">
                        <!-- Microphone button -->
                        <button type="button" class="control-btn" onclick="toggleMic(this);" title="Mute/Unmute Mic" id="btnMic">
                            <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 1a3 3 0 0 0-3 3v8a3 3 0 0 0 6 0V4a3 3 0 0 0-3-3z"/><path d="M19 10v2a7 7 0 0 1-14 0v-2"/><line x1="12" y1="19" x2="12" y2="23"/><line x1="8" y1="23" x2="16" y2="23"/></svg>
                        </button>

                        <!-- Camera button -->
                        <button type="button" class="control-btn" onclick="toggleCamera(this);" title="Camera On/Off" id="btnCamera">
                            <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M23 7l-7 5 7 5V7z"/><rect x="1" y="5" width="15" height="14" rx="2" ry="2"/></svg>
                        </button>

                        <!-- Speaker button -->
                        <button type="button" class="control-btn" onclick="toggleSpeaker(this);" title="Mute/Unmute Speaker" id="btnSpeaker">
                            <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><polygon points="11 5 6 9 2 9 2 15 6 15 11 19 11 5"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14M15.54 8.46a5 5 0 0 1 0 7.07"/></svg>
                        </button>
                    </div>

                    <!-- Live Call Actions (Active State) -->
                    <div id="live-call-actions" style="display:flex; align-items:center; gap:8px;">
                        <button type="button" class="btn-end-call" onclick="endInterviewSession();" id="btnEndCall" title="Conclude interview session in this studio">
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><path d="M10.68 13.31a16 16 0 0 0 3.41 2.6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7 2 2 0 0 1 1.72 2v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.42 19.42 0 0 1-6-6 19.8 19.8 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91"/></svg>
                            <span>End Interview</span>
                        </button>
                    </div>

                    <!-- Post-End Call Actions (Shown once interview ends) -->
                    <div id="ended-call-actions" style="display:none; align-items:center; gap:8px;">
                        <span class="interview-concluded-badge">&#10003; Session Concluded</span>
                        <button type="button" class="btn-interview-summary" onclick="openEvaluationModal();">
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                            <span>View Evaluation</span>
                        </button>
                        <a href="<%= ResolveUrl("~/Student/InterviewPrep.aspx") %>" class="stu-btn-outline" style="font-size:11px; padding:6px 12px; text-decoration:none;">
                            &larr; Exit to Studio
                        </a>
                    </div>
                </div>

                <!-- Candidate Scratch Notes Panel -->
                <div class="student-extracted-card" style="margin-top:14px;">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></svg>
                            <span>Candidate Scratchpad &amp; Notes</span>
                        </h3>
                        <span style="font-size:9.5px; color:#64748b;">Auto-saved during session</span>
                    </div>
                    <asp:TextBox ID="txtCandidateNotes" runat="server" TextMode="MultiLine" Rows="4" CssClass="student-ide-editor" style="background:#f8fafc; color:#334155; border:1px solid #e2e8f0; border-radius:6px; min-height:80px;" placeholder="Jot down complexity calculations, algorithm steps, or questions for interviewer..." Text="Floyd's Cycle Detection:
- Slow ptr: 1 step
- Fast ptr: 2 steps
- Meeting point proves cycle.
- Time: O(N), Space: O(1)" />
                </div>

            </div>

            <!-- Right Pane: Real-Time Scoring Metrics & Live Transcript -->
            <div style="display:flex; flex-direction:column; gap:14px;">
                
                <!-- Live Real-Time Scoring Metrics (Identified Demo Data) -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                            <span>Live Evaluation Metrics</span>
                        </h3>
                        <span class="ai-engine-badge">Demo Feed</span>
                    </div>

                    <div style="display:grid; grid-template-columns:1fr 1fr; gap:10px;">
                        <div class="vocal-card">
                            <small>Technical Accuracy</small>
                            <strong style="color:#059669;">88%</strong>
                        </div>
                        <div class="vocal-card">
                            <small>Speaking Pace</small>
                            <strong style="color:var(--stu-teal);">138 wpm</strong>
                        </div>
                        <div class="vocal-card">
                            <small>Key Concepts Matched</small>
                            <strong style="color:#059669;">8 / 10</strong>
                        </div>
                        <div class="vocal-card">
                            <small>Clarity &amp; Delivery</small>
                            <strong style="color:var(--stu-teal);">High</strong>
                        </div>
                    </div>
                </div>

                <!-- Live Conversation Transcript Panel -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                            <span>Live Transcript Stream</span>
                        </h3>
                        <span style="font-size:9.5px; color:#10b981; font-weight:700;">● Active Stream</span>
                    </div>

                    <div class="student-transcript-panel" id="live-transcript-panel">
                        <!-- Turn 1: Interviewer -->
                        <div class="transcript-bubble interviewer">
                            <small style="font-size:9.5px; font-weight:700; color:#64748b;">Dr. Sarah Chen &bull; 14:10</small>
                            <div class="transcript-text">
                                Welcome! Let's explore foundational data structures. How would you detect a cycle in a singly linked list without allocating auxiliary heap memory?
                            </div>
                        </div>

                        <!-- Turn 2: Candidate -->
                        <div class="transcript-bubble candidate">
                            <small style="font-size:9.5px; font-weight:700; color:rgba(255,255,255,0.8); text-align:right;">You (Candidate) &bull; 14:32</small>
                            <div class="transcript-text">
                                I would apply Floyd's Cycle-Finding Algorithm, also known as the Tortoise and Hare approach. We initialize two pointers: slow advancing by 1 step, and fast advancing by 2 steps. If they ever point to the identical memory address, a cycle is present.
                            </div>
                        </div>

                        <!-- Turn 3: Interviewer -->
                        <div class="transcript-bubble interviewer">
                            <small style="font-size:9.5px; font-weight:700; color:#64748b;">Dr. Sarah Chen &bull; 15:04</small>
                            <div class="transcript-text">
                                Excellent. What is the time complexity when the cycle length is k, and what happens to the auxiliary space?
                            </div>
                        </div>

                        <!-- Turn 4: Candidate -->
                        <div class="transcript-bubble candidate">
                            <small style="font-size:9.5px; font-weight:700; color:rgba(255,255,255,0.8); text-align:right;">You (Candidate) &bull; 15:40</small>
                            <div class="transcript-text">
                                The time complexity remains bounded by O(N), because once the slow pointer enters the cycle, the fast pointer closes the gap by 1 node per iteration, taking at most k steps. Auxiliary space is strictly O(1) since only two pointer references are allocated.
                            </div>
                        </div>

                        <!-- Turn 5: Interviewer -->
                        <div class="transcript-bubble interviewer">
                            <small style="font-size:9.5px; font-weight:700; color:#64748b;">Dr. Sarah Chen &bull; 16:15</small>
                            <div class="transcript-text">
                                Spot on explanation. Now, let's transition to Stage 3: How would you architect a distributed caching layer with Redis?
                            </div>
                        </div>
                    </div>

                    <div style="font-size:9px; color:#64748b; padding-top:8px; border-top:1px solid #f1f2f8; text-align:center;">
                        Simulation Mode Notice: Audio/video controls and transcript data run in interactive browser demonstration mode.
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- In-Interview AI Performance Evaluation Modal -->
    <div id="interviewEvaluationModal" class="interview-modal-backdrop">
        <div class="interview-modal-card">
            <button type="button" class="interview-modal-close" onclick="closeEvaluationModal();" title="Close and review transcript">&times;</button>
            
            <div style="display:flex; align-items:center; gap:8px; margin-bottom:8px;">
                <span class="ai-engine-badge" style="background:#ecfdf5; color:#065f46; border-color:#a7f3d0;">
                    &#10003; AI EVALUATION COMPLETE &bull; V4.2
                </span>
                <span style="font-size:11px; color:#64748b;">Session #4 &bull; Duration: 18:45</span>
            </div>

            <!-- Banner Header -->
            <div style="display:flex; justify-content:space-between; align-items:center; gap:16px; padding-bottom:16px; border-bottom:1px solid #e2e8f0; margin-bottom:18px;">
                <div>
                    <h2 style="font-size:18px; font-weight:800; margin:0 0 4px; color:var(--stu-text);">
                        Technical Core Simulation Report
                    </h2>
                    <p style="margin:0; font-size:11.5px; color:#64748b; line-height:1.5;">
                        Dr. Sarah Chen (AI Technical Hiring Lead) has evaluated your interview performance.
                    </p>
                </div>
                <div style="display:flex; align-items:center; gap:10px;">
                    <div style="width:70px; height:70px; border-radius:50%; background:linear-gradient(135deg, #08796e 0%, #14b8a6 100%); display:flex; flex-direction:column; align-items:center; justify-content:center; color:#fff; box-shadow:0 4px 14px rgba(8,121,110,0.25);">
                        <strong style="font-size:18px; font-weight:800; line-height:1;">88%</strong>
                        <small style="font-size:8px; font-weight:700; opacity:0.9;">STRONG HIRE</small>
                    </div>
                </div>
            </div>

            <!-- Lead Evaluator Verdict -->
            <div style="background:#f0fdf9; border:1px solid #8fe3d2; border-radius:8px; padding:12px 14px; margin-bottom:16px;">
                <div style="font-size:11px; font-weight:700; color:var(--stu-teal); margin-bottom:4px; display:flex; align-items:center; gap:6px;">
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M12 16v-4m0-4h.01"/></svg>
                    <span>Lead Evaluator Remarks &bull; Dr. Sarah Chen</span>
                </div>
                <p style="margin:0; font-size:11px; color:#334155; line-height:1.5;">
                    "Candidate articulated Floyd's Cycle Detection flawlessly, explaining pointer velocities and proving O(1) space constraints with precision. Solid grasp of algorithmic trade-offs. Ready for company final rounds."
                </p>
            </div>

            <!-- Rubrics Grid -->
            <div style="display:grid; grid-template-columns:repeat(4, 1fr); gap:10px; margin-bottom:18px;">
                <div class="vocal-card" style="border:1px solid #e2e8f0; background:#f8fafc;">
                    <small>Technical Accuracy</small>
                    <strong style="color:#059669; font-size:15px;">88%</strong>
                    <span style="font-size:9px; color:#059669; font-weight:600;">High Tier</span>
                </div>
                <div class="vocal-card" style="border:1px solid #e2e8f0; background:#f8fafc;">
                    <small>STAR Framework</small>
                    <strong style="color:var(--stu-teal); font-size:15px;">86%</strong>
                    <span style="font-size:9px; color:var(--stu-teal); font-weight:600;">Structured</span>
                </div>
                <div class="vocal-card" style="border:1px solid #e2e8f0; background:#f8fafc;">
                    <small>Speaking Pace</small>
                    <strong style="color:var(--stu-teal); font-size:15px;">138 wpm</strong>
                    <span style="font-size:9px; color:#059669; font-weight:600;">Optimal (130-150)</span>
                </div>
                <div class="vocal-card" style="border:1px solid #e2e8f0; background:#f8fafc;">
                    <small>Core Concepts</small>
                    <strong style="color:#059669; font-size:15px;">8 / 10</strong>
                    <span style="font-size:9px; color:#059669; font-weight:600;">Validated</span>
                </div>
            </div>

            <!-- Strengths and Areas of Improvement -->
            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px; margin-bottom:20px;">
                <div style="background:#f8fafc; border:1px solid #e2e8f0; border-radius:8px; padding:12px;">
                    <strong style="color:#059669; font-size:11px; display:flex; align-items:center; gap:4px; margin-bottom:4px;">
                        &#10003; Key Demonstrated Strengths
                    </strong>
                    <ul style="margin:0; padding-left:16px; font-size:10.5px; color:#475569; line-height:1.5;">
                        <li>Proven mastery of cycle detection algorithm principles</li>
                        <li>Exact Big-O time (O(N)) and space (O(1)) explanation</li>
                        <li>Calm, structured response delivery without excessive fillers</li>
                    </ul>
                </div>

                <div style="background:#f8fafc; border:1px solid #e2e8f0; border-radius:8px; padding:12px;">
                    <strong style="color:#d97706; font-size:11px; display:flex; align-items:center; gap:4px; margin-bottom:4px;">
                        &#9888; Recommended Focus Areas
                    </strong>
                    <ul style="margin:0; padding-left:16px; font-size:10.5px; color:#475569; line-height:1.5;">
                        <li>Elaborate on Redis Redlock distributed synchronization</li>
                        <li>Spend 15-30 seconds outlining edge cases before coding</li>
                    </ul>
                </div>
            </div>

            <!-- Modal Action Buttons -->
            <div style="display:flex; justify-content:space-between; align-items:center; padding-top:14px; border-top:1px solid #f1f2f8; flex-wrap:wrap; gap:10px;">
                <button type="button" class="stu-btn-outline" onclick="closeEvaluationModal();" style="font-size:11px; padding:7px 14px;">
                    Review Live Transcript &amp; Notes
                </button>
                <div style="display:flex; align-items:center; gap:8px;">
                    <button type="button" class="btn-interview-restart" onclick="restartInterviewSession();">
                        &#8635; Restart Simulation
                    </button>
                    <a href="<%= ResolveUrl("~/Student/InterviewPrep.aspx") %>" class="stu-btn-primary" style="font-size:11px; padding:7px 16px; text-decoration:none;">
                        &larr; Return to Interview Studio
                    </a>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
