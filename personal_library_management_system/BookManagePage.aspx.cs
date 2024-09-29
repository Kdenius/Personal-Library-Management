using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace personal_library_management_system
{
    public partial class BookManagePage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBooks();
                BindBorrowedBooks();
                BindOutDatedBooks();
            }
        }

        private void BindBooks()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString;
            string query = "SELECT BookID, Title, Author, Genre, ISBN, Quantity FROM Books";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        GridViewBooks.DataSource = dt;
                        GridViewBooks.DataBind();
                    }
                }
            }
        }

        private void BindBorrowedBooks()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString;
            string query = @"SELECT 
                            b.BookID,
                            b.Title,
                            f.Name AS FriendName,
                            bb.BorrowDate,
                            bb.ReturnDate
                        FROM 
                            BorrowedBooks bb
                        INNER JOIN 
                            Books b ON bb.BookID = b.BookID
                        INNER JOIN 
                            Friends f ON bb.FriendID = f.FriendID"; // Filtering for books that have not been returned
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        GridViewBorrowedBooks.DataSource = dt;
                        GridViewBorrowedBooks.DataBind();
                    }
                }
            }
        }

        private void BindOutDatedBooks()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString);
           string query = @"Select 
                b.BookID,
                b.Title,
                bb.ReturnDate,
                f.Name,
                f.Email,
                f.Phone,
                DATEDIFF(day, ReturnDate, GETDATE()) AS DaysLate
            FROM 
                BorrowedBooks bb
            inner join
                Books b on b.BookID = bb.BookID
            inner join
                Friends f on f.FriendID = bb.FriendID
            WHERE 
                ReturnDate < GETDATE()";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    GridViewOutDate.DataSource = dt;
                    GridViewOutDate.DataBind();
                }
            }
        }

        protected void GridViewBooks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Update")
            {
                int bookID = Convert.ToInt32(e.CommandArgument);
                // Redirect to update page or open a form to update the book
                Response.Redirect($"UpdateBookPage.aspx?BookID={bookID}");
            }
            else if (e.CommandName == "Delete")
            {
                int bookID = Convert.ToInt32(e.CommandArgument);
                DeleteBook(bookID);
            }
        }

        private void DeleteBook(int bookID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString;
            string query = "DELETE FROM Books WHERE BookID = @BookID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@BookID", bookID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            Response.Redirect("BookManagePage.aspx");
        }

        protected void ButtonAdd_Click(object sender, EventArgs e)
        {
            // Redirect to the add book page or open a form to add a new book
            Response.Redirect("AddBookPage.aspx");
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginPage.aspx");
        }
    }
}
