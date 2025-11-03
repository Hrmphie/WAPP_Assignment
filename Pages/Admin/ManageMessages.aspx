<%@ Page Title="Manage Messages" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageMessages.aspx.cs" Inherits="WAPP_Assignment.Pages.Admin.ManageMessages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .manage-messages-container {
            padding: 30px 20px;
            max-width: 1000px;
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

        .stats-bar {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 40px;
            padding: 20px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 15px;
            flex-wrap: wrap;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 36px;
            font-weight: bold;
            color: #667eea;
        }

        .stat-label {
            font-size: 16px;
            color: #666;
            margin-top: 5px;
        }

        .messages-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .message-item {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.2s ease;
        }

        .message-item:hover {
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .message-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
            gap: 20px;
        }

        .message-sender-info {
            flex: 1;
        }

        .message-sender-name {
            font-size: 22px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }

        .message-sender-email {
            font-size: 16px;
            color: #666;
            margin-bottom: 5px;
        }

        .message-date {
            font-size: 14px;
            color: #999;
        }

        .message-subject {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
            padding: 10px;
            background: rgba(255, 255, 255, 0.5);
            border-radius: 8px;
        }

        .message-body {
            font-size: 16px;
            color: #555;
            line-height: 1.8;
            padding: 15px;
            background: white;
            border-radius: 8px;
            margin-bottom: 15px;
            white-space: pre-wrap;
        }

        .message-actions {
            display: flex;
            justify-content: flex-end;
        }

        .btn-delete-message {
            padding: 10px 25px;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);
            color: white;
            border: none;
            border-radius: 20px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .btn-delete-message:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        .no-messages {
            text-align: center;
            padding: 60px 20px;
            font-size: 22px;
            color: #999;
        }

        .no-messages-icon {
            font-size: 72px;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .message-header {
                flex-direction: column;
            }

            .stats-bar {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>

    <div class="manage-messages-container">
        <!-- Header -->
        <div class="page-header">
            <h1 class="page-title">Manage Messages</h1>
            <p class="page-subtitle">View and manage contact form submissions</p>
        </div>

        <!-- Statistics Bar -->
        <div class="stats-bar">
            <div class="stat-item">
                <div class="stat-number">
                    <asp:Label ID="lblTotalMessages" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Total Messages</div>
            </div>
        </div>

        <!-- Messages List -->
        <asp:Panel ID="pnlMessagesList" runat="server" CssClass="messages-list">
            <asp:Repeater ID="rptMessages" runat="server" OnItemCommand="rptMessages_ItemCommand">
                <ItemTemplate>
                    <div class="message-item">
                        <div class="message-header">
                            <div class="message-sender-info">
                                <div class="message-sender-name"><%# Eval("Name") %></div>
                                <div class="message-sender-email">📧 <%# Eval("Email") %></div>
                                <div class="message-date">
                                    Received: <%# Eval("DateSubmitted", "{0:MMM dd, yyyy hh:mm tt}") %>
                                </div>
                            </div>
                        </div>
                        
                        <div class="message-subject">
                            📋 Subject: <%# Eval("Subject") %>
                        </div>
                        
                        <div class="message-body">
                            <%# Eval("Message") %>
                        </div>
                        
                        <div class="message-actions">
                            <asp:Button ID="btnDelete" runat="server" 
                                Text="🗑️ Delete" 
                                CssClass="btn-delete-message"
                                CommandName="DeleteMessage"
                                CommandArgument='<%# Eval("MessageID") %>'
                                OnClientClick="return confirm('Are you sure you want to delete this message?');"
                                CausesValidation="false" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>

        <!-- No Messages Message -->
        <asp:Panel ID="pnlNoMessages" runat="server" CssClass="no-messages" Visible="false">
            <div class="no-messages-icon">✉️</div>
            <p>No messages received yet.</p>
            <p style="font-size: 18px; margin-top: 10px;">Messages from the Contact form will appear here.</p>
        </asp:Panel>
    </div>
</asp:Content>