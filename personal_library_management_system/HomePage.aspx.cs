using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace personal_library_management_system
{
    public partial class HomePage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAllBooks();
                BindBorrowedBooks();
            }
        }

        private void BindAllBooks()
        {
            if (Session["FriendID"] == null)
            {
                throw new InvalidOperationException("FriendID is not set in session.");
            }

            int friendID = Convert.ToInt32(Session["FriendID"]);
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString;
            /*     string query = @"SELECT b.BookID, b.Title, b.Author, b.Genre, b.ISBN, b.Quantity 
                                  FROM Books b
                                  WHERE b.BookID NOT IN (
                                      SELECT bb.BookID 
                                      FROM BorrowedBooks bb
                                      WHERE bb.FriendID = @FriendID AND bb.ReturnDate = 0
                                  )";*/
            string query = @"SELECT
                            b.[BookID],
                            b.[Title],
                            b.[Author],
                            b.[Genre],
                            b.[ISBN],
                            b.[Quantity] - COUNT(bb.[BorrowID]) AS [QuantityAvailable]
                        FROM
                            [dbo].[Books] b
                        LEFT JOIN
                            [dbo].[BorrowedBooks] bb ON b.[BookID] = bb.[BookID]
                        GROUP BY
                            b.[BookID],b.[Title], b.[ISBN], b.[Quantity], b.[Author], b.[Genre]";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    //cmd.Parameters.AddWithValue("@FriendID", friendID);

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        GridViewAllBooks.DataSource = dt;
                        GridViewAllBooks.DataBind();
                    }
                }
            }
        }

        private void BindBorrowedBooks()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString;
            string query = @"SELECT *
                             FROM BorrowedBooks bb
                             INNER JOIN Books b ON bb.BookID = b.BookID
                             WHERE bb.FriendID = @FriendID";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FriendID", Session["FriendID"]);
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

        protected void GridViewAllBooks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Borrow")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int bookID = Convert.ToInt32(GridViewAllBooks.DataKeys[rowIndex].Value);
                
                    HiddenFieldBookID.Value = bookID.ToString();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "openBorrowModal(" + bookID + ");", true);
            }
        }

        protected void btnConfirmBorrow_Click(object sender, EventArgs e)
        {
            int bookID = Convert.ToInt32(HiddenFieldBookID.Value);
            int daysBorrowed = Convert.ToInt32(txtDays.Text);
            BorrowBook(bookID, daysBorrowed);
            BindBorrowedBooks();
            BindAllBooks(); // Refresh all books to reflect updated availability

            ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal", "closeBorrowModal();", true);
        }

        private void BorrowBook(int bookID, int daysBorrowed)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString;
            string query = "INSERT INTO BorrowedBooks (BookID, FriendID, ReturnDate, DaysBorrowed) VALUES (@BookID, @FriendID, @ReturnDate, @DaysBorrowed)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@BookID", bookID);
                    cmd.Parameters.AddWithValue("@FriendID", Session["FriendID"]);
                    cmd.Parameters.AddWithValue("@ReturnDate", DateTime.Now.AddDays(daysBorrowed));
                    cmd.Parameters.AddWithValue("@DaysBorrowed", daysBorrowed);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void GridViewBorrowedBooks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Return")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int borrowID = Convert.ToInt32(GridViewBorrowedBooks.DataKeys[rowIndex].Value);

                ReturnBook(borrowID);
                BindBorrowedBooks();
                BindAllBooks();
            }
        }

        private void ReturnBook(int borrowID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LibraryContext"].ConnectionString;
            string query = "DELETE from BorrowedBooks WHERE BorrowID = @BorrowID";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    //cmd.Parameters.AddWithValue("@ReturnDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@BorrowID", borrowID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
        protected void ButtonLogout_Click(object sender, EventArgs e)
        {
            // Clear session data
            Session.Clear();
            Session.Abandon();

            // Redirect to login page
            Response.Redirect("LoginPage.aspx");
        }

    }
}
