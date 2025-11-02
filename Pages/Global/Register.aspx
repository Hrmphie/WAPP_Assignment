<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WAPP_Assignment.Pages.Global.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .register-container {
            max-width: 500px;
            margin: 30px auto;
            text-align: center;
        }

        .register-title {
            font-size: 48px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .register-subtitle {
            font-size: 24px;
            color: #999;
            margin-bottom: 30px;
        }

        .register-box {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-label {
            display: block;
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
        }

        .form-input {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: 2px solid #ddd;
            border-radius: 10px;
            box-sizing: border-box;
            font-family: 'Comic Sans MS', 'Arial', sans-serif;
            transition: border-color 0.3s;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .gender-group {
            display: flex;
            gap: 20px;
            margin-top: 8px;
        }

        .gender-option {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 16px;
            color: #333;
        }

        .gender-option input[type="radio"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .btn-register {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            font-family: 'Comic Sans MS', 'Arial', sans-serif;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .login-link {
            margin-top: 20px;
            font-size: 16px;
            color: #666;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .success-message {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .validator-text {
            color: #c62828;
            font-size: 13px;
            margin-top: 4px;
            display: block;
        }
    </style>

    <div class="register-container">
        <h1 class="register-title">Register</h1>
        <p class="register-subtitle">MathVenture</p>

        <div class="register-box">
            <!-- Error Message -->
            <asp:Panel ID="pnlError" runat="server" CssClass="error-message" Visible="false">
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Success Message -->
            <asp:Panel ID="pnlSuccess" runat="server" CssClass="success-message" Visible="false">
                <asp:Label ID="lblSuccess" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Email -->
            <div class="form-group">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" placeholder="your.email@example.com"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                    ControlToValidate="txtEmail" 
                    ErrorMessage="Email is required" 
                    CssClass="validator-text"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                    ControlToValidate="txtEmail"
                    ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                    ErrorMessage="Please enter a valid email address"
                    CssClass="validator-text"
                    Display="Dynamic">
                </asp:RegularExpressionValidator>
            </div>

            <!-- Username -->
            <div class="form-group">
                <label class="form-label">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-input" placeholder="Choose a username"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                    ControlToValidate="txtUsername" 
                    ErrorMessage="Username is required" 
                    CssClass="validator-text"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </div>

            <!-- Age -->
            <div class="form-group">
                <label class="form-label">Age</label>
                <asp:TextBox ID="txtAge" runat="server" CssClass="form-input" TextMode="Number" placeholder="Enter your age"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="rfvAge" runat="server" 
                    ControlToValidate="txtAge" 
                    ErrorMessage="Age is required" 
                    CssClass="validator-text"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
                <asp:RangeValidator ID="rvAge" runat="server" 
                    ControlToValidate="txtAge"
                    MinimumValue="5"
                    MaximumValue="120"
                    Type="Integer"
                    ErrorMessage="Age must be between 5 and 120"
                    CssClass="validator-text"
                    Display="Dynamic">
                </asp:RangeValidator>
            </div>

            <!-- Gender -->
            <div class="form-group">
                <label class="form-label">Gender</label>
                <asp:RadioButtonList ID="rblGender" runat="server" CssClass="gender-group" RepeatDirection="Horizontal">
                    <asp:ListItem Value="Male" Selected="True">Male</asp:ListItem>
                    <asp:ListItem Value="Female">Female</asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-input" placeholder="Create a password"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="txtPassword" 
                    ErrorMessage="Password is required" 
                    CssClass="validator-text"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </div>

            <!-- Confirm Password -->
            <div class="form-group">
                <label class="form-label">Confirm Password</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-input" placeholder="Re-enter your password"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                    ControlToValidate="txtConfirmPassword" 
                    ErrorMessage="Please confirm your password" 
                    CssClass="validator-text"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvPassword" runat="server" 
                    ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtPassword"
                    ErrorMessage="Passwords do not match"
                    CssClass="validator-text"
                    Display="Dynamic">
                </asp:CompareValidator>
            </div>

            <!-- Register Button -->
            <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-register" OnClick="btnRegister_Click" />

            <!-- Login Link -->
            <div class="login-link">
                Already have an account? 
                <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="~/Pages/Global/Login.aspx">Login here</asp:HyperLink>
            </div>
        </div>
    </div>
</asp:Content>