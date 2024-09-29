using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace personal_library_management_system
{
    public partial class AddBookPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Any logic for page load
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            string title = TextBoxTitle.Text;
            string author = TextBoxAuthor.Text;
            string genre = TextBoxGenre.Text;
            string isbn = TextBoxISBN.Text;
            int quantity;
            bool isQuantityValid = int.TryParse(TextBoxQuantity.Text, out quantity);

            if (isQuantityValid)
            {
                AddBook(title, author, genre, isbn, quantity);
                Response.Redirect("BookManagePage.aspx");
            }
            else
            {
                LabelMessage.Text = "Invalid quantity.";
            }
        }

        private void AddBook(string title, string author, string genre, string isbn, int quantity)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString;
            string query = "INSERT INTO Books (Title, Author, Genre, ISBN, Quantity) VALUES (@Title, @Author, @Genre, @ISBN, @Quantity)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Author", author);
                    cmd.Parameters.AddWithValue("@Genre", genre);
                    cmd.Parameters.AddWithValue("@ISBN", isbn);
                    cmd.Parameters.AddWithValue("@Quantity", quantity);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}
