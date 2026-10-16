<%@ Page Title="Analytics" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="Analytics.aspx.cs" Inherits="PlacementPrep.Faculty.Analytics" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:16px;">

    <div class="faculty-dashboard-heading" style="margin-bottom:0;">
        <div>
            <h1>Cohort Performance Analytics</h1>
            <p>Diagnostic trends across test series, mock interviews, and technical topics</p>
        </div>
        <span class="faculty-sync-label">Weekly Benchmark Synced</span>
    </div>

    <!-- Chart Panels -->
    <div class="faculty-dashboard-grid">
        <div class="faculty-left-column">
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <h2>Domain Performance Breakdown</h2>
                    <span class="faculty-period">Past 30 Days</span>
                </div>
                <div class="faculty-chart-box" style="margin-top:14px;">
                    <div class="faculty-chart">
                        <div class="faculty-chart-column">
                            <div class="faculty-bar" style="height:88%"></div>
                            <span class="faculty-chart-label">DSA</span>
                        </div>
                        <div class="faculty-chart-column">
                            <div class="faculty-bar" style="height:74%"></div>
                            <span class="faculty-chart-label">OOP / C#</span>
                        </div>
                        <div class="faculty-chart-column">
                            <div class="faculty-bar" style="height:82%"></div>
                            <span class="faculty-chart-label">DBMS</span>
                        </div>
                        <div class="faculty-chart-column">
                            <div class="faculty-bar" style="height:65%"></div>
                            <span class="faculty-chart-label">Sys Design</span>
                        </div>
                        <div class="faculty-chart-column">
                            <div class="faculty-bar" style="height:79%"></div>
                            <span class="faculty-chart-label">Aptitude</span>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <aside class="faculty-right-column">
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <h2>Readiness Distribution</h2>
                </div>
                <div style="display:flex; flex-direction:column; gap:12px; margin-top:14px; font-size:11px;">
                    <div>
                        <div style="display:flex; justify-content:space-between; margin-bottom:4px;">
                            <span>Strong Fit (>80%)</span>
                            <strong>48% (96 students)</strong>
                        </div>
                        <div class="faculty-readiness-track"><div class="faculty-readiness-fill" style="width:48%;"></div></div>
                    </div>
                    <div>
                        <div style="display:flex; justify-content:space-between; margin-bottom:4px;">
                            <span>On Track (65% - 80%)</span>
                            <strong>38% (76 students)</strong>
                        </div>
                        <div class="faculty-readiness-track"><div class="faculty-readiness-fill" style="width:38%; background:#2563eb;"></div></div>
                    </div>
                    <div>
                        <div style="display:flex; justify-content:space-between; margin-bottom:4px;">
                            <span>Needs Remediation (<65%)</span>
                            <strong>14% (28 students)</strong>
                        </div>
                        <div class="faculty-readiness-track"><div class="faculty-readiness-fill" style="width:14%; background:#dc2626;"></div></div>
                    </div>
                </div>
            </section>
        </aside>
    </div>

</div>
</asp:Content>
