<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StudentHome.aspx.cs" Inherits="WAPP_Assignment.Pages.Student.StudentHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .student-home-container {
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
            margin-bottom: 30px;
        }

        .buttons-container {
            display: flex;
            gap: 40px;
            justify-content: center;
            margin-top: 50px;
            flex-wrap: wrap;
        }

        .nav-button {
            width: 400px;
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

        .btn-lessons {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .btn-quizzes {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }

        .button-label {
            font-size: 42px;
            font-weight: bold;
            color: white;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .button-image {
            width: 200px;
            height: 200px;
            border-radius: 15px;
            background: white;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        /* Progress Section */
        .progress-section {
            margin: 40px 0;
            display: flex;             
            flex-direction: column;
            align-items: center;     
            justify-content: center;  
            text-align: center;
        }

        .progress-title {
            font-size: 28px;
            color: #667eea;
            margin-bottom: 18px;
            font-weight: bold;
        }


        .progress-bar-container {
            width: 100%;
            max-width: 500px;       
            height: 50px;
            background: #e0e0e0;
            border-radius: 25px;
            position: relative;
            overflow: hidden;
            cursor: pointer;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.1);
            display: block;
            text-decoration: none;
        }

        .progress-bar-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 25px;
            width: 0%;                
            transition: width 0.6s ease;
        }

        .progress-percentage {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            font-size: 18px;
            font-weight: bold;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            pointer-events: none;
            z-index: 2;
        }

        .progress-bar-container:hover {
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
            transform: scale(1.02);
        }

        @media (max-width: 968px) {
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

    <div class="student-home-container">
        <h1 class="welcome-text">Welcome, <asp:Label ID="lblUsername" runat="server" Text="Student"></asp:Label>!</h1>
        <p class="subtitle-text">Let's continue your math adventure!</p>

        <!-- Progress Section -->
        <div class="progress-section">
            <h2 class="progress-title">Your Learning Progress</h2>

            <asp:LinkButton ID="lnkProgress" runat="server"
                            CssClass="progress-bar-container"
                            OnClick="lnkProgress_Click">
                <div class="progress-percentage">
                    <asp:Label ID="lblProgressPercentage" runat="server" Text="0%"></asp:Label>
                </div>
                <div class="progress-bar-fill" id="progressBarFill" runat="server"></div>
            </asp:LinkButton>
        </div>

        <!-- Main Navigation Buttons -->
        <div class="buttons-container">
            <!-- Lessons Button -->
            <asp:LinkButton ID="btnLessons" runat="server" CssClass="nav-button btn-lessons" OnClick="btnLessons_Click">
                <span class="button-label">Lessons</span>
                <img src="../../Content/images/lessons.jpg" alt="Lessons" class="button-image" />
            </asp:LinkButton>

            <!-- Quizzes Button -->
            <asp:LinkButton ID="btnQuizzes" runat="server" CssClass="nav-button btn-quizzes" OnClick="btnQuizzes_Click">
                <span class="button-label">Quizzes</span>
                <img src="../../Content/images/quizzes.jpg" alt="Quizzes" class="button-image" />
            </asp:LinkButton>
        </div>
    </div>
</asp:Content>