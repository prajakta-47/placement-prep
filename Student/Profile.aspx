<%@ Page Title="Student Profile" Language="C#" MasterPageFile="~/Student.Master"
    AutoEventWireup="true" CodeBehind="Profile.aspx.cs"
    Inherits="PlacementPrep.Profile" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Student Profile | Placement Prep</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-profile-container">
        
        <!-- Profile Header Hero Card -->
        <div class="profile-hero-card">
            <div class="profile-hero-left">
                <div class="profile-avatar-large">
                    <asp:Literal ID="litProfileInitials" runat="server" Text="VP" />
                    <asp:Image ID="imgProfileAvatar" runat="server" Visible="false" CssClass="profile-avatar-img" AlternateText="Avatar" />
                </div>
                <div>
                    <div style="display:flex; align-items:center; gap:8px; margin-bottom:4px;">
                        <h1 style="font-size:22px; font-weight:800; margin:0; letter-spacing:-0.5px; color:var(--stu-text);">
                            <asp:Label ID="lblProfileName" runat="server" Text="Vishal Patil" />
                        </h1>
                        <span class="student-badge-correct">&#10003; Verified Candidate</span>
                    </div>

                    <p style="margin:0 0 8px; font-size:12px; color:#475569;">
                        Candidate ID: <strong>CS2026-084</strong> &bull; Target Role: <strong style="color:var(--stu-teal);">Full Stack / Senior Frontend Engineer</strong>
                    </p>

                    <div style="display:flex; flex-wrap:wrap; gap:12px; font-size:10.5px; color:#64748b;">
                        <span>Institute of Engineering &amp; Technology</span> &bull; 
                        <span>Class of 2026</span> &bull; 
                        <span>CGPA: <strong style="color:#059669;">8.92 / 10.0</strong></span>
                    </div>
                </div>
            </div>

            <!-- Profile Actions -->
            <div style="display:flex; align-items:center; gap:10px;">
                <a href="<%= ResolveUrl("~/Student/ResumeViewer.aspx") %>" class="stu-btn-outline" style="padding:8px 14px; font-size:11px;">
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.8" style="vertical-align:middle; margin-right:4px;"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                    View Active Resume
                </a>
                <a href="<%= ResolveUrl("~/Student/Settings.aspx") %>" class="stu-btn-primary" style="padding:8px 16px; font-size:11px;">
                    <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.8" style="vertical-align:middle; margin-right:4px;"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                    Edit Profile &rarr;
                </a>
            </div>
        </div>

        <!-- Metric Triplet Snapshot -->
        <div class="student-metric-triplet" style="margin-bottom:20px;">
            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Placement Readiness</small>
                    <strong>86 / 100 <span style="font-size:10px; color:#10b981; font-weight:700;">Top 8%</span></strong>
                </div>
            </div>

            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><rect x="3" y="4" width="18" height="15" rx="2"/><path d="m8 9-3 3 3 2m4 0 3-5m-9 12h10"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>Coding Problems Solved</small>
                    <strong>28 Solved <span style="font-size:10px; color:#64748b; font-weight:normal;">/ 150</span></strong>
                </div>
            </div>

            <div class="student-metric-card">
                <div class="student-metric-icon">
                    <svg viewBox="0 0 24 24"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                </div>
                <div class="student-metric-data">
                    <small>ATS Resume Score</small>
                    <strong>88% <span style="font-size:10px; color:#10b981; font-weight:700;">Role Optimized</span></strong>
                </div>
            </div>
        </div>

        <!-- Profile Details 2-Column Grid -->
        <div class="profile-details-grid">
            
            <!-- Left Column: Education & Project Portfolio -->
            <div style="display:flex; flex-direction:column; gap:16px;">
                
                <!-- Education Timeline Card -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c3 3 9 3 12 0v-5"/></svg>
                            <span>Education History</span>
                        </h3>
                        <span class="student-pill-count">Verified</span>
                    </div>

                    <div style="margin-top:4px;">
                        <div class="timeline-item">
                            <span class="timeline-dot"></span>
                            <div style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:2px;">
                                <strong style="font-size:12.5px; color:var(--stu-text);">B.Tech in Computer Science &amp; Engineering</strong>
                                <span style="font-size:10px; color:#64748b;">2022 &ndash; 2026</span>
                            </div>
                            <div style="font-size:11px; color:#475569; margin-bottom:4px;">Institute of Engineering &amp; Technology</div>
                            <small style="color:#059669; font-weight:700; font-size:10px;">Cumulative CGPA: 8.92 / 10.0 (Semesters 1 - 6)</small>
                        </div>

                        <div class="timeline-item">
                            <span class="timeline-dot"></span>
                            <div style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:2px;">
                                <strong style="font-size:12.5px; color:var(--stu-text);">Higher Secondary Certificate (HSC) &bull; Science Stream</strong>
                                <span style="font-size:10px; color:#64748b;">2020 &ndash; 2022</span>
                            </div>
                            <div style="font-size:11px; color:#475569; margin-bottom:4px;">City Junior College of Science</div>
                            <small style="color:#475569; font-size:10px;">Scored: <strong>94.2%</strong> (Physics, Chemistry, Mathematics)</small>
                        </div>
                    </div>
                </div>

                <!-- Projects & Achievements -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 2 7 12 12 22 7 12 2"/><polyline points="2 17 12 22 22 17"/><polyline points="2 12 12 17 22 12"/></svg>
                            <span>Featured Placement Projects</span>
                        </h3>
                    </div>

                    <div style="display:flex; flex-direction:column; gap:12px;">
                        <div style="padding:10px 12px; background:#f8fafc; border-radius:6px; border:1px solid #e2e8f0;">
                            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:4px;">
                                <strong style="font-size:12px; color:var(--stu-text);">PlacementPrep - AI Career Readiness Portal</strong>
                                <span class="student-badge-correct">Full Stack .NET</span>
                            </div>
                            <p style="margin:0 0 6px; font-size:10.5px; color:#556260; line-height:1.5;">
                                High-performance placement practice web application built on ASP.NET Web Forms, C#, and SQL Server. Features algorithmic sandboxes, ATS resume parsing, and mock interview evaluation.
                            </p>
                            <span style="font-size:9.5px; color:#64748b;">Tech: ASP.NET, C#, SQL Server, JavaScript, CSS3</span>
                        </div>

                        <div style="padding:10px 12px; background:#f8fafc; border-radius:6px; border:1px solid #e2e8f0;">
                            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:4px;">
                                <strong style="font-size:12px; color:var(--stu-text);">Distributed Real-Time Cache Monitor</strong>
                                <span class="student-pill-count">Systems</span>
                            </div>
                            <p style="margin:0 0 6px; font-size:10.5px; color:#556260; line-height:1.5;">
                                Low-latency cache eviction observer implementing LRU and Redis cache-aside invalidation pipelines with benchmark reporting.
                            </p>
                            <span style="font-size:9.5px; color:#64748b;">Tech: C++, Redis, Docker, WebSocket</span>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Right Column: Skills, Links & Certifications -->
            <div style="display:flex; flex-direction:column; gap:16px;">
                
                <!-- Technical Skills -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
                            <span>Verified Technical Skills</span>
                        </h3>
                    </div>

                    <div style="display:flex; flex-direction:column; gap:8px;">
                        <strong style="font-size:10.5px; color:#475569;">Languages &amp; Runtimes:</strong>
                        <div style="display:flex; flex-wrap:wrap; gap:6px;">
                            <span class="student-pill-count">C# / .NET (Advanced)</span>
                            <span class="student-pill-count">C++ (Proficient)</span>
                            <span class="student-pill-count">JavaScript (ES6+)</span>
                            <span class="student-pill-count">SQL (Advanced)</span>
                            <span class="student-pill-count">Python 3</span>
                        </div>

                        <strong style="font-size:10.5px; color:#475569; margin-top:4px;">Core Concepts:</strong>
                        <div style="display:flex; flex-wrap:wrap; gap:6px;">
                            <span class="student-pill-count">Data Structures &amp; Algorithms</span>
                            <span class="student-pill-count">System Design</span>
                            <span class="student-pill-count">DBMS &amp; Indexing</span>
                            <span class="student-pill-count">RESTful APIs</span>
                        </div>
                    </div>
                </div>

                <!-- Professional & Portfolio Links -->
                <div class="student-extracted-card">
                    <div class="student-extracted-card-header">
                        <h3>
                            <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"/><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"/></svg>
                            <span>Professional Profiles</span>
                        </h3>
                    </div>

                    <div style="display:flex; flex-direction:column; gap:8px; font-size:11px;">
                        <div style="display:flex; justify-content:space-between; align-items:center; padding:6px 0; border-bottom:1px solid #f1f5f9;">
                            <span style="color:#64748b;">GitHub:</span>
                            <strong style="color:var(--stu-teal);">github.com/vishal-dev</strong>
                        </div>
                        <div style="display:flex; justify-content:space-between; align-items:center; padding:6px 0; border-bottom:1px solid #f1f5f9;">
                            <span style="color:#64748b;">LinkedIn:</span>
                            <strong style="color:var(--stu-teal);">linkedin.com/in/vishalpatil</strong>
                        </div>
                        <div style="display:flex; justify-content:space-between; align-items:center; padding:6px 0; border-bottom:1px solid #f1f5f9;">
                            <span style="color:#64748b;">LeetCode:</span>
                            <strong style="color:#059669;">240+ Solved (1840 Rating)</strong>
                        </div>
                        <div style="display:flex; justify-content:space-between; align-items:center; padding:6px 0;">
                            <span style="color:#64748b;">Active Resume:</span>
                            <a href="<%= ResolveUrl("~/Student/ResumeViewer.aspx") %>" style="color:var(--stu-teal); font-weight:700;">Resume_Vishal_Patil.pdf</a>
                        </div>
                    </div>
                </div>

                <!-- Demonstration Notice -->
                <div style="font-size:9.5px; color:#64748b; text-align:center; padding:8px 12px; background:#fff; border-radius:8px; border:1px solid #eeedf5;">
                    Profile Demonstration Mode: Pre-configured sample dataset. Connects to the Student database schema in production.
                </div>

            </div>

        </div>

    </div>
</asp:Content>
