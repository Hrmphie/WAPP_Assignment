<%@ Page Title="Lessons - Pick Level" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LessonsLevel.aspx.cs" Inherits="WAPP_Assignment.Pages.Student.LessonsLevel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .level-container {
            text-align: center;
            padding: 30px;
        }

        .page-title {
            font-size: 48px;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .page-subtitle {
            font-size: 28px;
            color: #999;
            margin-bottom: 50px;
        }

        .levels-wrapper {
            display: flex;
            flex-direction: column;
            gap: 30px;
            align-items: center;
            max-width: 700px;
            margin: 0 auto;
        }

        .level-button {
            width: 100%;
            height: 120px;
            border-radius: 15px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
            padding: 20px 30px;
            text-decoration: none;
            color: white;
        }

        .level-button:hover {
            transform: translateX(10px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        .level-beginner {
            background: linear-gradient(135deg, #39b54a 0%, #8bc34a 100%);
        }

        .level-intermediate {
            background: linear-gradient(135deg, #ff9500 0%, #ffcc00 100%);
        }

        .level-advanced {
            background: linear-gradient(135deg, #ff3b30 0%, #ff6b6b 100%);
        }

        .level-icon {
            width: 80px;
            height: 80px;
            background: white;
            padding: 10px;
            border-radius: 10px;
            margin-right: 25px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .level-text {
            text-align: left;
            flex: 1;
        }

        .level-title {
            font-size: 32px;
            font-weight: bold;
            margin: 0;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
        }

        .level-description {
            font-size: 20px;
            margin: 5px 0 0 0;
            opacity: 0.9;
        }

        @media (max-width: 768px) {
            .levels-wrapper {
                max-width: 100%;
            }

            .level-button {
                height: auto;
                min-height: 100px;
            }

            .level-icon {
                width: 60px;
                height: 60px;
                margin-right: 15px;
            }

            .level-title {
                font-size: 24px;
            }

            .level-description {
                font-size: 16px;
            }
        }
    </style>

    <div class="level-container">
        <h1 class="page-title">Pick Level</h1>
        <p class="page-subtitle">Lessons</p>

        <div class="levels-wrapper">
            <!-- Level 1: Beginner -->
            <asp:LinkButton ID="btnLevel1" runat="server" CssClass="level-button level-beginner" OnClick="btnLevel1_Click">
                <img src="../../Content/images/lessons-easy.png" alt="Level 1" class="level-icon" />
                <div class="level-text">
                    <p class="level-title">Level 1</p>
                    <p class="level-description">Beginner</p>
                </div>
            </asp:LinkButton>

            <!-- Level 2: Intermediate -->
            <asp:LinkButton ID="btnLevel2" runat="server" CssClass="level-button level-intermediate" OnClick="btnLevel2_Click">
                <img src="../../Content/images/lessons-medium.png" alt="Level 2" class="level-icon" />
                <div class="level-text">
                    <p class="level-title">Level 2</p>
                    <p class="level-description">Intermediate</p>
                </div>
            </asp:LinkButton>

            <!-- Level 3: Advanced -->
            <asp:LinkButton ID="btnLevel3" runat="server" CssClass="level-button level-advanced" OnClick="btnLevel3_Click">
                <img src="../../Content/images/lessons-hard.png" alt="Level 3" class="level-icon" />
                <div class="level-text">
                    <p class="level-title">Level 3</p>
                    <p class="level-description">Advanced</p>
                </div>
            </asp:LinkButton>
        </div>
    </div>
</asp:Content>