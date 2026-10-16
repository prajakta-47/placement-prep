<%@ Page Title="Help Center" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="PlacementPrep.Faculty.Help" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:16px;">

    <div class="faculty-dashboard-heading" style="margin-bottom:0;">
        <div>
            <h1>Faculty Portal Documentation &amp; Help Center</h1>
            <p>Guidelines for assessment authoring, student evaluation, and AI rubric tuning</p>
        </div>
        <span class="faculty-sync-label">Handbook v2.4</span>
    </div>

    <div class="faculty-dashboard-grid">
        <div class="faculty-left-column">
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <h2>Frequently Asked Questions</h2>
                </div>
                <div style="display:flex; flex-direction:column; gap:14px; margin-top:12px; font-size:12px;">
                    <div>
                        <strong style="color:var(--fac-text);">How is the student Placement Readiness score calculated?</strong>
                        <p style="margin:4px 0 0; color:var(--fac-muted); font-size:11px;">The Readiness Index combines Cumulative GPA (30%), Mock Aptitude Performance (35%), Coding Lab Solved Problems (25%), and Interview Clarity Rating (10%).</p>
                    </div>
                    <div>
                        <strong style="color:var(--fac-text);">How do I deploy updated AI prompts to production?</strong>
                        <p style="margin:4px 0 0; color:var(--fac-muted); font-size:11px;">Navigate to AI Config, edit the desired module prompt instructions, test output in the sandbox, and click Deploy Configuration.</p>
                    </div>
                    <div>
                        <strong style="color:var(--fac-text);">Can I export cohort data for University Placement Cell submissions?</strong>
                        <p style="margin:4px 0 0; color:var(--fac-muted); font-size:11px;">Yes, visit Batch Reports and click Export Official PDF to generate a certified report.</p>
                    </div>
                </div>
            </section>
        </div>

        <aside class="faculty-right-column">
            <section class="faculty-panel">
                <div class="faculty-panel-heading">
                    <h2>Support Contacts</h2>
                </div>
                <div style="font-size:11px; margin-top:10px; color:var(--fac-muted); display:flex; flex-direction:column; gap:8px;">
                    <div><strong>Placement Cell:</strong> placement.cell@campus.edu</div>
                    <div><strong>Technical Support:</strong> portal-tech@campus.edu</div>
                    <div><strong>Lab Coordinator:</strong> Prof. R. Sharma (Ext 4012)</div>
                </div>
            </section>
        </aside>
    </div>

</div>
</asp:Content>
