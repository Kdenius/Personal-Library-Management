using System;
using System.Web;

namespace personal_library_management_system
{
    public partial class LogoutPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear session data
            Session.Clear();
            Session.Abandon();

            // Redirect to login page after logging out
            Response.Redirect("LoginPage.aspx");
        }
    }
}
