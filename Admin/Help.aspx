<%@ Page Title="Help & Institutional Placement Policy" Language="C#" MasterPageFile="~/Admin.Master"
    AutoEventWireup="true" CodeBehind="Help.aspx.cs"
    Inherits="PlacementPrep.Help" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Placement Policy &amp; Help Center | Placement Prep Admin</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="admin-shell-page">

    <!-- Page Header -->
    <div class="users-header">
        <div>
            <div class="users-breadcrumb">
                <a href="<%= ResolveUrl("~/Admin/AdminDashboard.aspx") %>">Dashboard</a>
                <span>/</span>
                <span>Governance &amp; Setup</span>
                <span>/</span>
                <span>Help Center</span>
            </div>
            <h1 class="users-title">Placement Guidelines, FAQs &amp; Operational Help</h1>
            <p class="users-subtitle">
                Official institutional placement guidelines, test creation procedures, proctoring anomaly troubleshooting, and coordinator FAQs.
            </p>
        </div>
        <div class="users-header-actions">
            <a href="<%= ResolveUrl("~/Admin/AdminDashboard.aspx") %>" class="action-button">
                Dashboard Overview
            </a>
            <a href="<%= ResolveUrl("~/Admin/Settings.aspx") %>" class="action-button primary">
                Platform Settings
            </a>
        </div>
    </div>

    <!-- Quick Navigation Hub -->
    <div class="users-kpi-grid">
        <a href="<%= ResolveUrl("~/Admin/ManageTests.aspx") %>" class="users-kpi-card" style="text-decoration:none;">
            <span class="users-kpi-label">Assessment Workflow</span>
            <div class="users-kpi-value" style="font-size:16px;">Test Engine Guide</div>
            <span class="users-kpi-sub">Question cart &amp; proctoring rules &rarr;</span>
        </a>
        <a href="<%= ResolveUrl("~/Admin/QuestionBank.aspx") %>" class="users-kpi-card" style="text-decoration:none;">
            <span class="users-kpi-label">Question Repositories</span>
            <div class="users-kpi-value" style="font-size:16px;">Authoring Handbook</div>
            <span class="users-kpi-sub">Aptitude, Tech &amp; Coding challenges &rarr;</span>
        </a>
        <a href="<%= ResolveUrl("~/Admin/ManageCompanies.aspx") %>" class="users-kpi-card" style="text-decoration:none;">
            <span class="users-kpi-label">Corporate Engagement</span>
            <div class="users-kpi-value" style="font-size:16px;">MoU &amp; Tier Policy</div>
            <span class="users-kpi-sub">Dream tier &amp; mass recruiter rules &rarr;</span>
        </a>
        <a href="<%= ResolveUrl("~/Admin/SystemLogs.aspx") %>" class="users-kpi-card" style="text-decoration:none;">
            <span class="users-kpi-label">Audit &amp; Security</span>
            <div class="users-kpi-value" style="font-size:16px;">Violation Protocols</div>
            <span class="users-kpi-sub">Proctoring lockdown remediation &rarr;</span>
        </a>
    </div>

    <div class="details-grid-layout">
        
        <!-- Left Main Column: Policy Guidance & Workflow FAQs -->
        <div class="details-grid-main">
            
            <!-- Section 1: Official Placement Policy -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h2>Institutional Placement Policy &amp; Code of Conduct</h2>
                    <span class="status-pill status-active"><i></i>Approved by Senate</span>
                </div>
                
                <table class="kv-table">
                    <tr>
                        <td class="kv-label">Single Offer Principle</td>
                        <td class="kv-value">
                            A candidate securing an on-campus offer in Tier 2 or Mass Recruiter categories is permitted to attempt <strong>at most one Tier 1 (Dream Tier &ge;18 LPA)</strong> placement drive. Upon accepting a Dream Tier offer, the candidate is locked from subsequent drives.
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">CGPA Eligibility Benchmark</td>
                        <td class="kv-value">
                            Minimum baseline for general eligibility is <strong>7.00 CGPA</strong> with zero active backlogs at the commencement of the 7th semester. Individual corporate partners may enforce higher benchmarks (e.g. Google 8.00+, Microsoft 7.50+).
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">Assessment Attendance Mandate</td>
                        <td class="kv-value">
                            Registering for a scheduled placement drive and failing to appear without prior 24-hour written medical exemption results in a <strong>14-day suspension</strong> from all ongoing campus drives.
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">Offer Acceptance Window</td>
                        <td class="kv-value">
                            Candidates issued formal Letters of Intent (LOI) must accept or decline within <strong>48 hours</strong> through the Placement Cell. Unresponsive candidates forfeit their priority status.
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Section 2: Coordinator FAQs -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h2>Placement Coordinator Operational FAQs</h2>
                </div>

                <div class="stages-stepper">
                    <div class="stage-step">
                        <div class="stage-step-index">Q1</div>
                        <div class="stage-step-info">
                            <div class="stage-step-title">How do I create and publish a new assessment?</div>
                            <p class="stage-step-desc">
                                Navigate to <strong>Test Management &rarr; Create Assessment</strong>. Complete the 4-step wizard: fill in assessment identity, configure duration/scoring, set the schedule window, and select questions from the interactive Question Cart. Click <em>Publish Assessment</em> to schedule the examination.
                            </p>
                        </div>
                    </div>

                    <div class="stage-step">
                        <div class="stage-step-index">Q2</div>
                        <div class="stage-step-info">
                            <div class="stage-step-title">How are candidate eligibility cutoffs evaluated?</div>
                            <p class="stage-step-desc">
                                When viewing any drive in the <strong>Drive Details Cockpit</strong>, the system dynamically checks every student record in the <em>Student Repository</em> against the drive's cutoff CGPA, eligible departments, and target graduation batch, listing explicit pass/fail rationale for each candidate.
                            </p>
                        </div>
                    </div>

                    <div class="stage-step">
                        <div class="stage-step-index">Q3</div>
                        <div class="stage-step-info">
                            <div class="stage-step-title">What should be done when duplicate company names are flagged?</div>
                            <p class="stage-step-desc">
                                The system enforces server-side uniqueness checks on company names. If a partner is already registered, update the existing company profile rather than creating a duplicate directory item.
                            </p>
                        </div>
                    </div>

                    <div class="stage-step">
                        <div class="stage-step-index">Q4</div>
                        <div class="stage-step-info">
                            <div class="stage-step-title">How can placement analytics reports be exported?</div>
                            <p class="stage-step-desc">
                                On the <strong>Reports &amp; Analytics</strong> page, click <em>Export CSV Summary</em> to download a complete comma-separated report, or click <em>Printable Bulletin</em> to open the printer-optimized bulletin layout.
                            </p>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- Right Side Column: Proctoring Troubleshooting -->
        <div class="details-grid-side">
            
            <div class="details-section-card">
                <div class="details-section-header">
                    <h3>Proctoring Anomaly Troubleshooting</h3>
                </div>

                <table class="kv-table">
                    <tr>
                        <td class="kv-label">Tab Switch Flag</td>
                        <td class="kv-value">
                            Logged if student switches focus. Allowed up to 3 times before assessment automatically locks. Coordinator can unlock from candidate submissions.
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">Webcam Occlusion</td>
                        <td class="kv-value">
                            Triggered if candidate face is not verified for &gt;30s. Advise candidate to maintain front-facing lighting without virtual backgrounds.
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">Network Drop</td>
                        <td class="kv-value">
                            The test runtime automatically saves candidate answers every 60 seconds in session storage. Candidates may reconnect within 5 minutes.
                        </td>
                    </tr>
                    <tr>
                        <td class="kv-label">Multiple Displays</td>
                        <td class="kv-value">
                            Dual monitor setups are blocked during active exams. Candidate must disconnect external monitors before starting.
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Helpdesk Contact Card -->
            <div class="details-section-card">
                <div class="details-section-header">
                    <h3>Support &amp; Advisory Desk</h3>
                </div>
                <table class="kv-table">
                    <tr>
                        <td class="kv-label">Helpdesk Email</td>
                        <td class="kv-value"><a href="mailto:support.placement@univ.edu" class="table-link">support.placement@univ.edu</a></td>
                    </tr>
                    <tr>
                        <td class="kv-label">Internal Ext.</td>
                        <td class="kv-value"><strong>x4280 / x4281</strong></td>
                    </tr>
                    <tr>
                        <td class="kv-label">Office Hours</td>
                        <td class="kv-value">Mon - Sat: 09:00 - 18:00 IST</td>
                    </tr>
                </table>
            </div>

            <div class="users-hint">
                <strong>Demonstration Support Center:</strong> This page serves as administrative policy reference and internal coordinator documentation for UI review.
            </div>

        </div>

    </div>

</div>
</asp:Content>
