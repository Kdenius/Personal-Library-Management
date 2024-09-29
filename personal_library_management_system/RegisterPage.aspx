<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterPage.aspx.cs" Inherits="personal_library_management_system.RegisterPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Name:&nbsp;
            <asp:TextBox ID="TextBoxName" runat="server"></asp:TextBox>
            <br />
            <br />
            Email:&nbsp;
            <asp:TextBox ID="TextBoxEmail" runat="server"></asp:TextBox>
            <br />
            <br />
            Phone:&nbsp;
            <asp:TextBox ID="TextBoxPhone" runat="server"></asp:TextBox>
            <br />
            <br />
            Password:&nbsp;
            <asp:TextBox ID="TextBoxPassword" TextMode="Password" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="ButtonRegister" Text="Register" OnClick="ButtonRegister_Click" runat="server" />
            <br />
            <br />
            <asp:HyperLink ID="hp1" runat="server" NavigateUrl="~/LoginPage.aspx">already have account?</asp:HyperLink>
            <br />
            <asp:Label ID="LabelMessage" ForeColor="Red" runat="server"></asp:Label>
            <br />
        </div>
    </form>
</body>
</html>
