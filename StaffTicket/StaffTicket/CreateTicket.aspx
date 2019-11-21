<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateTicket.aspx.cs" Inherits="CreateTicket" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
    <link rel="icon" type="image/png" href="images/icons/favicon.png" />
</head>
<body>
    <!-- Top Background Image Wrapper -->
    <form id="form1" runat="server">
        <div class="bgded overlay" style="background-image: url('../images/demo/bg.png');">
            <div class="wrapper row1">
                <header id="header" class="hoc clear">
                    <div id="logo" class="fl_left">
                        <h1>Create Ticket</h1>
                    </div>
                    <nav id="mainav" class="fl_right">
                        <ul class="clear">
                            <li>
                                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Show All</asp:LinkButton></li>
                        </ul>
                    </nav>                   
                </header>
            </div>

            <div class="content" style="padding-left: 100px; padding-right: 100px; padding-bottom: 300px;">
                <br />
                <div class="group btmspace-50">
                    <div class="one_third first">Email  </div>
                    <div class="two_quarter">
                        <asp:TextBox ID="email" runat="server" Width="500" Style="color: black;" required></asp:TextBox>
                    </div>
                </div>
                <div class="group btmspace-50 demo">
                    <div class="one_third first">Full Name</div>
                    <div class="one_half">
                        <asp:TextBox ID="name" runat="server" Width="500" Style="color: black;" required></asp:TextBox></div>
                </div>
                <div class="group btmspace-50 demo">
                    <div class="one_third first">Ticket Source</div>
                    <div class="one_half">
                        <asp:TextBox ID="source" runat="server" Width="500" Style="color: black;" required></asp:TextBox></div>
                </div>
                <div class="group btmspace-50 demo">
                    <div class="one_third first">Category</div>
                    <div class="one_half">
                        <asp:TextBox ID="category" runat="server" Width="500" Style="color: black;" required></asp:TextBox></div>
                </div>
                <div class="group btmspace-50 demo">
                    <div class="one_third first">Subject</div>
                    <div class="one_half">
                        <asp:TextBox ID="subject" runat="server" Width="500" Style="color: black;" required></asp:TextBox></div>
                </div>
                <div class="group btmspace-50 demo">
                    <div class="one_third first">Description</div>
                    <div class="one_half">
                        <textarea id="description" name="description" cols="60" rows="10" style="color: black;" required></textarea>
                    </div>
                </div>
                <div class="group btmspace-50 demo">
                    <div class="one_third first">Priority</div>
                    <div class="one_half">
                        <asp:TextBox ID="priority" runat="server" Width="500" Style="color: black;" required></asp:TextBox></div>
                </div>
                <div style="color: black;">
                    <asp:LinkButton ID="LinkButtonCreate" runat="server" OnClick="LinkButtonCreate_Click">Create Ticket</asp:LinkButton></div>
            </div>
    </form>
</body>
</html>
