using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace personal_library_management_system
{
    public partial class LoginPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Any logic for page load
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string email = TextBox1.Text;
            string password = TextBox2.Text;

            // Special case for a specific admin user
            if (email == "jay@gmail.com" && password == "1234")
            {
                Response.Redirect("BookManagePage.aspx");
                return;
            }

            // Authenticate the user
            if (AuthenticateUser(email, password, out int friendID))
            {
                // Store user information in session
                Session["FriendID"] = friendID;
                Session["Email"] = email;

                // Redirect to the home page on successful login
                Response.Redirect("HomePage.aspx");
            }
            else
            {
                // Display an error message
                LabelMessage.Text = "Invalid email or password.";
            }
        }

        private bool AuthenticateUser(string email, string password, out int friendID)
        {
            bool isAuthenticated = false;
            friendID = -1;

            // Connection string from configuration file
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString;

            // SQL query to check user credentials and retrieve FriendID
            string query = "SELECT FriendID FROM Friends WHERE Email = @Email AND Password = @Password";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);

                    conn.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        friendID = Convert.ToInt32(result);
                        isAuthenticated = true;
                    }
                }
            }

            return isAuthenticated;
        }
    }
}
