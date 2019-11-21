<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SpecficTicket.aspx.cs" Inherits="SpecficTicket" %>

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
<body id="top">
    <!-- Top Background Image Wrapper -->
    <form id="form1" runat="server">
        <div class="bgded overlay" style="background-image: url('../images/demo/bg.png');">
            <div class="wrapper row1">
                <header id="header" class="hoc clear">
                    <div id="logo" class="fl_left">
                        <h1>Specific Ticket</h1>
                    </div>
                    <nav id="mainav" class="fl_right">
                        <ul class="clear" style="padding-top: 30px; padding-bottom: 20px">
                            <li>
                                <asp:Button ID="ButtonDelete" runat="server" Text="Delete" OnClick="ButtonDelete_Click" Style="background-color: Transparent;" /></li>
                            <li>
                                <asp:Button ID="ButtonDashboard" runat="server" Text="Dashboard" OnClick="ButtonDashboard_Click" Style="background-color: Transparent;" /></li>
                        </ul>

                    </nav>
                </header>
            </div>
            <div style="padding-left: 100px; padding-right: 100px; padding-top: 50px">
                <div class="group btmspace-50">
                    <div class="one_quarter first">Ticket ID</div>
                    <div class="one_quarter">
                        <asp:Label ID="TicketLabel" runat="server" Text="Ticket ID"></asp:Label>
                    </div>
                    <div class="one_quarter">Name</div>
                    <div class="one_quarter">
                        <asp:Label ID="NameLabel" runat="server" Text="Name"></asp:Label>
                    </div>
                </div>
                <div class="group btmspace-50">
                    <div class="one_quarter first">Email</div>
                    <div class="one_quarter">
                        <asp:Label ID="EmailLabel" runat="server" Text="Email"></asp:Label>
                    </div>
                    <div class="one_quarter">Assign To</div>
                    <div class="one_quarter">
                        <asp:Label ID="AssignLabel" runat="server" Text="Assign"></asp:Label>
                    </div>
                </div>
                <div class="group btmspace-50">
                    <div class="one_quarter first">Creation Date</div>
                    <div class="one_quarter">
                        <asp:Label ID="CreationLabel" runat="server" Text="Creation Date"></asp:Label>
                    </div>
                    <div class="one_quarter">Closing Date</div>
                    <div class="one_quarter">
                        <asp:Label ID="ClosingLabel" runat="server" Text="Closing Date"></asp:Label>
                    </div>
                </div>
                <div class="group btmspace-50">
                    <div class="one_quarter first">Ticket Source</div>
                    <div class="one_quarter">
                        <asp:Label ID="SourceLabel" runat="server" Text="Ticket Source"></asp:Label>
                    </div>
                    <div class="one_quarter">Category</div>

                    <div class="one_quarter">
                        <asp:Label ID="CategoryLabel" runat="server" Text="Category"></asp:Label>

                    </div>
                </div>
                <div class="group btmspace-50">
                    <div class="one_quarter first">Priority</div>
                    <div class="one_quarter">
                        <asp:Label ID="PriorityLabel" runat="server" Text="Priority"></asp:Label>
                    </div>
                    <div class="one_quarter">Ticket Status</div>
                    <div class="one_quarter">
                        <asp:Label ID="Labelts" runat="server" Text="Ticket Status"></asp:Label>
                    </div>
                </div>
                <div class="group btmspace-50">
                    <div class="one_third first">Subject</div>
                    <div class="two_quarter">
                        <asp:Label ID="SubjectLabel" runat="server" Text="Subject"></asp:Label>
                    </div>

                </div>
            </div>
            <div style="padding-left: 100px; padding-right: 100px; padding-top: 50px">
                <div class="group btmspace-50">
                    
                    <h2 style="padding-top: 20px; padding-left: 70px;">Activities</h2>
                    <div style="padding-left: 100px; padding-right: 100px; padding-bottom: 50px;">
                        <asp:ListView ID="ListView1" runat="server">
                            <ItemTemplate>
                                <div id="comments">

                                    <ul style="color: black;">
                                        <li>
                                            <article>
                                                <header>
                                                    <figure class="avatar">
                                                        <span class="unm"><%# Eval("ActorName")%></span><img src="../images/demo/avatar.png" alt="">
                                                    </figure>
                                                    <address>
                                                        <span><%# Eval("ActivityType")%></span>   <a href="#"><span><%# Eval("ActivityDate")%></a>
                                                    </address>
                                                    <span><%# Eval("Summary")%></span>
                                                </header>
                                                <div class="comcont">
                                                    <p><span><%# Eval("Description")%></span></p>
                                                </div>
                                            </article>
                                        </li>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                    <div style="padding-left: 100px; padding-right: 100px; padding-bottom: 50px;">
                        <h2>Post Reply</h2>
                        <div class="block clear">
                            <label for="comment">Your Reply</label>
                            <textarea id="TextArea1" name="TextArea1" cols="130" rows="20" style="color: black;"></textarea>
                        </div>
                        <div style="padding-top: 30px; color: black;">
                            <asp:Button ID="submit" runat="server" Text="Post Reply" OnClick="submit_Click"/>
                        </div>
                    </div>
                </div>
    </form>

</body>
</html>
