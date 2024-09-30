<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="personal_library_management_system.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <style>
        .error {
            color: red;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-control {
            padding: 10px;
            width: 100%;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-group">
            <label for="TextBox1">Enter Email:</label>
            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="TextBox1"
                ErrorMessage="Invalid email format" CssClass="error"
                ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                ErrorMessage="Email is required" CssClass="error"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="TextBox2">Enter Password:</label>
            <asp:TextBox ID="TextBox2" TextMode="Password" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
                ErrorMessage="Password is required" CssClass="error"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="PasswordValidator" runat="server" ControlToValidate="TextBox2"
                ErrorMessage="Password must be at least 4 characters long" CssClass="error"
                ValidationExpression=".{4,}"></asp:RegularExpressionValidator>
        </div>
        <div class="form-group">
            <asp:Button ID="Button1" Text="Login" OnClick="Button1_Click" runat="server" CssClass="form-control" />
        </div>
        <div class="form-group">
            <asp:HyperLink ID="hp1" runat="server" NavigateUrl="~/RegisterPage.aspx" Target="_blank">Do not have an account?</asp:HyperLink>
        </div>
        <div class="form-group">
            <asp:Label ID="LabelMessage" runat="server" CssClass="error"></asp:Label>
        </div>
    </form>
</body>
</html>
