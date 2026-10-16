namespace PlacementPrep
{
    public partial class SystemLogs
    {
        protected global::System.Web.UI.WebControls.LinkButton btnClearLogs;
        protected global::System.Web.UI.WebControls.LinkButton btnExportCsv;
        protected global::System.Web.UI.WebControls.Panel pnlMessage;
        protected global::System.Web.UI.WebControls.Literal litMessage;
        protected global::System.Web.UI.WebControls.HiddenField hfPageIndex;
        protected global::System.Web.UI.WebControls.TextBox txtSearch;
        protected global::System.Web.UI.WebControls.DropDownList ddlModuleFilter;
        protected global::System.Web.UI.WebControls.DropDownList ddlSeverityFilter;
        protected global::System.Web.UI.WebControls.LinkButton btnApplyFilters;
        protected global::System.Web.UI.WebControls.LinkButton btnResetFilters;
        protected global::System.Web.UI.WebControls.Repeater rptLogs;
        protected global::System.Web.UI.WebControls.Panel pnlEmpty;
        protected global::System.Web.UI.WebControls.Literal litPageInfo;
        protected global::System.Web.UI.WebControls.DropDownList ddlPageSize;
        protected global::System.Web.UI.WebControls.LinkButton btnPrevPage;
        protected global::System.Web.UI.WebControls.Repeater rptPages;
        protected global::System.Web.UI.WebControls.LinkButton btnNextPage;
        protected global::System.Web.UI.WebControls.Panel pnlEventModal;
        protected global::System.Web.UI.WebControls.Literal litModalEventId;
        protected global::System.Web.UI.WebControls.LinkButton btnCloseEventModal;
        protected global::System.Web.UI.WebControls.Literal litModalAction;
        protected global::System.Web.UI.WebControls.Literal litModalModule;
        protected global::System.Web.UI.WebControls.Literal litModalTimestamp;
        protected global::System.Web.UI.WebControls.Literal litModalIp;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl badgeModalSeverity;
        protected global::System.Web.UI.WebControls.Literal litModalSeverity;
        protected global::System.Web.UI.WebControls.Literal litModalActor;
        protected global::System.Web.UI.WebControls.Literal litModalTarget;
        protected global::System.Web.UI.WebControls.Literal litModalMessage;
        protected global::System.Web.UI.WebControls.Literal litModalPayload;
        protected global::System.Web.UI.WebControls.LinkButton btnDismissEventModal;
    }
}
