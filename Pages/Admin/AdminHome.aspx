<%@ Page Title="Admin Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="WAPP_Assignment.Pages.Admin.AdminHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .admin-home-container {
            text-align: center;
            padding: 20px;
        }

        .welcome-text {
            font-size: 36px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .subtitle-text {
            font-size: 20px;
            color: #666;
            margin-bottom: 50px;
        }

        .admin-badge {
            display: inline-block;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .buttons-container {
            display: flex;
            gap: 40px;
            justify-content: center;
            margin-top: 50px;
            flex-wrap: wrap;
        }

        .nav-button {
            width: 350px;
            height: 350px;
            border-radius: 20px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 30px;
            text-decoration: none;
        }

        .nav-button:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3);
        }

        .btn-manage-users {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .btn-manage-messages {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .button-label {
            font-size: 32px;
            font-weight: bold;
            color: white;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .button-image {
            width: 180px;
            height: 180px;
            border-radius: 15px;
            background: white;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        @media (max-width: 1100px) {
            .buttons-container {
                flex-direction: column;
                align-items: center;
            }

            .nav-button {
                width: 100%;
                max-width: 400px;
            }
        }
    </style>

    <div class="admin-home-container">
        <div class="admin-badge">👤 ADMINISTRATOR</div>
        <h1 class="welcome-text">Welcome, <asp:Label ID="lblUsername" runat="server" Text="Admin"></asp:Label>!</h1>
        <p class="subtitle-text">Admin Dashboard - Manage MathVenture</p>

        <!-- Main Navigation Buttons -->
        <div class="buttons-container">
            <!-- Manage Users Button -->
            <asp:LinkButton ID="btnManageUsers" runat="server" CssClass="nav-button btn-manage-users" OnClick="btnManageUsers_Click">
                <span class="button-label">Manage Users</span>
                <img src="../../Content/images/manage-users.png" alt="Manage Users" class="button-image" />
            </asp:LinkButton>

            <!-- Manage Messages Button -->
            <asp:LinkButton ID="btnManageMessages" runat="server" CssClass="nav-button btn-manage-messages" OnClick="btnManageMessages_Click">
                <span class="button-label">Manage Messages</span>
                <img src="../../Content/images/view-messages.png" alt="Manage Messages" class="button-image" />
            </asp:LinkButton>
        </div>
    </div>
</asp:Content>