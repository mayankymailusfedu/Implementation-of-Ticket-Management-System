<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientRegistration.aspx.cs" Inherits="ClientRegistration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="images/icons/favicon.png" />
    <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
    <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
    <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
    <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
    <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
    <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" type="text/css" href="css/util.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
    <div class="limiter">
        <div class="container-login100">
            <div class="wrap-login100">
                <form id="form1" runat="server" class="login100-form validate-form">
                    <span class="login100-form-title p-b-34">Client Registration
                        <img src="images/icons/favicon.png" height="100" alt="Logo" />
                    </span>

                    <div class="wrap-input100 rs1-wrap-input100 validate-input m-b-20" data-validate="Type Full Name">
                        <asp:TextBox ID="Fullname" class="input100" type="text" name="Fullname" placeholder="Full Name" runat="server" required></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>
                    <div class="wrap-input100 rs1-wrap-input100 validate-input m-b-20" data-validate="Type Gender">
                        <asp:TextBox ID="Gender" class="input100" type="text" name="Gender" placeholder="Gender" runat="server" required></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>
                    <div class="wrap-input100 rs1-wrap-input100 validate-input m-b-20" data-validate="Type Emal">
                        <asp:TextBox ID="username" class="input100" type="text" name="username" placeholder="Email" runat="server" required></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>
                    <div class="wrap-input100 rs2-wrap-input100 validate-input m-b-20" data-validate="Type password">
                        <asp:TextBox ID="pass_word" class="input100" type="password" name="pass_word" placeholder="Password" runat="server" required></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>
                    <div class="wrap-input100 rs2-wrap-input100 validate-input m-b-20" data-validate="Type password">
                        <asp:TextBox ID="confirmpassword" class="input100" type="password" name="confirmpassword" placeholder="Confirm Password" required runat="server"></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>
                    <div class="wrap-input100 rs1-wrap-input100 validate-input m-b-20" data-validate="Type Street Address">
                        <asp:TextBox ID="StreetAddress1" class="input100" type="text" name="StreetAddress1" placeholder="Street Address 1" required runat="server"></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>
                    <div class="wrap-input100 rs1-wrap-input100 validate-input m-b-20" data-validate="Type Street Address">
                        <asp:TextBox ID="StreetAddress2" class="input100" type="text" name="StreetAddress2" placeholder="Street Address 2" required runat="server"></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>
                    <div class="wrap-input100 rs1-wrap-input100 validate-input m-b-20" data-validate="Type City">
                        <asp:TextBox ID="City" class="input100" type="text" name="City" placeholder="City" runat="server" required></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>
                    <div class="wrap-input100 rs1-wrap-input100 validate-input m-b-20" data-validate="Type State">
                        <asp:TextBox ID="State" class="input100" type="text" name="State" placeholder="State" runat="server" required></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>
                    <div class="wrap-input100 rs1-wrap-input100 validate-input m-b-20" data-validate="Type Country">
                        <asp:TextBox ID="Country" class="input100" type="text" name="Country" placeholder="Country" runat="server" required></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>
                    <div class="wrap-input100 rs1-wrap-input100 validate-input m-b-20" data-validate="Type Zip">
                        <asp:TextBox ID="Zip" class="input100" type="text" name="Zip" placeholder="Zip" runat="server" required></asp:TextBox>
                        <span class="focus-input100"></span>
                    </div>

                    <div class="container-login100-form-btn">
                        <asp:Button ID="Signup" class="login100-form-btn" runat="server" Text="Sign Up" OnClick="Signup_Click" />
                    </div>

                    <div class="w-full text-center p-t-27 p-b-239">
                    </div>

                    <div class="w-full text-center">
                        <asp:LinkButton ID="signin" class="txt3" runat="server" OnClick="signin_Click">Sign In</asp:LinkButton>
                    </div>
                </form>
                <div class="login100-more" style="background-image: url('images/bg-03.jpg');"></div>
            </div>
        </div>
    </div>



    <div id="dropDownSelect1"></div>

    <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
    <script src="vendor/animsition/js/animsition.min.js"></script>
    <script src="vendor/bootstrap/js/popper.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/select2/select2.min.js"></script>
    <script>
        $(".selection-2").select2({
            minimumResultsForSearch: 20,
            dropdownParent: $('#dropDownSelect1')
        });
    </script>
    <script src="vendor/daterangepicker/moment.min.js"></script>
    <script src="vendor/daterangepicker/daterangepicker.js"></script>
    <script src="vendor/countdowntime/countdowntime.js"></script>
    <script src="js/main.js"></script>
</body>
</html>

