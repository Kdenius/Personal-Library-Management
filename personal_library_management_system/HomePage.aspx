<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="personal_library_management_system.HomePage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home Page</title>
    <script type="text/javascript">
        function openBorrowModal(bookID) {
            document.getElementById('<%= HiddenFieldBookID.ClientID %>').value = bookID;
            document.getElementById('borrowModal').style.display = 'block';
            document.getElementById('modalBackdrop').style.display = 'block';
        }

        function closeBorrowModal() {
            document.getElementById('borrowModal').style.display = 'none';
            document.getElementById('modalBackdrop').style.display = 'none';
        }
    </script>
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

        #borrowModal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background-color: white;
            border: 1px solid #ccc;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        #modalBackdrop {
            display: none;
            position: fixed;
            z-index: 900;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .error-label {
            color: red;
            margin-top: 10px;
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <!-- GridView for All Books -->
            <h2>All Available Books:</h2><br />
            <asp:GridView ID="GridViewAllBooks" runat="server" AutoGenerateColumns="False" OnRowCommand="GridViewAllBooks_RowCommand"
                DataKeyNames="BookID" Width="852px">
                <Columns>
                    <asp:BoundField DataField="BookID" HeaderText="ID" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="Author" HeaderText="Author" />
                    <asp:BoundField DataField="Genre" HeaderText="Genre" />
                    <asp:BoundField DataField="ISBN" HeaderText="ISBN" />
                    <asp:BoundField DataField="QuantityAvailable" HeaderText="Quantity" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button 
                                ID="ButtonBorrow" 
                                runat="server" 
                                CommandName="Borrow" 
                                CommandArgument='<%# Container.DataItemIndex %>' 
                                Text="Borrow" 
                                CssClass="btn"
                                OnClientClick='<%# "if (" + Eval("QuantityAvailable") + " > 0)  openBorrowModal(" + Eval("BookID") + "); return false;" %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <!-- Modal Backdrop -->
            <div id="modalBackdrop"></div>

            <!-- Modal for Borrowing -->
            <div id="borrowModal">
                <h3>Borrow Book</h3>
                <label for="txtDays">Number of Days:</label>
                <asp:TextBox ID="txtDays" runat="server"></asp:TextBox>
                <br />
                <asp:Button ID="btnConfirmBorrow" runat="server" Text="Confirm" CssClass="btn" OnClick="btnConfirmBorrow_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClientClick="closeBorrowModal(); return false;" />
                <asp:HiddenField ID="HiddenFieldBookID" runat="server" />
            </div>
            <asp:Label ID="lblerror" runat="server" CssClass="error-label"></asp:Label>
            <br />
            <!-- GridView for Borrowed Books -->
            <h2>Borrowed Books:</h2>
            <br />
            <asp:GridView ID="GridViewBorrowedBooks" runat="server" AutoGenerateColumns="False" OnRowCommand="GridViewBorrowedBooks_RowCommand"
                DataKeyNames="BorrowID" style="margin-right: 0px">
                <Columns>
                    <asp:BoundField DataField="BorrowID" HeaderText="Borrow ID" ReadOnly="True" Visible="False" />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="Author" HeaderText="Author" />
                    <asp:BoundField DataField="Genre" HeaderText="Genre" />
                    <asp:BoundField DataField="BorrowDate" HeaderText="Borrow Date" />
                    <asp:BoundField DataField="ReturnDate" HeaderText="Return Date" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="ButtonReturn" runat="server" CommandName="Return" CommandArgument='<%# Container.DataItemIndex %>' Text="Return" CssClass="btn" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <br />
        <br />
        <asp:Button ID="ButtonLogout" runat="server" Text="Logout" CssClass="btn" OnClick="ButtonLogout_Click" />
    </form>
</body>
</html>
