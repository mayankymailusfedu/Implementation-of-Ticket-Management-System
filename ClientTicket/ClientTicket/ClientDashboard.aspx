<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientDashboard.aspx.cs" Inherits="ClientDashboard" %>

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
    <form id="form1" runat="server">
        <div class="bgded overlay" style="background-image: url('../images/demo/bg.png');">
            <div class="wrapper row1">
                <header id="header" class="hoc clear">
                    <div id="logo" class="fl_left">
                        <h1>Client Dashboard</h1>
                    </div>
                    <nav id="mainav" class="fl_right">
                        <ul class="clear">
                            <li>
                                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Show All</asp:LinkButton></li>
                            <li>
                                <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" >Create Ticket</asp:LinkButton></li>
                            <li>
                                <asp:LinkButton ID="LinkButton4" runat="server" OnClick="LinkButton4_Click">Logout</asp:LinkButton></li>
                        </ul>
                    </nav>
                </header>
            </div>

            <div style="padding-left: 100px; padding-right: 100px; padding-bottom: 300px;">
                <br />
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="ticketid" HeaderText="Ticket ID" />
                        <asp:BoundField DataField="email" HeaderText="E-mail" />
                        <asp:BoundField DataField="subject" HeaderText="Subject" />
                        <asp:BoundField DataField="creationdate" HeaderText="Creation Date" />
                        <asp:BoundField DataField="assignto" HeaderText="Assign To" />
                        <asp:BoundField DataField="ticketstatus" HeaderText="Ticket Status" />
                        <asp:BoundField DataField="priority" HeaderText="Priority" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButtonSelect" runat="server" OnClick="LinkButtonSelect_Click">Select</asp:LinkButton>
                                <asp:HiddenField ID="HiddenFieldTicketID" runat="server" Value='<%# Eval("ticketid") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />

                </asp:GridView>
            </div>
    </form>
</body>
</html>