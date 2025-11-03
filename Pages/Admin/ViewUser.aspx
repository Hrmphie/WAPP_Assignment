<%@ Page Title="View User" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewUser.aspx.cs" Inherits="WAPP_Assignment.Pages.Admin.ViewUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .view-user-container {
            max-width: 700px;
            margin: 40px auto;
            padding: 20px;
        }

        .user-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .user-title {
            font-size: 48px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .user-subtitle {
            font-size: 18px;
            color: #999;
        }

        .user-details-box {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .detail-row {
            display: flex;
            padding: 15px 0;
            border-bottom: 2px solid rgba(255, 255, 255, 0.5);
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            width: 150px;
            flex-shrink: 0;
        }

        .detail-value {
            font-size: 18px;
            color: #666;
            flex: 1;
        }

        .role-badge {
            display: inline-block;
            padding: 6px 15px;
            border-radius: 15px;
            font-size: 14px;
            font-weight: bold;
        }

        .role-student {
            background: #e3f2fd;
            color: #1976d2;
        }

        .role-admin {
            background: #fce4ec;
            color: #c2185b;
        }

        .actions-section {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin-top: 30px;
        }

        .btn-action {
            padding: 15px 40px;
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

        .btn-back {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);
            color: white;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        .confirmation-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .confirmation-box {
            background: white;
            padding: 40px;
            border-radius: 20px;
            max-width: 500px;
            text-align: center;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }

        .confirmation-title {
            font-size: 28px;
            color: #ff6b6b;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .confirmation-message {
            font-size: 18px;
            color: #666;
            margin-bottom: 30px;
        }

        .confirmation-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        @media (max-width: 768px) {
            .detail-row {
                flex-direction: column;
                gap: 5px;
            }

            .detail-label {
                width: 100%;
            }

            .actions-section {
                flex-direction: column;
            }

            .btn-action {
                width: 100%;
            }
        }
    </style>

    <div class="view-user-container">
        <!-- User Header -->
        <div class="user-header">
            <h1 class="user-title">
                <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
            </h1>
            <p class="user-subtitle">
                Registered: <asp:Label ID="lblDateRegistered" runat="server" Text="Date"></asp:Label>
            </p>
        </div>

        <!-- User Details Box -->
        <div class="user-details-box">
            <div class="detail-row">
                <span class="detail-label">Email:</span>
                <span class="detail-value">
                    <asp:Label ID="lblEmail" runat="server" Text="email@example.com"></asp:Label>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Username:</span>
                <span class="detail-value">
                    <asp:Label ID="lblUsernameDetail" runat="server" Text="username"></asp:Label>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Age:</span>
                <span class="detail-value">
                    <asp:Label ID="lblAge" runat="server" Text="0"></asp:Label> years old
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Gender:</span>
                <span class="detail-value">
                    <asp:Label ID="lblGender" runat="server" Text="Gender"></asp:Label>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Role:</span>
                <span class="detail-value">
                    <asp:Label ID="lblRole" runat="server" CssClass="role-badge role-student" Text="Student"></asp:Label>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">User ID:</span>
                <span class="detail-value">
                    <asp:Label ID="lblUserID" runat="server" Text="0"></asp:Label>
                </span>
            </div>
        </div>

        <!-- Actions -->
        <div class="actions-section">
            <asp:Button ID="btnBack" runat="server" Text="← Back to Users" CssClass="btn-action btn-back" OnClick="btnBack_Click" CausesValidation="false" />
            <asp:Button ID="btnDelete" runat="server" Text="🗑️ Delete User" CssClass="btn-action btn-delete" OnClientClick="return confirmDelete();" OnClick="btnDelete_Click" CausesValidation="false" />
        </div>
    </div>

    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this user?\n\nThis action cannot be undone!");
        }
    </script>
</asp:Content>