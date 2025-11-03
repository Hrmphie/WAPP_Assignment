<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="WAPP_Assignment.Pages.Admin.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .manage-users-container {
            padding: 30px 20px;
            max-width: 900px;
            margin: 0 auto;
        }

        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .page-title {
            font-size: 48px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .page-subtitle {
            font-size: 20px;
            color: #666;
        }

        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 15px;
        }

        .total-users {
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }

        .btn-register-new {
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 25px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            display: inline-block;
        }

        .btn-register-new:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        .users-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .user-item {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 15px;
            padding: 25px 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .user-item:hover {
            transform: translateX(5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .user-info {
            flex: 1;
        }

        .user-username {
            font-size: 24px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }

        .user-email {
            font-size: 16px;
            color: #666;
            margin-bottom: 5px;
        }

        .user-date {
            font-size: 14px;
            color: #999;
        }

        .user-role-badge {
            padding: 6px 15px;
            border-radius: 15px;
            font-size: 14px;
            font-weight: bold;
            margin-left: 20px;
        }

        .role-student {
            background: #e3f2fd;
            color: #1976d2;
        }

        .role-admin {
            background: #fce4ec;
            color: #c2185b;
        }

        .no-users {
            text-align: center;
            padding: 60px 20px;
            font-size: 22px;
            color: #999;
        }

        .no-users-icon {
            font-size: 72px;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .user-item {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .user-role-badge {
                margin-left: 0;
            }

            .actions-bar {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>

    <div class="manage-users-container">
        <!-- Header -->
        <div class="page-header">
            <h1 class="page-title">Manage Users</h1>
            <p class="page-subtitle">View and manage all registered users</p>
        </div>

        <!-- Actions Bar -->
        <div class="actions-bar">
            <div class="total-users">
                Total Users: <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
            </div>
            <asp:HyperLink ID="lnkRegisterNew" runat="server" NavigateUrl="~/Pages/Global/Register.aspx?source=admin" CssClass="btn-register-new">
                ➕ Register New User
            </asp:HyperLink>
        </div>

        <!-- Users List -->
        <asp:Panel ID="pnlUsersList" runat="server" CssClass="users-list">
            <asp:Repeater ID="rptUsers" runat="server" OnItemCommand="rptUsers_ItemCommand">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkUser" runat="server" CssClass="user-item" 
                                    CommandName="ViewUser" 
                                    CommandArgument='<%# Eval("UserID") %>'>
                        <div class="user-info">
                            <div class="user-username"><%# Eval("Username") %></div>
                            <div class="user-email">📧 <%# Eval("Email") %></div>
                            <div class="user-date">
                                Registered: <%# Eval("DateRegistered", "{0:MMM dd, yyyy hh:mm tt}") %>
                            </div>
                        </div>
                        <div class='<%# Eval("Role").ToString() == "Admin" ? "user-role-badge role-admin" : "user-role-badge role-student" %>'>
                            <%# Eval("Role") %>
                        </div>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>

        <!-- No Users Message -->
        <asp:Panel ID="pnlNoUsers" runat="server" CssClass="no-users" Visible="false">
            <div class="no-users-icon">👥</div>
            <p>No users found in the system.</p>
            <p style="font-size: 18px; margin-top: 10px;">Click "Register New User" to add users.</p>
        </asp:Panel>
    </div>
</asp:Content>