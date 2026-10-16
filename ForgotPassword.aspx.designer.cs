namespace PlacementPrep
{
    public partial class ForgotPassword
    {
        protected global::System.Web.UI.HtmlControls.HtmlForm form1;
        protected global::System.Web.UI.WebControls.Panel pnlAlert;
        protected global::System.Web.UI.WebControls.Literal litAlert;

        protected global::System.Web.UI.WebControls.Panel pnlRequestStep;
        protected global::System.Web.UI.WebControls.TextBox txtEmail;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvEmail;
        protected global::System.Web.UI.WebControls.RegularExpressionValidator revEmail;
        protected global::System.Web.UI.WebControls.Button btnSendResetLink;
        protected global::System.Web.UI.WebControls.LinkButton btnSwitchToToken;

        protected global::System.Web.UI.WebControls.Panel pnlTokenNotice;
        protected global::System.Web.UI.WebControls.Literal litGenericNotice;
        protected global::System.Web.UI.WebControls.Literal litBackendNote;
        protected global::System.Web.UI.WebControls.Label lblIssuedToken;
        protected global::System.Web.UI.WebControls.HiddenField hfGeneratedToken;
        protected global::System.Web.UI.WebControls.Button btnProceedWithToken;

        protected global::System.Web.UI.WebControls.Panel pnlResetStep;
        protected global::System.Web.UI.WebControls.TextBox txtToken;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvToken;
        protected global::System.Web.UI.WebControls.TextBox txtNewPassword;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvNewPassword;
        protected global::System.Web.UI.WebControls.RegularExpressionValidator revNewPassword;
        protected global::System.Web.UI.WebControls.TextBox txtConfirmPassword;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvConfirmPassword;
        protected global::System.Web.UI.WebControls.CompareValidator cvConfirmPassword;
        protected global::System.Web.UI.WebControls.Button btnSubmitNewPassword;
        protected global::System.Web.UI.WebControls.LinkButton btnBackToRequest;

        protected global::System.Web.UI.WebControls.Panel pnlSuccessStep;
    }
}
