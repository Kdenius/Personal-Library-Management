<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookManagePage.aspx.cs" Inherits="personal_library_management_system.BookManagePage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Books</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 20px;
            color: #333;
        }

        h2 {
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }

        .borrowed-books-div {
            background-color: #e9ecef;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #dee2e6;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e9ecef;
        }

        .btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .link-email {
            color: #007bff;
            text-decoration: none;
        }

        .link-email:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form runat="server">
        <div>
            <h2>All Books:</h2>
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
                            <asp:Button ID="ButtonUpdate" runat="server" CommandName="Update" CommandArgument='<%# Eval("BookID") %>' Text="Update" CssClass="btn" />
                            <asp:Button ID="ButtonDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("BookID") %>' Text="Delete" CssClass="btn" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <asp:Button ID="ButtonAdd" runat="server" Text="Add New Book" OnClick="ButtonAdd_Click" CssClass="btn" />
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
        <h2>Out Dated Books</h2>
        <asp:GridView ID="GridViewOutDate" runat="server" AutoGenerateColumns="False" Width="1125px">
            <Columns>
                <asp:BoundField DataField="BookID" HeaderText="Book Id" />
                <asp:BoundField HeaderText="Title" DataField="Title">
                    <ItemStyle ForeColor="Red" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Friend Name" DataField="Name" />
                <asp:BoundField HeaderText="Email" DataField="Email" />
                <asp:BoundField HeaderText="Phone" DataField="Phone" />
                <asp:BoundField DataField="DaysLate" HeaderText="Delayed Day">
                    <ItemStyle ForeColor="Red" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="toEmail">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLinkEmail" runat="server" 
                            NavigateUrl='<%# String.Format("mailto:{0}?subject=Book%20Return%20Reminder&body={1}%20days%20have%20passed%20after%20return%20date%20but%20you%20have%20not%20returned%20the%20book%20%27{2}%27", Eval("Email"), Eval("DaysLate"), Eval("Title")) %>' 
                            Text='<%# Eval("Email") %>' CssClass="link-email"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
        All Friends
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="FriendID" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="FriendID" HeaderText="FriendID" InsertVisible="False" ReadOnly="True" SortExpression="FriendID" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                <asp:BoundField DataField="RegistrationDate" HeaderText="RegistrationDate" SortExpression="RegistrationDate" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [FriendID], [Name], [Email], [Phone], [RegistrationDate] FROM [Friends]"></asp:SqlDataSource>
        <br />
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="Author" HeaderText="Author" />
                <asp:BoundField DataField="BorrowDate" HeaderText="Borrow Date" />
                <asp:BoundField DataField="ReturnDate" HeaderText="Return Date" />
            </Columns>
        </asp:GridView>        
        <asp:Button ID="btnLogout" runat="server" Text="Go Back" OnClick="BtnLogout_Click" CssClass="btn" />
    </form>
</body>
</html>
