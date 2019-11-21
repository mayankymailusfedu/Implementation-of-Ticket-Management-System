<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Blocklist.aspx.cs" Inherits="Blocklist" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="images/icons/favicon.png" />
</head>
<body id="top">
    <!-- Top Background Image Wrapper -->
    <form id="form1" runat="server">
        <div class="bgded overlay" style="background-image: url('../images/demo/bg.png');">
            <!-- ################################################################################################ -->
            <div class="wrapper row1">
                <header id="header" class="hoc clear">
                    <!-- ################################################################################################ -->
                    <div id="logo" class="fl_left">

                        <h1>Staff Dashboard</h1>
                    </div>
                    <nav id="mainav" class="fl_right">
                        <ul class="clear">
                            <li>
                                <asp:LinkButton ID="LinkButtonShow" runat="server" OnClick="LinkButtonShow_Click">Show All</asp:LinkButton></li>
                        </ul>
                    </nav>
                    <!-- ################################################################################################ -->
                </header>
            </div>
                        <div style="padding-left: 100px; padding-right: 100px; padding-top: 50px;">
                <div class="group btmspace-50">
                    <div class="one_third first">Add Email</div>
                    <div class="one_third" style="color: black;">
                        <asp:TextBox ID="aeinput" runat="server" Width="370" required></asp:TextBox>
                        
                    </div>
                    <div class="one_third">
                        <asp:LinkButton ID="aeLinkButton" runat="server" OnClick="aeLinkButton_Click">Add</asp:LinkButton></div>
                </div>
            </div>
            <div style="padding-left: 100px; padding-right: 100px; padding-bottom: 300px; color:black;">
                <br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="Blocklist ID"/>
                        <asp:BoundField DataField="em" HeaderText="Email" />
                        <asp:TemplateField HeaderText="Remove">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButtonRemove" OnClick="LinkButtonRemove_Click" runat="server">Remove</asp:LinkButton>
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    

                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
