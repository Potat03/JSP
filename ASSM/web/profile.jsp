<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entities.Customer"%>

<%

    session.setAttribute("activePage", "profile");
    Customer customer = new Customer();
    String address = "";
    String phone = "";
    if (session.getAttribute("login") != null && session.getAttribute("login").equals("true")) {
        customer = (Customer) session.getAttribute("user");

        if (customer.getAddress() != null) {
            address = customer.getAddress();
        }

        if (customer.getPhonenumber() != null) {
            phone = customer.getPhonenumber();
        }

    } else {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./src/css/profile.css">
        <link rel="stylesheet" href="./src/css/main.css">
        <%@include file="/part/link.html" %>
        <title>My Profile</title>

    </head>

    <body>
        <%if (session.getAttribute("editCustSuccess") != null) {%>
        <div class="alert alert-success position-absolute w-25 alert-dismissible fade show" role="alert" style="
             z-index: 999;
             top: 2%;
             left: 50%;
             transform: translate(-50%, 0%);
             ">
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            <h6 class="alert-heading">Customer Information Updated!</h6>
        </div>
        <%session.removeAttribute("editCustSuccess");
            }%>
        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>

        <div class="myprofile-bgarea">
            <div class="container">
                <div class="row myprofile-inner-area">
                    <div class="col-3">
                        <%@include file="/part/profileNav.jsp" %>
                    </div>
                    <div class="col-9">
                        <div class="col-right-area">
                            <div class="profile-name-area">
                                <h4><%=customer.getFirstname()%>'s Profile</h4>
                            </div>
                            <div class="profile-details-area">
                                <div class="row">
                                    <div class="col-4 details-left-part">
                                        <div class="col-12 details-txt">
                                            <label for="username">Username</label>
                                        </div>
                                        <div class="col-12 details-txt">
                                            <label for="firstname">Firstname</label>
                                        </div>
                                        <div class="col-12 details-txt">
                                            <label for="lastname">Lastname</label>
                                        </div>
                                        <div class="col-12 details-txt">
                                            <label for="email">Email</label>
                                        </div>
                                        <div class="col-12 details-txt">
                                            <label for="phonenum">Phone Number</label>
                                        </div>
                                        <div class="col-12 details-txt">
                                            <label for="address">Delivery Address</label>
                                        </div>
                                    </div>

                                    <div class="col-8 details-right-part">
                                        <form id="info-form" action="editCustomerServlet" method="POST">
                                            <div class="col-12 details-input">
                                                <span><%=customer.getCustomername()%></span>
                                                <input type="hidden" id="id" name="id" value="<%=customer.getCustomerid()%>">
                                            </div>
                                            <div class="col-12 details-input">
                                                <input type="text" id="firstname" name="fname" value="<%=customer.getFirstname()%>">
                                            </div>
                                            <div class="col-12 details-input">
                                                <input type="text" id="lastname" name="lname" value="<%=customer.getLastname()%>">
                                            </div>
                                            <div class="col-12 details-input">
                                                <span><%=customer.getEmail()%></span>
                                            </div>
                                            <div class="col-12 details-input">
                                                <input type="text" id="phonenum" name="phonenum" value="<%=phone%>">
                                            </div>
                                            <div class="col-12 details-input">
                                                <textarea id="adress" name="address" rows="4" cols="50"><%=address%></textarea>
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
</html>
