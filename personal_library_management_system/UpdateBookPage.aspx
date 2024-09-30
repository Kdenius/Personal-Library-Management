<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateBookPage.aspx.cs" Inherits="personal_library_management_system.UpdateBookPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Update Book</title>
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
            <label for="TextBoxTitle">Title:</label>
            <asp:TextBox ID="TextBoxTitle" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorTitle" runat="server" ControlToValidate="TextBoxTitle"
                ErrorMessage="Title is required" CssClass="error"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="TextBoxAuthor">Author:</label>
            <asp:TextBox ID="TextBoxAuthor" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorAuthor" runat="server" ControlToValidate="TextBoxAuthor"
                ErrorMessage="Author is required" CssClass="error"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="TextBoxGenre">Genre:</label>
            <asp:TextBox ID="TextBoxGenre" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorGenre" runat="server" ControlToValidate="TextBoxGenre"
                ErrorMessage="Genre is required" CssClass="error"></asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label for="TextBoxISBN">ISBN:</label>
            <asp:TextBox ID="TextBoxISBN" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorISBN" runat="server" ControlToValidate="TextBoxISBN"
                ErrorMessage="ISBN is required" CssClass="error"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="ISBNValidator" runat="server" ControlToValidate="TextBoxISBN"
                ErrorMessage="ISBN must be exactly 6 digits" CssClass="error"
                ValidationExpression="^\d{6}$"></asp:RegularExpressionValidator>
        </div>
        <div class="form-group">
            <label for="TextBoxQuantity">Quantity:</label>
            <asp:TextBox ID="TextBoxQuantity" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorQuantity" runat="server" ControlToValidate="TextBoxQuantity"
                ErrorMessage="Quantity is required" CssClass="error"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="QuantityValidator" runat="server" ControlToValidate="TextBoxQuantity"
                ErrorMessage="Quantity must be a positive number" CssClass="error"
                MinimumValue="1" MaximumValue="1000" Type="Integer"></asp:RangeValidator>
        </div>
        <div class="form-group">
            <asp:Button ID="ButtonUpdate" runat="server" Text="Update" OnClick="ButtonUpdate_Click" CssClass="form-control" />
        </div>
        <div class="form-group">
            <asp:Label ID="LabelMessage" runat="server" CssClass="error"></asp:Label>
        </div>
    </form>
</body>
</html>
