using System;
using System.Web.UI;

namespace PlacementPrep
{
    public partial class ProblemDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(id))
                {
                    if (id == "2")
                    {
                        lblProblemTitle.Text = "2. Longest Substring Without Repeating Characters";
                        lblBreadcrumbTitle.Text = "2. Longest Substring";
                        lnkOpenEditorTop.NavigateUrl = "~/Student/CodeEditor.aspx?id=2";
                        lnkLaunchEditor.NavigateUrl = "~/Student/CodeEditor.aspx?id=2";
                    }
                    else if (id == "3")
                    {
                        lblProblemTitle.Text = "3. Valid Parentheses";
                        lblBreadcrumbTitle.Text = "3. Valid Parentheses";
                        lnkOpenEditorTop.NavigateUrl = "~/Student/CodeEditor.aspx?id=3";
                        lnkLaunchEditor.NavigateUrl = "~/Student/CodeEditor.aspx?id=3";
                    }
                    else
                    {
                        lnkOpenEditorTop.NavigateUrl = "~/Student/CodeEditor.aspx?id=" + id;
                        lnkLaunchEditor.NavigateUrl = "~/Student/CodeEditor.aspx?id=" + id;
                    }
                }
            }
        }
    }
}
