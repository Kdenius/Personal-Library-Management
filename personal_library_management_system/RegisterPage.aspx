<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterPage.aspx.cs" Inherits="personal_library_management_system.RegisterPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
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
            <label for="TextBoxName">Name:</label>
            <asp:TextBox ID="TextBoxName" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorName" runat="server" ControlToValidate="TextBoxName"
                ErrorMessage="Name is required" CssClass="error"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="TextBoxEmail">Email:</label>
            <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="TextBoxEmail"
                ErrorMessage="Invalid email format" CssClass="error"
                ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ControlToValidate="TextBoxEmail"
                ErrorMessage="Email is required" CssClass="error"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="TextBoxPhone">Phone:</label>
            <asp:TextBox ID="TextBoxPhone" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RegularExpressionValidator ID="PhoneValidator" runat="server" ControlToValidate="TextBoxPhone"
                ErrorMessage="Invalid phone number" CssClass="error"
                ValidationExpression="^\d{10}$"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorPhone" runat="server" ControlToValidate="TextBoxPhone"
                ErrorMessage="Phone number is required" CssClass="error"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="TextBoxPassword">Password:</label>
            <asp:TextBox ID="TextBoxPassword" TextMode="Password" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server" ControlToValidate="TextBoxPassword"
                ErrorMessage="Password is required" CssClass="error"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="PasswordValidator" runat="server" ControlToValidate="TextBoxPassword"
                ErrorMessage="Password must be at least 4 characters long" CssClass="error"
                ValidationExpression=".{4,}"></asp:RegularExpressionValidator>
        </div>
        <div class="form-group">
            <asp:Button ID="ButtonRegister" Text="Register" OnClick="ButtonRegister_Click" runat="server" CssClass="form-control" />
        </div>
        <div class="form-group">
            <asp:HyperLink ID="hp1" runat="server" NavigateUrl="~/LoginPage.aspx">Already have an account?</asp:HyperLink>
        </div>
        <div class="form-group">
            <asp:Label ID="LabelMessage" runat="server" CssClass="error"></asp:Label>
        </div>
    </form>
</body>
</html>
