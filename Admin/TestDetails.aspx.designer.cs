namespace PlacementPrep.Admin
{
    public partial class TestDetails
    {
        protected global::System.Web.UI.WebControls.HiddenField hfTestId;
        protected global::System.Web.UI.WebControls.HiddenField hfActiveTab;
        protected global::System.Web.UI.WebControls.Literal litTestTitle;
        protected global::System.Web.UI.WebControls.Literal litTestCodeBadge;
        protected global::System.Web.UI.WebControls.Literal litCompany;
        protected global::System.Web.UI.WebControls.Literal litType;
        protected global::System.Web.UI.WebControls.LinkButton btnPublish;
        protected global::System.Web.UI.WebControls.LinkButton btnRevertDraft;
        protected global::System.Web.UI.WebControls.Panel pnlMessage;
        protected global::System.Web.UI.WebControls.Literal litMessage;
        protected global::System.Web.UI.WebControls.Literal litKpiMarks;
        protected global::System.Web.UI.WebControls.Literal litKpiPassScore;
        protected global::System.Web.UI.WebControls.Literal litKpiDuration;
        protected global::System.Web.UI.WebControls.Literal litKpiSchedule;
        protected global::System.Web.UI.WebControls.Literal litKpiQuestions;
        protected global::System.Web.UI.WebControls.Literal litKpiStatusPill;
        protected global::System.Web.UI.WebControls.Literal litKpiProctoring;
        protected global::System.Web.UI.WebControls.LinkButton tabBtnOverview;
        protected global::System.Web.UI.WebControls.LinkButton tabBtnQuestions;
        protected global::System.Web.UI.WebControls.Literal litTabQuestionCount;
        protected global::System.Web.UI.WebControls.LinkButton tabBtnRoster;
        protected global::System.Web.UI.WebControls.Literal litTabStudentCount;
        protected global::System.Web.UI.WebControls.LinkButton tabBtnEdit;
        protected global::System.Web.UI.WebControls.Panel pnlTabOverview;
        protected global::System.Web.UI.WebControls.Literal litTargetDept;
        protected global::System.Web.UI.WebControls.Literal litTargetBatch;
        protected global::System.Web.UI.WebControls.Literal litScheduleDetail;
        protected global::System.Web.UI.WebControls.Literal litNegativeMarkingDisplay;
        protected global::System.Web.UI.WebControls.Literal litShufflingDisplay;
        protected global::System.Web.UI.WebControls.Literal litDescription;
        protected global::System.Web.UI.WebControls.Literal litInstructions;
        protected global::System.Web.UI.WebControls.Literal litCreatedBy;
        protected global::System.Web.UI.WebControls.Literal litUpdatedAt;
        protected global::System.Web.UI.WebControls.Panel pnlTabQuestions;
        protected global::System.Web.UI.WebControls.Repeater rptTestQuestions;
        protected global::System.Web.UI.WebControls.Panel pnlTabRoster;
        protected global::System.Web.UI.WebControls.Repeater rptStudentRoster;
        protected global::System.Web.UI.WebControls.Panel pnlTabEdit;
        protected global::System.Web.UI.WebControls.ValidationSummary valSummaryEdit;
        protected global::System.Web.UI.WebControls.TextBox txtEditTitle;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvEditTitle;
        protected global::System.Web.UI.WebControls.TextBox txtEditCompany;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvEditCompany;
        protected global::System.Web.UI.WebControls.DropDownList ddlEditType;
        protected global::System.Web.UI.WebControls.DropDownList ddlEditStatus;
        protected global::System.Web.UI.WebControls.TextBox txtEditDuration;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvEditDuration;
        protected global::System.Web.UI.WebControls.RangeValidator rvEditDuration;
        protected global::System.Web.UI.WebControls.TextBox txtEditMarks;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvEditMarks;
        protected global::System.Web.UI.WebControls.TextBox txtEditScheduledStart;
        protected global::System.Web.UI.WebControls.TextBox txtEditScheduledEnd;
        protected global::System.Web.UI.WebControls.TextBox txtEditInstructions;
        protected global::System.Web.UI.WebControls.LinkButton btnSaveEdit;
    }
}
