using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace personal_library_management_system
{
    public partial class UpdateBookPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int bookID;
                if (int.TryParse(Request.QueryString["BookID"], out bookID))
                {
                    LoadBookDetails(bookID);
                }
                else
                {
                    LabelMessage.Text = "Invalid Book ID.";
                }
            }
        }

        private void LoadBookDetails(int bookID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString;
            string query = "SELECT Title, Author, Genre, ISBN, Quantity FROM Books WHERE BookID = @BookID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@BookID", bookID);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        TextBoxTitle.Text = reader["Title"].ToString();
                        TextBoxAuthor.Text = reader["Author"].ToString();
                        TextBoxGenre.Text = reader["Genre"].ToString();
                        TextBoxISBN.Text = reader["ISBN"].ToString();
                        TextBoxQuantity.Text = reader["Quantity"].ToString();
                    }
                    else
                    {
                        LabelMessage.Text = "Book not found.";
                    }
                }
            }
        }

        protected void ButtonUpdate_Click(object sender, EventArgs e)
        {
            int bookID;
            if (int.TryParse(Request.QueryString["BookID"], out bookID))
            {
                string title = TextBoxTitle.Text.Trim();
                string author = TextBoxAuthor.Text.Trim();
                string genre = TextBoxGenre.Text.Trim();
                string isbn = TextBoxISBN.Text.Trim();
                int quantity;
                bool isQuantityValid = int.TryParse(TextBoxQuantity.Text.Trim(), out quantity);

                if (isQuantityValid)
                {
                    UpdateBook(bookID, title, author, genre, isbn, quantity);
                    Response.Redirect("BookManagePage.aspx");
                }
                else
                {
                    LabelMessage.Text = "Invalid quantity.";
                }
            }
            else
            {
                LabelMessage.Text = "Invalid Book ID.";
            }
        }

        private void UpdateBook(int bookID, string title, string author, string genre, string isbn, int quantity)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString;
            string query = "UPDATE Books SET Title = @Title, Author = @Author, Genre = @Genre, ISBN = @ISBN, Quantity = @Quantity WHERE BookID = @BookID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@BookID", bookID);
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
