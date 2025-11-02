<%@ Page Title="My Progress" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Progress.aspx.cs" Inherits="WAPP_Assignment.Pages.Student.Progress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .progress-container {
            padding: 30px 20px;
            max-width: 900px;
            margin: 0 auto;
        }

        .progress-header {
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
            font-size: 24px;
            color: #666;
            margin-bottom: 30px;
        }

        .overall-stats {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 20px;
            margin-bottom: 40px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 48px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 18px;
            opacity: 0.9;
        }

        .attempts-title {
            font-size: 32px;
            color: #333;
            font-weight: bold;
            margin-bottom: 25px;
            text-align: center;
        }

        .attempts-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .attempt-item {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 15px;
            padding: 25px 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: transform 0.2s ease;
        }

        .attempt-item:hover {
            transform: translateX(5px);
        }

        .attempt-info {
            flex: 1;
        }

        .attempt-level {
            font-size: 24px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 8px;
        }

        .attempt-date {
            font-size: 16px;
            color: #666;
        }

        .attempt-score {
            text-align: right;
        }

        .score-number {
            font-size: 36px;
            font-weight: bold;
            color: #2ecc71;
        }

        .score-label {
            font-size: 14px;
            color: #666;
            margin-top: 5px;
        }

        .no-attempts {
            text-align: center;
            padding: 60px 20px;
            font-size: 22px;
            color: #999;
        }

        .no-attempts-icon {
            font-size: 72px;
            margin-bottom: 20px;
        }

        .back-button {
            display: inline-block;
            padding: 15px 40px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-size: 18px;
            font-weight: 600;
            margin-top: 30px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border: none;
            cursor: pointer;
        }

        .back-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        @media (max-width: 768px) {
            .attempt-item {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .attempt-score {
                text-align: center;
            }

            .overall-stats {
                flex-direction: column;
            }
        }
    </style>

    <div class="progress-container">
        <!-- Header -->
        <div class="progress-header">
            <h1 class="page-title">My Progress</h1>
            <p class="page-subtitle">Track your learning journey!</p>
        </div>

        <!-- Overall Statistics -->
        <div class="overall-stats">
            <div class="stat-item">
                <div class="stat-number">
                    <asp:Label ID="lblTotalAttempts" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Total Quizzes</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">
                    <asp:Label ID="lblAverageScore" runat="server" Text="0"></asp:Label>%
                </div>
                <div class="stat-label">Average Score</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">
                    <asp:Label ID="lblCompletionRate" runat="server" Text="0"></asp:Label>%
                </div>
                <div class="stat-label">Completion Rate</div>
            </div>
        </div>

        <!-- Quiz History Title -->
        <h2 class="attempts-title">Quiz History</h2>

        <!-- Quiz Attempts List -->
        <asp:Panel ID="pnlAttempts" runat="server" CssClass="attempts-list">
            <asp:Repeater ID="rptAttempts" runat="server">
                <ItemTemplate>
                    <div class="attempt-item">
                        <div class="attempt-info">
                            <div class="attempt-level">
                                Level <%# Eval("Level") %> - <%# GetLevelName(Eval("Level")) %>
                            </div>
                            <div class="attempt-date">
                                Completed: <%# Eval("DateCompleted", "{0:MMM dd, yyyy hh:mm tt}") %>
                            </div>
                        </div>
                        <div class="attempt-score">
                            <div class="score-number"><%# Eval("Score") %>/<%# Eval("TotalQuestions") %></div>
                            <div class="score-label">
                                <%# Math.Round((Convert.ToDouble(Eval("Score")) / Convert.ToDouble(Eval("TotalQuestions"))) * 100) %>%
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>

        <!-- No Attempts Message -->
        <asp:Panel ID="pnlNoAttempts" runat="server" CssClass="no-attempts" Visible="false">
            <div class="no-attempts-icon">📚</div>
            <p>You haven't completed any quizzes yet!</p>
            <p style="font-size: 18px; margin-top: 10px;">Start your learning journey by taking a quiz.</p>
        </asp:Panel>

        <!-- Back Button -->
        <div style="text-align: center;">
            <asp:Button ID="btnBack" runat="server" Text="← Back to Home" CssClass="back-button" OnClick="btnBack_Click" />
        </div>
    </div>
</asp:Content>