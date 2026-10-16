
<%@ Page Title="Platform Overview" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs"
    Inherits="PlacementPrep.AdminDashboard" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="dashboard-page">

    <div class="command-label">
        INSTITUTIONAL COMMAND <span>- Real-time Telemetry</span>
    </div>

    <div class="dashboard-heading-row">
        <div class="dashboard-heading">
            <h1>Platform Overview</h1>
            <p>Monitor real-time platform activity, examine student cohort velocity,
               review assessment loads, and audit system integrity across campus drives.</p>
        </div>

        <div class="heading-actions">
            <button type="button" class="action-button">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align: middle; margin-right: 4px;" aria-hidden="true">
                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                    <polyline points="7 10 12 15 17 10"></polyline>
                    <line x1="12" y1="15" x2="12" y2="3"></line>
                </svg>Export Data
            </button>
            <button type="button" class="action-button primary">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align: middle; margin-right: 4px;" aria-hidden="true">
                    <line x1="12" y1="5" x2="12" y2="19"></line>
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                </svg>New Placement Drive
            </button>
        </div>
    </div>

    <div class="dashboard-grid">

        <div class="dashboard-left">

            <!-- Summary cards -->
            <div class="metric-grid">

                <div class="metric-card">
                    <div class="metric-top">
                        <span class="metric-label">TOTAL USERS</span>
                        <span class="metric-icon">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                <circle cx="9" cy="7" r="4"></circle>
                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                            </svg>
                        </span>
                    </div>
                    <div class="metric-value">12,450</div>
                    <div class="metric-change"><strong>+12%</strong> vs last month</div>
                </div>

                <div class="metric-card">
                    <div class="metric-top">
                        <span class="metric-label">ACTIVE STUDENTS</span>
                        <span class="metric-icon">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M22 10v6M2 10l10-5 10 5-10 5z"></path>
                                <path d="M6 12v5c3 3 9 3 12 0v-5"></path>
                            </svg>
                        </span>
                    </div>
                    <div class="metric-value">8,192</div>
                    <div class="metric-change"><strong>+5%</strong> vs last month</div>
                </div>

                <div class="metric-card">
                    <div class="metric-top">
                        <span class="metric-label">QUESTION BANK</span>
                        <span class="metric-icon">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path>
                                <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path>
                            </svg>
                        </span>
                    </div>
                    <div class="metric-value">2,486</div>
                    <div class="metric-change"><strong>+18%</strong> vs last month</div>
                </div>

                <div class="metric-card">
                    <div class="metric-top">
                        <span class="metric-label">ACTIVE TESTS</span>
                        <span class="metric-icon">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <polyline points="9 11 12 14 22 4"></polyline>
                                <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path>
                            </svg>
                        </span>
                    </div>
                    <div class="metric-value">124</div>
                    <div class="metric-change"><strong>+8</strong> this week</div>
                </div>

            </div>

            <!-- Activity chart -->
            <section class="panel">
                <div class="panel-heading">
                    <div>
                        <h2>Platform Activity &amp; Assessment Trends</h2>
                        <p>Aggregated test submissions and live assessment sessions</p>
                    </div>
                    <div class="chart-legend">
                        <span><i class="legend-dot"></i> Submissions</span>
                        <span><i class="legend-dot mint"></i> Active Sessions</span>
                        <span class="year-filter">Academic Year 2024</span>
                    </div>
                </div>

                <div class="chart-area">
                    <svg viewBox="0 0 520 220" role="img"
                         aria-label="Illustrative monthly submissions and active sessions chart">
                        <defs>
                            <linearGradient id="submissionFill" x1="0" y1="0" x2="0" y2="1">
                                <stop offset="0%" stop-color="#078779" stop-opacity=".22"/>
                                <stop offset="100%" stop-color="#078779" stop-opacity=".01"/>
                            </linearGradient>
                        </defs>

                        <line class="chart-grid-line" x1="40" y1="25" x2="510" y2="25"/>
                        <line class="chart-grid-line" x1="40" y1="65" x2="510" y2="65"/>
                        <line class="chart-grid-line" x1="40" y1="105" x2="510" y2="105"/>
                        <line class="chart-grid-line" x1="40" y1="145" x2="510" y2="145"/>
                        <line class="chart-grid-line" x1="40" y1="185" x2="510" y2="185"/>

                        <text class="chart-axis-label" x="5" y="28">8k</text>
                        <text class="chart-axis-label" x="5" y="68">6k</text>
                        <text class="chart-axis-label" x="5" y="108">4k</text>
                        <text class="chart-axis-label" x="5" y="148">2k</text>

                        <path d="M40 155 C75 150, 100 142, 135 133
                                 S195 105, 230 94
                                 S290 80, 325 72
                                 S390 61, 420 65
                                 S475 59, 505 34
                                 L505 185 L40 185 Z"
                              fill="url(#submissionFill)"/>

                        <path d="M40 155 C75 150, 100 142, 135 133
                                 S195 105, 230 94
                                 S290 80, 325 72
                                 S390 61, 420 65
                                 S475 59, 505 34"
                              fill="none" stroke="#087f73" stroke-width="2.5"
                              stroke-linecap="round"/>

                        <path d="M40 170 C85 166, 110 157, 135 154
                                 S195 138, 230 130
                                 S290 123, 325 116
                                 S390 111, 420 108
                                 S475 103, 505 80"
                              fill="none" stroke="#42dca8" stroke-width="2"
                              stroke-linecap="round"/>

                        <circle cx="40" cy="155" r="3" fill="#087f73"/>
                        <circle cx="135" cy="133" r="3" fill="#087f73"/>
                        <circle cx="230" cy="94" r="3" fill="#087f73"/>
                        <circle cx="325" cy="72" r="3" fill="#087f73"/>
                        <circle cx="420" cy="65" r="3" fill="#087f73"/>
                        <circle cx="505" cy="34" r="3" fill="#087f73"/>

                        <text class="chart-axis-label" x="35" y="207">Jan</text>
                        <text class="chart-axis-label" x="128" y="207">Feb</text>
                        <text class="chart-axis-label" x="223" y="207">Mar</text>
                        <text class="chart-axis-label" x="318" y="207">Apr</text>
                        <text class="chart-axis-label" x="412" y="207">May</text>
                        <text class="chart-axis-label" x="496" y="207">Jun</text>
                    </svg>
                </div>

                <div class="chart-stats">
                    <div class="chart-stat">
                        <span>AVG COMPLETION</span>
                        <strong>91.4%</strong>
                    </div>
                    <div class="chart-stat">
                        <span>PROCTOR INTEGRITY</span>
                        <strong style="color:#087f65">99.8%</strong>
                    </div>
                    <div class="chart-stat">
                        <span>PEAK CONCURRENCY</span>
                        <strong>3,240</strong>
                    </div>
                </div>
            </section>

            <!-- Placement drives -->
            <section class="panel">
                <div class="panel-heading">
                    <div>
                        <h2>Recent Placement Drives</h2>
                        <p>Cohorts currently deployed or queued for company intake</p>
                    </div>
                    <a class="table-link" href="<%= ResolveUrl("~/Admin/PlacementDrives.aspx") %>">View All Drives &rarr;</a>
                </div>

                <div class="table-scroll">
                    <table class="drives-table">
                        <thead>
                            <tr>
                                <th>DRIVE NAME &amp; COMPANY</th>
                                <th>BATCH</th>
                                <th>ENROLLED</th>
                                <th>DATE WINDOW</th>
                                <th>STATUS</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <span class="drive-logo">AZ</span>
                                    <span class="drive-name">Amazon SDE-1 Assessment</span>
                                    <span class="drive-description">Cloud &amp; Distributed Systems</span>
                                </td>
                                <td>2024 CS/IT</td>
                                <td>620 Students</td>
                                <td>Jun 14 - Jun 16</td>
                                <td><span class="status-badge good">Active</span></td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="drive-logo">MS</span>
                                    <span class="drive-name">Microsoft SWE Campus Challenge</span>
                                    <span class="drive-description">Algorithm &amp; System Fundamentals</span>
                                </td>
                                <td>2024 All Branches</td>
                                <td>1,140 Students</td>
                                <td>Jun 20 - Jun 22</td>
                                <td><span class="status-badge scheduled">Scheduled</span></td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="drive-logo">GS</span>
                                    <span class="drive-name">Goldman Sachs Quantitative Aptitude</span>
                                    <span class="drive-description">Math, Logic &amp; Financial Mechanics</span>
                                </td>
                                <td>2025 Honors Cohort</td>
                                <td>480 Students</td>
                                <td>Jun 12 - Jun 13</td>
                                <td><span class="status-badge good">Active</span></td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="drive-logo">CS</span>
                                    <span class="drive-name">Cisco Systems Network Engineer Role</span>
                                    <span class="drive-description">Core TCP/IP, OS &amp; Security</span>
                                </td>
                                <td>2024 ECE/Telecom</td>
                                <td>310 Students</td>
                                <td>Jun 25 - Jun 26</td>
                                <td><span class="status-badge scheduled">Scheduled</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

        </div>

        <!-- Right column -->
        <div class="dashboard-right">

            <section class="panel">
                <div class="panel-heading">
                    <h2>
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align: middle; margin-right: 6px;" aria-hidden="true">
                            <rect x="2" y="2" width="20" height="8" rx="2" ry="2"></rect>
                            <rect x="2" y="14" width="20" height="8" rx="2" ry="2"></rect>
                            <line x1="6" y1="6" x2="6.01" y2="6"></line>
                            <line x1="6" y1="18" x2="6.01" y2="18"></line>
                        </svg>System Health
                    </h2>
                    <span class="sla-badge">99.94% SLA</span>
                </div>

                <div class="health-list">
                    <div class="health-row">
                        <span class="health-icon">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <circle cx="12" cy="12" r="10"></circle>
                                <line x1="2" y1="12" x2="22" y2="12"></line>
                                <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path>
                            </svg>
                        </span>
                        <span class="health-name">Core API</span>
                        <span class="status-badge good">Operational</span>
                    </div>
                    <div class="health-row">
                        <span class="health-icon">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <ellipse cx="12" cy="5" rx="9" ry="3"></ellipse>
                                <path d="M21 12c0 1.66-4 3-9 3s-9-1.34-9-3"></path>
                                <path d="M3 5v14c0 1.66 4 3 9 3s9-1.34 9-3V5"></path>
                            </svg>
                        </span>
                        <span class="health-name">Database Cluster</span>
                        <span class="status-badge good">Operational</span>
                    </div>
                    <div class="health-row">
                        <span class="health-icon">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M12 2a8 8 0 0 0-8 8c0 3.31 2.01 6.16 4.9 7.37L9 22l3-1.5 3 1.5.1-4.63C17.99 16.16 20 13.31 20 10a8 8 0 0 0-8-8z"></path>
                            </svg>
                        </span>
                        <span class="health-name">AI Evaluation Engine</span>
                        <span class="status-badge info">Under Load</span>
                    </div>
                    <div class="health-row">
                        <span class="health-icon">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                            </svg>
                        </span>
                        <span class="health-name">Authentication Service</span>
                        <span class="status-badge good">Operational</span>
                    </div>
                    <div class="health-row">
                        <span class="health-icon">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path>
                            </svg>
                        </span>
                        <span class="health-name">File Storage</span>
                        <span class="status-badge good">Operational</span>
                    </div>
                </div>

                <div class="provision-box">
                    <strong>Auto-scaling Provision <span class="provision-status">STABLE</span></strong>
                    AWS us-east-1 - 8 Nodes Active
                </div>
            </section>

            <section class="panel">
                <div class="panel-heading">
                    <h2>
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align: middle; margin-right: 6px;" aria-hidden="true">
                            <circle cx="12" cy="12" r="10"></circle>
                            <polyline points="12 6 12 12 16 14"></polyline>
                        </svg>Recent Admin Activity
                    </h2>
                    <span style="font-size:8px;color:#7b8591">Live Feed</span>
                </div>

                <div class="activity-list">
                    <div class="activity-item">
                        <div class="activity-title">New coding problem added: LRU Cache II</div>
                        <div class="activity-meta">
                            <span>2 mins ago</span>
                            <span class="activity-tag">Placements Lead</span>
                        </div>
                    </div>

                    <div class="activity-item">
                        <div class="activity-title">Aptitude question updated: System Probability Set 4</div>
                        <div class="activity-meta">
                            <span>18 mins ago</span>
                            <span class="activity-tag">System</span>
                        </div>
                    </div>

                    <div class="activity-item">
                        <div class="activity-title">Technical question published: B-Tree Indexing</div>
                        <div class="activity-meta">
                            <span>35 mins ago</span>
                            <span class="activity-tag">Admin</span>
                        </div>
                    </div>

                    <div class="activity-item">
                        <div class="activity-title">New faculty account created: Dr. Sharma</div>
                        <div class="activity-meta">
                            <span>1 hr ago</span>
                            <span class="activity-tag">Super Admin</span>
                        </div>
                    </div>

                    <div class="activity-item">
                        <div class="activity-title">Batch 2024 roster imported (450 students)</div>
                        <div class="activity-meta">
                            <span>2 hrs ago</span>
                            <span class="activity-tag">Admin</span>
                        </div>
                    </div>

                    <div class="activity-item">
                        <div class="activity-title">Mock Placement Test #4 published</div>
                        <div class="activity-meta">
                            <span>3 hrs ago</span>
                            <span class="activity-tag">Admin</span>
                        </div>
                    </div>
                </div>

                <button type="button" class="audit-button">Open Full Audit Trail &rarr;</button>
            </section>

        </div>
    </div>
</div>

</asp:Content>
