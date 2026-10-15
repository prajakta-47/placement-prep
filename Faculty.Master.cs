using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace PlacementPrep
{
    public partial class FacultyMaster : System.Web.UI.MasterPage
    {
        public string IsActive(params string[] pageNames)
        {
            string currentPage = System.IO.Path.GetFileName(Request.Path);
            if (pageNames != null)
            {
                foreach (var page in pageNames)
                {
                    if (string.Equals(currentPage, page, StringComparison.OrdinalIgnoreCase))
                        return "active";
                }
            }
            return "";
        }
    }
}
