using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace personal_library_management_system
{
    public partial class RegisterPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Any logic for page load
        }

        protected void ButtonRegister_Click(object sender, EventArgs e)
        {
            string name = TextBoxName.Text;
            string email = TextBoxEmail.Text;
            string phone = TextBoxPhone.Text;
            string password = TextBoxPassword.Text;

            if (RegisterFriend(name, email, phone, password))
            {
                // Redirect to login page or display success message
                Response.Redirect("LoginPage.aspx");
            }
            else
            {
                // Display an error message
                LabelMessage.Text = "An error occurred while registering. Please try again.";
            }
        }

        private bool RegisterFriend(string name, string email, string phone, string password)
        {
            bool isRegistered = false;

            // Connection string from configuration file
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString;

            // SQL query to insert new friend
            string query = "INSERT INTO Friends (Name, Email, Phone, Password) VALUES (@Name, @Email, @Phone, @Password)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Phone", phone);
                    cmd.Parameters.AddWithValue("@Password", password);

                    try
                    {
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        isRegistered = rowsAffected > 0;
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.ToString());  
                    }
                }
            }

            return isRegistered;
        }
    }
}
