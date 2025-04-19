<%-- 
    Document   : My Profile
    Created on : Apr 7, 2023, 11:30:17 AM
    Author     : kai xin
--%>
<%@page import="Entities.Customer"%>
<%
    session.setAttribute("activePage", "password");
    Customer customer = new Customer();
    if (session.getAttribute("login") != null && session.getAttribute("login").equals("true")) {
        customer = (Customer) session.getAttribute("user");

    } else {
        response.sendRedirect("login.jsp");
    }

    if (session.getAttribute("passErr") != null) {
        String msg = (String) session.getAttribute("passErr");
        session.removeAttribute("passErr");
        out.println(msg);
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./src/css/profile.css">
        <link rel="stylesheet" href="./src/css/main.css">
        <%@include file="/part/link.html" %>
        <title>Change Password</title>
        <style>

        </style>

    </head>

    <body>
        <%if (session.getAttribute("editPasswdSuccess") != null) {%>
        <div class="alert alert-success position-absolute w-25 alert-dismissible fade show" role="alert" style="
             z-index: 999;
             top: 2%;
             left: 50%;
             transform: translate(-50%, 0%);
             ">
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            <h6 class="alert-heading">Customer Information Updated!</h6>
        </div>
        <%session.removeAttribute("editPasswdSuccess");}%>
        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>

        <div class="myprofile-bgarea">
            <div class="container">
                <div class="row myprofile-inner-area" style="min-height: 600px;">
                    <div class="col-3">
                        <%@include file="part/profileNav.jsp" %>
                    </div>
                    <div class="col-9">
                        <div class="col-right-area">
                            <div class="profile-name-area">
                                <h4>Change Password</h4>
                            </div>
                            <div class="profile-details-area">
                                <div class="row">
                                    <div class="col-4 details-left-part">
                                        <div class="col-12 details-txt">
                                            <label for="currentPass">Current Password</label>
                                        </div>
                                        <div class="col-12 details-txt">
                                            <label for="newPass">New Password</label>
                                        </div>
                                        <div class="col-12 details-txt">
                                            <label for="confirmPass">Confirm Password</label>
                                        </div>
                                    </div>

                                    <div class="col-8 details-right-part">
                                        <form action="editCustomerPasswdServlet" method="POST">
                                            <input type="hidden" id="id" name="id" value="<%=customer.getCustomerid()%>">
                                            <div class="col-12 details-input">
                                                <input type="password" id="currentPass" name="currentPass">
                                            </div>
                                            <div class="col-12 details-input">
                                                <input type="password" id="newPass" name="newPass">
                                            </div>
                                            <div class="col-12 details-input">
                                                <input type="password" id="emconfirmPassail" name="confirmPass">
                                            </div>
                                            <input class="profile-save-btn" type="submit" value="Save">
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="footer">   
            <%@include file="/part/footer.jsp" %>
        </div>

        <%@include file="/part/script.html" %>
    </body>
</html>
