<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WAPP_Assignment.Pages.Global.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .login-container {
            max-width: 450px;
            margin: 50px auto;
            text-align: center;
        }

        .login-title {
            font-size: 48px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .login-subtitle {
            font-size: 24px;
            color: #999;
            margin-bottom: 40px;
        }

        .login-box {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }

        .form-label {
            display: block;
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .form-input {
            width: 100%;
            padding: 15px;
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

        .btn-login {
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

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .register-link {
            margin-top: 20px;
            font-size: 16px;
            color: #666;
        }

        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
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

        .debug-bypass {
            margin-top: 30px;
            padding: 15px;
            background: #fff3cd;
            border: 2px solid #ffc107;
            border-radius: 10px;
            font-size: 14px;
            color: #856404;
        }

        .debug-bypass strong {
            color: #dc3545;
        }
    </style>

    <div class="login-container">
        <h1 class="login-title">Login Page</h1>
        <p class="login-subtitle">MathVenture</p>

        <div class="login-box">
            <!-- Error Message -->
            <asp:Panel ID="pnlError" runat="server" CssClass="error-message" Visible="false">
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Username -->
            <div class="form-group">
                <label class="form-label">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-input" placeholder="Enter your username"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                    ControlToValidate="txtUsername" 
                    ErrorMessage="Username is required" 
                    ForeColor="#c62828" 
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-input" placeholder="Enter your password"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="txtPassword" 
                    ErrorMessage="Password is required" 
                    ForeColor="#c62828" 
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </div>

            <!-- Login Button -->
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" OnClick="btnLogin_Click" />

            <!-- Register Link -->
            <div class="register-link">
                Don't have an account? 
                <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/Pages/Global/Register.aspx">Register here</asp:HyperLink>
            </div>

            <!-- DEBUG BYPASS - Remove this section for production -->
            <asp:Panel ID="pnlDebugBypass" runat="server" CssClass="debug-bypass" Visible="true">
                <strong>⚠️ DEBUG MODE ACTIVE</strong><br />
                Quick Login Bypass (Remove before production):<br />
                <asp:Button ID="btnDebugStudent" runat="server" Text="Login as Student" 
                    OnClick="btnDebugStudent_Click" CausesValidation="false"
                    style="margin: 10px 5px; padding: 8px 15px; background: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer;" />
                <asp:Button ID="btnDebugAdmin" runat="server" Text="Login as Admin" 
                    OnClick="btnDebugAdmin_Click" CausesValidation="false"
                    style="margin: 10px 5px; padding: 8px 15px; background: #2196F3; color: white; border: none; border-radius: 5px; cursor: pointer;" />
            </asp:Panel>
        </div>
    </div>
</asp:Content>