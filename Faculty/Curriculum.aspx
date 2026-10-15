<%@ Page Title="Curriculum" Language="C#" MasterPageFile="~/Faculty.Master" AutoEventWireup="true" CodeBehind="Curriculum.aspx.cs" Inherits="PlacementPrep.Faculty.Curriculum" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .fac-subject-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 16px;
            margin-top: 14px;
        }
        .fac-subject-card {
            background: #ffffff;
            border: 1px solid var(--fac-border);
            border-radius: 8px;
            padding: 16px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .fac-subject-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }
        .fac-code-tag {
            background: #e6f9f5;
            color: #00685e;
            padding: 2px 7px;
            border-radius: 4px;
            font-size: 10px;
            font-weight: 700;
        }
    </style>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="faculty-dashboard" style="display:flex; flex-direction:column; gap:16px;">

    <div class="faculty-dashboard-heading" style="margin-bottom:0;">
        <div>
            <h1>Curriculum &amp; Assessment Syllabus</h1>
            <p>Placement preparation tracks aligned with technical hiring rubrics</p>
        </div>
        <span class="faculty-sync-label">Aligned with Tech Mahindra &amp; Amazon Tracks</span>
    </div>

    <div class="fac-subject-grid">
        <asp:Repeater ID="rptSubjects" runat="server">
            <ItemTemplate>
                <div class="fac-subject-card">
                    <div class="fac-subject-header">
                        <span class="fac-code-tag"><%# Eval("SubjectCode") %></span>
                        <span style="font-size:10px; color:var(--fac-muted);">Sem <%# Eval("Semester") %></span>
                    </div>
                    <div>
                        <h3 style="margin:0 0 4px; font-size:13px; color:var(--fac-text);"><%# Eval("SubjectName") %></h3>
                        <p style="margin:0; font-size:11px; color:var(--fac-muted);"><%# Eval("Department") %></p>
                    </div>
                    <div style="display:flex; justify-content:space-between; font-size:11px; padding-top:8px; border-top:1px solid #f0f3f8;">
                        <span>Topics: <strong><%# Eval("TopicsCount") %></strong></span>
                        <span>Cohort Readiness: <strong><%# Eval("ReadinessRate", "{0:F1}") %>%</strong></span>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>
</asp:Content>
