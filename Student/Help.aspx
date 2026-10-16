<%@ Page Title="Help Center" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="Help.aspx.cs"
    Inherits="PlacementPrep.Help" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Help Center &amp; Support | Placement Prep</title>
    <script type="text/javascript">
        function toggleFaq(item) {
            var answer = item.nextElementSibling;
            var icon = item.querySelector('.faq-icon');
            if (answer) {
                var isShown = answer.classList.contains('show');
                answer.classList.toggle('show');
                if (icon) {
                    icon.innerHTML = isShown ? "+" : "&minus;";
                }
            }
        }
    </script>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-help-container">
        
        <!-- Hero Search Section -->
        <div class="help-hero-search">
            <span class="ai-engine-badge" style="background:rgba(255,255,255,0.2); color:#fff; border-color:rgba(255,255,255,0.3); margin-bottom:8px;">
                <span class="engine-pulse" style="background:#fff;"></span>
                <span>STUDENT SUPPORT &bull; KNOWLEDGE BASE</span>
            </span>
            <h1 style="font-size:24px; font-weight:800; margin:0 0 6px; letter-spacing:-0.5px;">How can we help your placement preparation?</h1>
            <p style="margin:0; font-size:12px; opacity:0.9;">
                Search guides, diagnostic test instructions, coding editor troubleshooting, or raise a support ticket.
            </p>

            <div class="help-search-input-wrap">
                <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="#64748b" stroke-width="2" style="margin-right:6px;"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
                <input type="text" placeholder="Search FAQs, test submission guides, compiler rules..." />
            </div>
        </div>

        <!-- Help Category Cards -->
        <div class="help-category-grid">
            <div class="help-cat-card" onclick="location.href='<%= ResolveUrl("~/Student/Quantitative.aspx") %>';">
                <div class="help-cat-icon">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="3" width="16" height="18" rx="2"/><path d="M8 7h8M8 11h2m4 0h2M8 15h2m4 0h2M8 18h2m4 0h2"/></svg>
                </div>
                <strong style="font-size:12px; display:block; margin-bottom:2px;">Aptitude &amp; Tests</strong>
                <small style="color:#64748b; font-size:10px;">Test guidelines, timer rules &amp; scoring</small>
            </div>

            <div class="help-cat-card" onclick="location.href='<%= ResolveUrl("~/Student/CodingProblems.aspx") %>';">
                <div class="help-cat-icon" style="background:#e0f2fe; color:#0369a1;">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="15" rx="2"/><path d="m8 9-3 3 3 2m4 0 3-5m-9 12h10"/></svg>
                </div>
                <strong style="font-size:12px; display:block; margin-bottom:2px;">Coding Sandbox</strong>
                <small style="color:#64748b; font-size:10px;">Language versions, limits &amp; test cases</small>
            </div>

            <div class="help-cat-card" onclick="location.href='<%= ResolveUrl("~/Student/InterviewPrep.aspx") %>';">
                <div class="help-cat-icon" style="background:#fef3c7; color:#b45309;">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="7" width="16" height="13" rx="3"/><path d="M9 7V5a3 3 0 0 1 6 0v2m-3 5v3"/></svg>
                </div>
                <strong style="font-size:12px; display:block; margin-bottom:2px;">Mock Interviews</strong>
                <small style="color:#64748b; font-size:10px;">Audio/video setup &amp; STAR rubric</small>
            </div>

            <div class="help-cat-card" onclick="location.href='<%= ResolveUrl("~/Student/ResumeAnalyzer.aspx") %>';">
                <div class="help-cat-icon" style="background:#ede9fe; color:#6d28d9;">
                    <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></svg>
                </div>
                <strong style="font-size:12px; display:block; margin-bottom:2px;">Resume Analyzer</strong>
                <small style="color:#64748b; font-size:10px;">ATS scoring &amp; role matching</small>
            </div>
        </div>

        <!-- Split Layout: FAQs & Support Ticket Form -->
        <div class="help-split-layout">
            
            <!-- Left: FAQs Accordion -->
            <div style="display:flex; flex-direction:column; gap:16px;">
                
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="10"/><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
                            <span>Frequently Asked Questions</span>
                        </h3>
                        <span class="student-pill-count">Common Queries</span>
                    </div>

                    <div class="faq-accordion">
                        
                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFaq(this);">
                                <span>How is my Placement Readiness Score calculated?</span>
                                <span class="faq-icon" style="font-size:14px; font-weight:800; color:var(--stu-teal);">&minus;</span>
                            </div>
                            <div class="faq-answer show">
                                Your Placement Readiness Score (0-100) is an aggregate composite weighted across:
                                Quantitative &amp; Logical Aptitude tests (35%), Algorithmic Code Quality and Acceptance (35%), and Mock Technical Interview STAR Evaluations (30%).
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFaq(this);">
                                <span>Can I retake full-length company mock tests (e.g. TCS NQT, Infosys)?</span>
                                <span class="faq-icon" style="font-size:14px; font-weight:800; color:var(--stu-teal);">+</span>
                            </div>
                            <div class="faq-answer">
                                Yes. You can attempt each mock test multiple times. Your latest attempt and your highest percentile score are both preserved in your Diagnostic History for comprehensive progression tracking.
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFaq(this);">
                                <span>What programming languages are supported in the Code Editor?</span>
                                <span class="faq-icon" style="font-size:14px; font-weight:800; color:var(--stu-teal);">+</span>
                            </div>
                            <div class="faq-answer">
                                The Code Editor supports C# (.NET), C++ (GCC 11), Java (OpenJDK 17), Python 3.10, and JavaScript (Node.js). In student simulation mode, testcase assertions are validated locally in your browser session.
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFaq(this);">
                                <span>What file formats does the AI Resume Analyzer accept?</span>
                                <span class="faq-icon" style="font-size:14px; font-weight:800; color:var(--stu-teal);">+</span>
                            </div>
                            <div class="faq-answer">
                                We accept PDF (.pdf), Microsoft Word (.docx), and Legacy Word (.doc) formats up to 5 MB. Ensure text is selectable (not scanned images) for optimal optical character recognition.
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question" onclick="toggleFaq(this);">
                                <span>How do live faculty doubt-clearing sessions operate?</span>
                                <span class="faq-icon" style="font-size:14px; font-weight:800; color:var(--stu-teal);">+</span>
                            </div>
                            <div class="faq-answer">
                                Daily drop-in sessions run from 4:00 PM to 5:30 PM (Mon-Fri). You can join using the virtual room link below or raise a ticket to request dedicated 1-on-1 mentor guidance.
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Live Drop-in Session Schedule (Sample Data) -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                            <span>Live Faculty Drop-in Doubt Desk</span>
                        </h3>
                        <span class="ai-engine-badge">Schedule</span>
                    </div>

                    <div style="display:flex; flex-direction:column; gap:8px; font-size:11px;">
                        <div style="display:flex; align-items:center; justify-content:space-between; padding:8px 12px; background:#f8fafc; border-radius:6px;">
                            <div>
                                <strong>DSA &amp; Competitive Programming Desk</strong><br />
                                <small style="color:#64748b;">Mon &bull; Wed &bull; Fri &bull; 04:00 PM - 05:30 PM (Lab 402 / Zoom)</small>
                            </div>
                            <span class="student-badge-correct">&#10003; Active Today</span>
                        </div>

                        <div style="display:flex; align-items:center; justify-content:space-between; padding:8px 12px; background:#f8fafc; border-radius:6px;">
                            <div>
                                <strong>System Design &amp; Resume Mentorship</strong><br />
                                <small style="color:#64748b;">Tuesday &bull; Thursday &bull; 05:00 PM - 06:30 PM (Conference Hall B)</small>
                            </div>
                            <span class="student-pill-count">Upcoming Tomorrow</span>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Right: Support Ticket Form -->
            <div class="student-extracted-card">
                <div class="student-extracted-card-header">
                    <h3>
                        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                        <span>Submit a Support Ticket</span>
                    </h3>
                </div>
                <p style="margin:0 0 14px; font-size:10.5px; color:#556260; line-height:1.5;">
                    Need assistance with test anomalies, account verification, or specialized placement prep? Fill out the form below.
                </p>

                <!-- Feedback Panel -->
                <asp:Panel ID="pnlTicketNotice" runat="server" Visible="false" CssClass="stu-alert success" style="margin-bottom:12px; padding:10px 12px; border-radius:6px; background:#ecfdf5; border:1px solid #a7f3d0; color:#065f46; font-size:10.5px;">
                    <asp:Literal ID="litTicketNotice" runat="server" />
                </asp:Panel>

                <div style="display:flex; flex-direction:column; gap:12px;">
                    
                    <div class="form-field-group">
                        <label>Category <span style="color:#dc2626;">*</span></label>
                        <asp:DropDownList ID="ddlTicketCategory" runat="server" CssClass="stu-input">
                            <asp:ListItem Value="" Selected="True">-- Select Issue Category --</asp:ListItem>
                            <asp:ListItem Value="Aptitude Tests">Aptitude &amp; Mock Tests</asp:ListItem>
                            <asp:ListItem Value="Code Sandbox">Coding Sandbox &amp; Compiler</asp:ListItem>
                            <asp:ListItem Value="Interview Simulation">AI Mock Interview Sessions</asp:ListItem>
                            <asp:ListItem Value="Resume Analyzer">Resume Parsing &amp; ATS</asp:ListItem>
                            <asp:ListItem Value="Account Settings">Account &amp; Profile</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlTicketCategory" InitialValue="" ErrorMessage="Please select a category." CssClass="validator-error" Display="Dynamic" ValidationGroup="vgSupport" />
                    </div>

                    <div class="form-field-group">
                        <label>Priority <span style="color:#dc2626;">*</span></label>
                        <asp:DropDownList ID="ddlTicketPriority" runat="server" CssClass="stu-input">
                            <asp:ListItem Value="Low">Low - General Inquiry</asp:ListItem>
                            <asp:ListItem Value="Medium" Selected="True">Medium - Feedback / Minor Bug</asp:ListItem>
                            <asp:ListItem Value="High">High - Test Submission Issue</asp:ListItem>
                            <asp:ListItem Value="Urgent">Urgent - Drive Placement Emergency</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-field-group">
                        <label>Subject <span style="color:#dc2626;">*</span></label>
                        <asp:TextBox ID="txtTicketSubject" runat="server" CssClass="stu-input" placeholder="e.g. Two Sum submission timeout error" MaxLength="100" />
                        <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtTicketSubject" ErrorMessage="Subject line is required." CssClass="validator-error" Display="Dynamic" ValidationGroup="vgSupport" />
                    </div>

                    <div class="form-field-group">
                        <label>Description &amp; Details <span style="color:#dc2626;">*</span></label>
                        <asp:TextBox ID="txtTicketMessage" runat="server" TextMode="MultiLine" Rows="4" CssClass="stu-input" style="height:auto; min-height:80px; padding:8px 10px;" placeholder="Describe what occurred, test set name, or question number..." />
                        <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtTicketMessage" ErrorMessage="Please provide a brief description." CssClass="validator-error" Display="Dynamic" ValidationGroup="vgSupport" />
                    </div>

                    <div style="margin-top:6px;">
                        <asp:Button ID="btnSubmitTicket" runat="server" Text="Submit Ticket &rarr;" CssClass="stu-btn-primary" OnClick="btnSubmitTicket_Click" ValidationGroup="vgSupport" style="width:100%; text-align:center; box-sizing:border-box;" />
                    </div>

                </div>
            </div>

        </div>

    </div>
</asp:Content>
