<%-- 
    Document   : login
    Created on : Apr 6, 2023, 12:42:43 PM
    Author     : vkloo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="/part/link.html" %>
        <link rel="stylesheet" href="./src/css/main.css">
        <title>Petto Shop</title>
        <style>
            .content .container {
                padding: 20px 20px 50px 20px;
            }

            input {
                border-radius: 7px;
                text-align: left;
                padding: 5px 8px;
                width: 100%;
                border: 1.5px solid #333333;
                outline: none;
            }
            input:focus {
                border: solid 3px lightsalmon;
                transition: 0.2s;
                box-shadow: 0 2px 4px peachpuff;
            }

            .inputform {
                border-radius: 10px;
                padding: 20px 15px 20px 15px;
                border: solid 2px bisque;
                box-shadow: 0 2px 8px peachpuff;
                transition: .1s;
            }
            .SocialItem {
                text-align: center;
            }
            .SocialItem i{
                padding-top: 20px;
                padding-left: 30px;
                padding-right: 30px;
                padding-bottom: 20px;
                font-size: 2em;
                cursor: pointer;
            }
            .line-center{
                margin:0;
                padding:0 10px;
                background:#fff;
                display:inline-block;
            }
            #or{
                text-align:center;
                position:relative;
                z-index:2;
            }
            #or:after{
                content:"";
                position:absolute;
                top:50%;
                left:0;
                right:0;
                border-top:solid 1px peachpuff;
                z-index:-1;
            }
            #signup {
                text-align: center;
                background-color: papayawhip;
                border-radius: 5px;
                padding: 5px 10px 5px 10px;
                border: 2px solid lightsalmon;
                font-family: Arial, Helvetica, sans-serif;
                font-weight: bold;
                color: lightsalmon;
                transition: .2s;
            }
            #signup:hover {
                background-color: peachpuff;
                padding: 5px 10px 5px 10px;
                text-shadow:
                    0 0 1px lightsalmon,
                    0 0 5px lightsalmon;
                color: #F97561;
            }

            .links{
                color: lightsalmon;
            }

            .links:hover {
                color: peachpuff;
            }

        </style>
    </head>
    <body>
        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>
        <!<!-- Content -->
        <div class="content container mt-3" style="max-width: 700px;">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10 col-12">
                    <form class="inputform" action="registerCustomerServlet" method="POST">
                        <h2 style="text-align: center;">Sign up with</h2>
                        <div class="SocialItem">
                            <i class="fa-brands fa-google" style="color: lightsalmon;"></i>
                            <i class="fa-brands fa-facebook" style="color: lightsalmon;"></i>
                            <i class="fa-brands fa-twitter" style="color: lightsalmon;"></i>
                        </div>
                        <h3 id="or"><span  class="line-center">Or</span></h3>
                        <div class="d-flex flex-column">
                            <div class="p-2">
                                <h5>Username</h5>
                                <input type="text" name="uname" value="" required/>
                                <% if (session.getAttribute("regErrUname") != null) {%>
                                <span class="text-danger ps-2"><i class="fa-solid fa-triangle-exclamation pe-2"></i><%=session.getAttribute("regErrUname")%></span>
                                <% session.removeAttribute("regErrUname");
                                    }%>
                            </div>
                            <div class="p-2">
                                <h5>First name</h5>
                                <input type="text" name="fname" value="" required/>
                                <% if (session.getAttribute("regErrFname") != null) {%>
                                <span class="text-danger ps-2"><i class="fa-solid fa-triangle-exclamation pe-2"></i><%=session.getAttribute("regErrFname")%></span>
                                <% session.removeAttribute("regErrFname");
                                    }%>
                            </div>
                            <div class="p-2">
                                <h5>Last name</h5>
                                <input type="text" name="lname" value="" required/>   
                                <% if (session.getAttribute("regErrLname") != null) {%>
                                <span class="text-danger ps-2"><i class="fa-solid fa-triangle-exclamation pe-2"></i><%=session.getAttribute("regErrLname")%></span>
                                <% session.removeAttribute("regErrLname");
                                    }%>
                            </div>
                            <div class="p-2">
                                <h5>Email address</h5>
                                <input type="email" name="email" value="" required/>
                                <% if (session.getAttribute("regErrEmail") != null) {%>
                                <span class="text-danger ps-2"><i class="fa-solid fa-triangle-exclamation pe-2"></i><%=session.getAttribute("regErrEmail")%></span>
                                <% session.removeAttribute("regErrEmail");
                                    }%>
                            </div>
                            <div class="p-2">
                                <h5>Password</h5>
                                <input id="passwd" type="password" name="passwd" value="" required/>
                                <% if (session.getAttribute("regErrPass") != null) {%>
                                <span class="text-danger ps-2"><i class="fa-solid fa-triangle-exclamation pe-2"></i><%=session.getAttribute("regErrPass")%></span>
                                <% session.removeAttribute("regErrPass");
                                    }%>
                            </div>
                            <div class="p-2">
                                <h5>Retype password</h5>
                                <input id="rpasswd" type="password" name="rpasswd" value="" required/>
                                <% if (session.getAttribute("regErrRpass") != null) {%>
                                <span class="text-danger ps-2"><i class="fa-solid fa-triangle-exclamation pe-2"></i><%=session.getAttribute("regErrRpass")%></span>
                                <% session.removeAttribute("regErrRpass");
                                    }%>
                            </div>
                            <div class="p-2">
                                <input type="checkbox" name="terms&condition" value="OFF" style="width:20px" required/>
                                You must accept the <a class="links" href="termCondition.jsp">Terms & Condition</a> and <a class="links" href="privacy.jsp">Privacy Policy</a> for further action.
                            </div>
                            <div class="p-2" style="text-align:center;">
                                <input id="signup" type="submit" name="submit" value="Sign up"/>
                            </div>
                            <div class="p-2" style="text-align:center;">
                                <a class="links" href="login.jsp">Already have an account? </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div id="footer"><div id="header">
                <%@include file="./part/footer.jsp" %>
            </div></div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
    </body>
    <%@include file="/part/script.html" %>
    <script>
        var passwd = document.getElementById("passwd")
                , rpasswd = document.getElementById("rpasswd");

        function validatePassword() {
            if (rpasswd.value != passwd.value) {
                rpasswd.setCustomValidity("Passwords Don't Match");
            } else {
                rpasswd.setCustomValidity('');
            }
        }

        passwd.onchange = validatePassword;
        rpasswd.onkeyup = validatePassword;
    </script>
</html>
