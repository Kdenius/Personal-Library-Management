<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookManagePage.aspx.cs" Inherits="personal_library_management_system.BookManagePage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Books</title>
    <style>
        .borrowed-books-div {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <div>
            <h2>All Books: </h2>
            <br />
            <asp:GridView ID="GridViewBooks" runat="server" AutoGenerateColumns="False" OnRowCommand="GridViewBooks_RowCommand">
                <Columns>
                    <asp:BoundField DataField="BookID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="Author" HeaderText="Author" />
                    <asp:BoundField DataField="Genre" HeaderText="Genre" />
                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="ButtonUpdate" runat="server" CommandName="Update" CommandArgument='<%# Eval("BookID") %>' Text="Update" />
                            <asp:Button ID="ButtonDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("BookID") %>' Text="Delete" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <asp:Button ID="ButtonAdd" runat="server" Text="Add New Book" OnClick="ButtonAdd_Click" />
            <br />
        </div>
        <div class="borrowed-books-div">
            <h2>Borrowed Books Details</h2>
            <asp:GridView ID="GridViewBorrowedBooks" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="BookID" HeaderText="Book ID" ReadOnly="True" />
                    <asp:BoundField DataField="FriendName" HeaderText="Friend Name" />
                    <asp:BoundField DataField="BorrowDate" HeaderText="Borrow Date" />
                    <asp:BoundField DataField="ReturnDate" HeaderText="Return Date" />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                </Columns>
            </asp:GridView>
        </div>

        <br />
        <br />
        <h2>Out Dated Books</h2>
        <asp:GridView ID="GridViewOutDate" runat="server" AutoGenerateColumns="False" Width="1125px">
    <Columns>
        <asp:BoundField DataField="BookID" HeaderText="Book Id" />
        <asp:BoundField HeaderText="Title" DataField="Title" >
        <ItemStyle ForeColor="Red" />
        </asp:BoundField>
        <asp:BoundField HeaderText="Friend Name" DataField="Name" />
        <asp:BoundField HeaderText="Email" DataField="Email" />
        <asp:BoundField HeaderText="Phone" DataField="Phone" />
        <asp:BoundField DataField="DaysLate" HeaderText="Delayed Day" >
        <ItemStyle ForeColor="Red" />
        </asp:BoundField>
        <asp:TemplateField HeaderText="toEmail">
            <ItemTemplate>
                <asp:HyperLink ID="HyperLinkEmail" runat="server" 
                NavigateUrl='<%# String.Format("mailto:{0}?subject=Book%20Return%20Reminder&body={1}%20days%20have%20passed%20after%20return%20date%20but%20you%20have%20not%20returned%20the%20book%20%27{2}%27", Eval("Email"), Eval("DaysLate"), Eval("Title")) %>'                               Text='<%# Eval("Email") %>'></asp:HyperLink>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

        <br />
        <br />
        
        <asp:Button ID="btnLogout" runat="server" Text="Go Back" OnClick="BtnLogout_Click" />
    </form>
</body>
</html>
