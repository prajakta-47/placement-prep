
<%@ Page Title="Faculty Dashboard" Language="C#" MasterPageFile="~/Faculty.Master"
    AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs"
    Inherits="PlacementPrep.FacultyDashboard" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Batch Readiness | Faculty Portal</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="faculty-dashboard">

    <div class="faculty-dashboard-heading">
        <div>
            <h1>Batch Readiness Overview</h1>
            <p>Computer Science &amp; Engineering • Batch 2024</p>
        </div>
        <button type="button" class="faculty-export" onclick="window.print()">⇩ Export</button>
    </div>

    <div class="faculty-dashboard-grid">

        <div class="faculty-left-column">

            <!-- Performance metrics -->
            <section class="faculty-metric-grid">

                <article class="faculty-metric-card">
                    <div class="faculty-metric-top">
                        <span class="faculty-metric-icon">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <circle cx="12" cy="12" r="8"/>
                                <path d="m8.5 12 2.5 2.5 5-5"/>
                            </svg>
                        </span>
                        <span class="faculty-tag">APTITUDE</span>
                    </div>
                    <div class="faculty-metric-value">78%</div>
                    <div class="faculty-metric-caption">Average Clear Rate</div>
                    <div class="faculty-metric-change">↗ +4% from last mock</div>
                </article>

                <article class="faculty-metric-card">
                    <div class="faculty-metric-top">
                        <span class="faculty-metric-icon">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="m8 8-4 4 4 4m8-8 4 4-4 4m-3-10-2 12"/>
                            </svg>
                        </span>
                        <span class="faculty-tag">TECHNICAL</span>
                    </div>
                    <div class="faculty-metric-value">62%</div>
                    <div class="faculty-metric-caption">DSA Proficiency Level</div>
                    <div class="faculty-metric-change neutral">→ Stable performance</div>
                </article>

            </section>

            <!-- Department performance chart -->
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <div>
                        <h2>Department Performance Trends</h2>
                        <p>Comparative mock scores across domain tracks</p>
                    </div>
                    <button type="button" class="faculty-period">Last 30 Days&nbsp; ⌄</button>
                </div>

                <div class="faculty-chart-box">
                    <div class="faculty-chart-legend">
                        <span class="faculty-legend-item">
                            <i class="faculty-legend-dot"></i> Batch 2024
                        </span>
                        <span class="faculty-legend-item">
                            <i class="faculty-legend-dot benchmark"></i> Target Benchmark
                        </span>
                    </div>

                    <div class="faculty-chart" role="img"
                         aria-label="Illustrative performance scores: System Design 55, Core DSA 72, DBMS 62, Quantitative 81, Verbal 80, Full Mock 81 percent">

                        <div class="faculty-chart-column">
                            <div class="faculty-bar" style="height:55%"></div>
                            <span class="faculty-chart-label">Sys Design</span>
                        </div>

                        <div class="faculty-chart-column">
                            <div class="faculty-bar" style="height:72%"></div>
                            <span class="faculty-chart-label">Core DSA</span>
                        </div>

                        <div class="faculty-chart-column">
                            <div class="faculty-bar" style="height:62%"></div>
                            <span class="faculty-chart-label">DBMS</span>
                        </div>

                        <div class="faculty-chart-column">
                            <div class="faculty-bar" style="height:81%"></div>
                            <span class="faculty-chart-label">Quant</span>
                        </div>

                        <div class="faculty-chart-column">
                            <div class="faculty-bar" style="height:80%"></div>
                            <span class="faculty-chart-label">Verbal</span>
                        </div>

                        <div class="faculty-chart-column">
                            <div class="faculty-bar" style="height:81%"></div>
                            <span class="faculty-chart-label">Full Mock</span>
                        </div>

                    </div>
                </div>
            </section>

            <!-- Recent batch activity -->
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <h2>Recent Batch Activity</h2>
                    <span class="faculty-sync-label">Auto-synced from Evaluation Engine</span>
                </div>

                <div class="faculty-timeline">

                    <article class="faculty-timeline-item">
                        <span class="faculty-timeline-marker">✓</span>
                        <div class="faculty-activity-content">
                            <div class="faculty-activity-title">
                                <strong>Mock Test 4</strong>
                                <small>2h ago</small>
                            </div>
                            <p>Results published for Aptitude Mock 4. Average score:
                                <span>72%</span>. 164 students participated.</p>
                        </div>
                    </article>

                    <article class="faculty-timeline-item">
                        <span class="faculty-timeline-marker">◷</span>
                        <div class="faculty-activity-content">
                            <div class="faculty-activity-title">
                                <strong>Curriculum Update</strong>
                                <small>Yesterday</small>
                            </div>
                            <p>Added Dynamic Programming &amp; Graph Theory problem set
                                aligned with Amazon &amp; Tech Mahindra drive tracks.</p>
                        </div>
                    </article>

                    <article class="faculty-timeline-item">
                        <span class="faculty-timeline-marker">✣</span>
                        <div class="faculty-activity-content">
                            <div class="faculty-activity-title">
                                <strong>Resume Verification Call</strong>
                                <small>3 days ago</small>
                            </div>
                            <p>Coordinator notified 36 candidates to re-submit updated
                                ATS-friendly resumes for slot confirmation.</p>
                        </div>
                    </article>

                </div>
            </section>

        </div>

        <!-- Right column -->
        <aside class="faculty-right-column">

            <!-- Placement readiness -->
            <section class="faculty-readiness-card">
                <div class="faculty-readiness-label">READY FOR PLACEMENT</div>
                <div class="faculty-readiness-number">142<span> / 200</span></div>
                <div class="faculty-readiness-caption">Students crossing minimum threshold</div>
                <div class="faculty-readiness-track">
                    <div class="faculty-readiness-fill"></div>
                </div>
            </section>

            <!-- Quick actions -->
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <h2>Quick Actions</h2>
                </div>

                <div class="faculty-quick-actions">

                    <a class="faculty-quick-action" href="<%= ResolveUrl("~/Faculty/PlacementDrives.aspx") %>">
                        <span class="faculty-quick-icon">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <circle cx="12" cy="12" r="9"/>
                                <path d="M12 7v5l3 2"/>
                            </svg>
                        </span>
                        <span>Schedule<br />Test</span>
                    </a>

                    <a class="faculty-quick-action" href="<%= ResolveUrl("~/Faculty/Announcements.aspx") %>">
                        <span class="faculty-quick-icon">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <path d="M4 14V9h4l9-4v13l-9-4z"/>
                                <path d="m8 14 2 6h4l-3-7m9-6 2-2m-2 7h3"/>
                            </svg>
                        </span>
                        <span>Announcement</span>
                    </a>

                    <a class="faculty-quick-action" href="<%= ResolveUrl("~/Faculty/Students.aspx") %>">
                        <span class="faculty-quick-icon">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <circle cx="10" cy="9" r="4"/>
                                <path d="M3 20a7 7 0 0 1 12-5m2 2 4 4m-1-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                            </svg>
                        </span>
                        <span>Find Student</span>
                    </a>

                    <a class="faculty-quick-action" href="<%= ResolveUrl("~/Faculty/BatchReports.aspx") %>">
                        <span class="faculty-quick-icon">
                            <svg viewBox="0 0 24 24" aria-hidden="true">
                                <rect x="4" y="3" width="16" height="18" rx="2"/>
                                <path d="M8 16v-4m4 4V7m4 9v-6"/>
                            </svg>
                        </span>
                        <span>Generate<br />Report</span>
                    </a>

                </div>
            </section>

            <!-- Upcoming schedule -->
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <h2>Upcoming Schedule</h2>
                    <a class="faculty-view-all" href="<%= ResolveUrl("~/Faculty/PlacementDrives.aspx") %>">View All</a>
                </div>

                <div class="faculty-schedule-list">

                    <article class="faculty-schedule-item">
                        <div class="faculty-date-box">
                            <small>OCT</small>
                            <strong>12</strong>
                        </div>
                        <div class="faculty-schedule-details">
                            <strong>Tech Mahindra - Mock Interview</strong>
                            <small>◷ 10:00 AM - 01:00 PM</small>
                        </div>
                    </article>

                    <article class="faculty-schedule-item">
                        <div class="faculty-date-box">
                            <small>OCT</small>
                            <strong>15</strong>
                        </div>
                        <div class="faculty-schedule-details">
                            <strong>Advanced DSA Assessment</strong>
                            <small>◷ 02:00 PM - 03:30 PM</small>
                        </div>
                    </article>

                    <article class="faculty-schedule-item">
                        <div class="faculty-date-box">
                            <small>OCT</small>
                            <strong>19</strong>
                        </div>
                        <div class="faculty-schedule-details">
                            <strong>Accenture Technical Round Screening</strong>
                            <small>◷ 11:30 AM - 01:30 PM</small>
                        </div>
                    </article>

                </div>
            </section>

        </aside>

    </div>
</div>

</asp:Content>
