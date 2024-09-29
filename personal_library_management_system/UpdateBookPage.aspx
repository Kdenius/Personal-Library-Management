<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateBookPage.aspx.cs" Inherits="personal_library_management_system.UpdateBookPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Update Book</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Title:&nbsp;
            <asp:TextBox ID="TextBoxTitle" runat="server"></asp:TextBox>
            <br />
            <br />
            Author:&nbsp;
            <asp:TextBox ID="TextBoxAuthor" runat="server"></asp:TextBox>
            <br />
            <br />
            Genre:&nbsp;
            <asp:TextBox ID="TextBoxGenre" runat="server"></asp:TextBox>
            <br />
            <br />
            ISBN:&nbsp;
            <asp:TextBox ID="TextBoxISBN" runat="server"></asp:TextBox>
            <br />
            <br />
            Quantity:&nbsp;
            <asp:TextBox ID="TextBoxQuantity" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="ButtonUpdate" runat="server" Text="Update" OnClick="ButtonUpdate_Click" />
            <asp:Label ID="LabelMessage" ForeColor="Red" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
