<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="personal_library_management_system.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Enter Email:&nbsp;
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            <br />
            Enter Password:
            <asp:TextBox ID="TextBox2" TextMode="Password" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button1" Text="Login" OnClick="Button1_Click" runat="server" />
            <br />
            <br />
            <asp:HyperLink ID="hp1" runat="server" NavigateUrl="~/RegisterPage.aspx" Target="_blank">do not have account ?</asp:HyperLink>
            <br />
            <asp:Label ID="LabelMessage" ForeColor="Red" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
