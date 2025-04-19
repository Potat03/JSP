<%-- 
    Document   : login
    Created on : Apr 6, 2023, 12:42:43 PM
    Author     : vkloo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String popout = new String();

    if (session.getAttribute("login") != null) {
        popout = (String) session.getAttribute("login");
        session.removeAttribute("login");
    }
%>
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
            img.img-thumbnail {
                border-radius: 120px;
            }
            section {
                padding-top: 70px;
                padding-bottom: 80px;
                margin-left: 20%;
                margin-right: 20%;
            }

            input {
                border-radius: 7px;
                text-align: center;
                padding: 2px;
                border: 1.2px solid black;
            }
            .submitBtn{
                border:2px solid lightsalmon;
                color: lightsalmon;
                background: transparent;
                transition: 0.2s;
                font-weight: bold;
                font-size: 1.3rem;
                border-radius: 15px;
            }

            .submitBtn:hover{
                background-color: peachpuff;
                border-color: peachpuff;
                color: white;
            }

            form {
                padding-top: 10px;
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
            #loginbtn {
                background-color: peachpuff;
                border-radius: 10px;
                padding: 5px 10px 5px 10px;
                border: 1px solid #333333;
                transition: .2s;
            }
            #loginbtn:hover {
                background-color: lightsalmon;
                padding: 5px 10px 5px 10px;
            }
            #reg {
                color: lightsalmon;
            }
            #reg:hover {
                color: peachpuff;
            }
            .userinput {
                max-width: 250px;
                padding-bottom:5px;
                text-align: left;
                display: inline-flex;
                flex-direction: column;
            }

            .talk-bubble.round {
                border-radius: 30px;
                -webkit-border-radius: 30px;
                -moz-border-radius: 30px;
            }

            .talk-bubble.border {
                border: 8px solid #666 !important;
            }

            .talk-bubble {
                display: inline-block;
                position: relative;
                width: 200px;
                height: auto;
                background-color: lightyellow;
            }

            .talk-bubble.tri-right.border.btm-left-in:before {
                content: ' ';
                position: absolute;
                width: 0;
                height: 0;
                left: 30px;
                right: auto;
                top: auto;
                bottom: -40px;
                border: 20px solid;
                border-color: #666 transparent transparent #666;
            }

            .talk-bubble.tri-right.btm-left-in:after {
                content: ' ';
                position: absolute;
                width: 0;
                height: 0;
                left: 38px;
                right: auto;
                top: auto;
                bottom: -20px;
                border: 12px solid;
                border-color: lightyellow transparent transparent lightyellow;
            }

            .talk-bubble .talktext {
                padding: 1em;
                text-align: left;
                line-height: 1.5em;
            }
        </style>
    </head>
    <body>
        <%if (session.getAttribute("registerSuccess") != null) {%>
        <div class="alert alert-success position-absolute w-75 alert-dismissible fade show" role="alert" style="
             z-index: 999;
             top: 2%;
             left: 50%;
             transform: translate(-50%, 0%);
             ">
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            <h4 class="alert-heading">Successfully Registered!</h4>
        </div>
        <%session.removeAttribute("registerSuccess");
            }%>
        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>
        <!<!-- Content -->
        <section>
            <div class="container">
                <div class="d-flex">
                    <div class="p-2 flex-fill position-relative">
                        <img class="d-none d-lg-block img-thumbnail" src="./src/img/petto.jpg" alt="alt"/>
                        <% if (popout.equals("false")) {%>
                        <div class="position-absolute top-0" id="loginFail" style="right: 15%;">
                            <div class="talk-bubble tri-right border round btm-left-in">
                                <div class="talktext">
                                    <p>Woof.. You have entered the wrong email or password Woof.. Woof..</p>
                                </div>
                            </div>
                        </div>
                        <script>
                            document.getElementById("loginFail").addEventListener("click", hideDiv);
                            function hideDiv() {
                                document.getElementById("loginFail").style.display = "none";
                            }
                        </script>
                        <%}%>
                    </div>
                    <div class="p-2 flex-fill">
                        <form method="POST" action="loginServlet" style="text-align: center;">
                            <h2>Sign in with</h2>
                            <div class="SocialItem">
                                <i class="fa-brands fa-instagram" style="color: lightsalmon;"></i>
                                <i class="fa-brands fa-facebook" style="color: lightsalmon;"></i>
                                <i class="fa-brands fa-twitter" style="color: lightsalmon;"></i>
                            </div>
                            <h3 id="or"><span  class="line-center">Or</span></h3>
                            <div class="userinput">
                                <h5>Email address</h5>
                                <input type="email" name="email" value="" size="35"/>
                                <h5 class="mt-3">Password</h5>
                                <input type="password" name="password" value="" size="35"/>
                            </div>
                            <p><a id="reg" href="register.jsp">Don't have an account? Click here</a></p>
                            <button class="submitBtn" type="submit">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <div id="footer"><div id="header">
                <%@include file="./part/footer.jsp" %>
            </div></div>
            <%@include file="/part/script.html" %>
    </body>
</html>
