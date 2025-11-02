<%@ Page Title="Quiz Submitted" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Submitted.aspx.cs" Inherits="WAPP_Assignment.Pages.Student.Submitted" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .submitted-container {
            text-align: center;
            padding: 60px 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 500px;
        }

        .success-title {
            font-size: 56px;
            color: #2ecc71;
            font-weight: bold;
            margin-bottom: 20px;
            animation: fadeInScale 0.6s ease-out;
        }

        .success-message {
            font-size: 24px;
            color: #666;
            margin-bottom: 30px;
        }

        .score-display {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 50px;
            border-radius: 20px;
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 40px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .success-image {
            width: 300px;
            height: 300px;
            margin-bottom: 40px;
            animation: bounce 1s ease-in-out;
        }

        .home-button {
            padding: 18px 50px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 22px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            display: inline-block;
        }

        .home-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        @keyframes fadeInScale {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        .confetti {
            font-size: 48px;
            margin-bottom: 20px;
            animation: rotate 2s linear infinite;
        }

        @keyframes rotate {
            from {
                transform: rotate(0deg);
            }
            to {
                transform: rotate(360deg);
            }
        }
    </style>

    <div class="submitted-container">
        <div class="confetti">🎉</div>
        <h1 class="success-title">Submitted Successfully!</h1>
        
        <div class="score-display">
            Your Score: <asp:Label ID="lblScore" runat="server" Text="0"></asp:Label> / <asp:Label ID="lblTotal" runat="server" Text="3"></asp:Label>
        </div>

        <p class="success-message">Great job on completing the quiz!</p>

        <img src="https://via.placeholder.com/300/2ecc71/ffffff?text=🌟" alt="Success" class="success-image" />

        <asp:Button ID="btnReturnHome" runat="server" Text="🏠 Return Home" CssClass="home-button" OnClick="btnReturnHome_Click" />
    </div>
</asp:Content>