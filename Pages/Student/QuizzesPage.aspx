<%@ Page Title="Quiz" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuizzesPage.aspx.cs" Inherits="WAPP_Assignment.Pages.Student.QuizzesPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .quiz-container {
            padding: 30px 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .quiz-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .quiz-level-title {
            font-size: 42px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .quiz-level-subtitle {
            font-size: 24px;
            color: #999;
        }

        .questions-wrapper {
            display: flex;
            gap: 30px;
            justify-content: space-between;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }

        .question-card {
            flex: 1;
            min-width: 300px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .question-number {
            font-size: 22px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 15px;
        }

        .question-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 20px;
            background: white;
            padding: 15px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .question-text {
            font-size: 18px;
            color: #333;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .options-container {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .option-item {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            background: white;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .option-item:hover {
            background: #e8f4ff;
            transform: translateX(5px);
        }

        .option-item input[type="radio"] {
            margin-right: 12px;
            cursor: pointer;
            width: 20px;
            height: 20px;
        }

        .option-label {
            font-size: 16px;
            color: #333;
            cursor: pointer;
            flex: 1;
        }

        .submit-section {
            text-align: center;
            margin-top: 40px;
        }

        .submit-button {
            padding: 18px 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 22px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .submit-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        .error-message {
            color: #e74c3c;
            font-size: 16px;
            margin-top: 15px;
            font-weight: 600;
        }

        @media (max-width: 968px) {
            .questions-wrapper {
                flex-direction: column;
            }

            .question-card {
                min-width: 100%;
            }
        }
    </style>

    <div class="quiz-container">
        <!-- Header -->
        <div class="quiz-header">
            <h1 class="quiz-level-title">
                <asp:Label ID="lblLevelTitle" runat="server" Text="Level 1"></asp:Label>
            </h1>
            <p class="quiz-level-subtitle">
                <asp:Label ID="lblLevelSubtitle" runat="server" Text="Beginner Quiz"></asp:Label>
            </p>
        </div>

        <!-- Questions -->
        <div class="questions-wrapper">
            <!-- Question 1 -->
            <div class="question-card">
                <div class="question-number">Question 1</div>
                <img id="imgQuestion1" runat="server" src="" alt="Question 1" class="question-image" />
                <p class="question-text">
                    <asp:Label ID="lblQuestion1" runat="server" Text="What is 2 + 2?"></asp:Label>
                </p>
                <asp:RadioButtonList ID="rblQuestion1" runat="server" CssClass="options-container">
                    <asp:ListItem Value="A" CssClass="option-item">
                        <span class="option-label">A. 3</span>
                    </asp:ListItem>
                    <asp:ListItem Value="B" CssClass="option-item">
                        <span class="option-label">B. 4</span>
                    </asp:ListItem>
                    <asp:ListItem Value="C" CssClass="option-item">
                        <span class="option-label">C. 5</span>
                    </asp:ListItem>
                    <asp:ListItem Value="D" CssClass="option-item">
                        <span class="option-label">D. 6</span>
                    </asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <!-- Question 2 -->
            <div class="question-card">
                <div class="question-number">Question 2</div>
                <img id="imgQuestion2" runat="server" src="../../Content/images/quiz-easy-2.png" alt="Question 2" class="question-image" />
                <p class="question-text">
                    <asp:Label ID="lblQuestion2" runat="server" Text="What is 5 - 3?"></asp:Label>
                </p>
                <asp:RadioButtonList ID="rblQuestion2" runat="server" CssClass="options-container">
                    <asp:ListItem Value="A" CssClass="option-item">
                        <span class="option-label">A. 1</span>
                    </asp:ListItem>
                    <asp:ListItem Value="B" CssClass="option-item">
                        <span class="option-label">B. 2</span>
                    </asp:ListItem>
                    <asp:ListItem Value="C" CssClass="option-item">
                        <span class="option-label">C. 3</span>
                    </asp:ListItem>
                    <asp:ListItem Value="D" CssClass="option-item">
                        <span class="option-label">D. 4</span>
                    </asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <!-- Question 3 -->
            <div class="question-card">
                <div class="question-number">Question 3</div>
                <img id="imgQuestion3" runat="server" src="https://via.placeholder.com/300x200/ff9a9e/ffffff?text=Question+3" alt="Question 3" class="question-image" />
                <p class="question-text">
                    <asp:Label ID="lblQuestion3" runat="server" Text="What is 3 × 2?"></asp:Label>
                </p>
                <asp:RadioButtonList ID="rblQuestion3" runat="server" CssClass="options-container">
                    <asp:ListItem Value="A" CssClass="option-item">
                        <span class="option-label">A. 5</span>
                    </asp:ListItem>
                    <asp:ListItem Value="B" CssClass="option-item">
                        <span class="option-label">B. 6</span>
                    </asp:ListItem>
                    <asp:ListItem Value="C" CssClass="option-item">
                        <span class="option-label">C. 7</span>
                    </asp:ListItem>
                    <asp:ListItem Value="D" CssClass="option-item">
                        <span class="option-label">D. 8</span>
                    </asp:ListItem>
                </asp:RadioButtonList>
            </div>
        </div>

        <!-- Submit Section -->
        <div class="submit-section">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit Quiz" CssClass="submit-button" OnClick="btnSubmit_Click" />
            <div>
                <asp:Label ID="lblError" runat="server" CssClass="error-message" Visible="false"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>