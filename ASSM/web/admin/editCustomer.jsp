<%-- Document : login Created on : Apr 6, 2023, 12:42:43 PM Author : vkloo --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%@page import="Entities.Customer"%>
<%@page import="java.util.List"%>
<%

    if(session.getAttribute("admin") == null || (session.getAttribute("adminmode") != "staff" && session.getAttribute("adminmode") != "manager")){
        response.sendRedirect("login.jsp");
    }
    List<Customer> customers = (List<Customer>) session.getAttribute("customers");
    Customer customer = new Customer();
    for (int i = 0; i < customers.size(); i++) {
        if (customers.get(i).getCustomerid().equals(request.getParameter("id"))) {
            customer = customers.get(i);
        }
    }
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Petto Shop - Admin</title>
        <%@include file="../part/link.html" %>
        <link rel="stylesheet" href="../src/css/admin.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
        <style>
            .admin-nav-style{
                max-width: 250px;
                background-color: white;
                height: 100%;
                position: fixed;
            }
            .form-control-input{
                background-color: #E6EAE6 !important;
                border-radius: 10px !important;
                padding: 5px 15px;
            }

            .noselect {
                -webkit-touch-callout: none;
                -webkit-user-select: none;
                -khtml-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
            }
        </style>
    </head>

    <body>
        <div>
            <div class="d-flex">
                <div class="flex-fill admin-nav-style">
                    <%@include file="./part/header.jsp" %>
                </div>
                <div class="flex-fill px-4" style="margin-left: 20%; max-width: 70%;">
                    <div style="padding: 40px 20px 20px 20px;">
                        <div class="h3" style="padding-left: 10px;">Edit Customer</div>
                    </div>
                    <div class="container py-4 px-4 bg-light" style="border-radius: 10px;">
                        <form method="GET" action="addProdServlet">
                            <div class="row" style="gap: 20px;column-gap: 10%;">
                                <div class="col-5">
                                    <div class="row align-items-center">
                                        <div class="col-4">
                                            Customer Name
                                        </div>
                                        <div class="col-8">
                                            <input type="text" class="form-control-input border-0" id="customername" name="customername" value="<%=customer.getCustomername()%>"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-5">
                                    <div class="row align-items-center">
                                        <div class="col-4">
                                            Email
                                        </div>
                                        <div class="col-8">
                                            <input type="email" class="form-control-input border-0" id="email" name="email" value="<%=customer.getEmail()%>"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-5">
                                    <div class="row align-items-center">
                                        <div class="col-4">
                                            First Name
                                        </div>
                                        <div class="col-8">
                                            <input type="text" class="form-control-input border-0" id="firstname" name="firstname" value="<%=customer.getFirstname()%>"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-5">
                                    <div class="row align-items-center">
                                        <div class="col-4">
                                            Last Name
                                        </div>
                                        <div class="col-8">
                                            <input type="text" class="form-control-input border-0" id="lastname" name="lastname" value="<%=customer.getLastname()%>"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-5">
                                    <div class="row">
                                        <div class="col-4">
                                            Phone Number
                                        </div>
                                        <div class="col-8">
                                            <input type="text" class="form-control-input border-0" id="phonenumber" name="phonenumber" value="<%=customer.getPhonenumber()%>"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-5">
                                    <div class="row">
                                        <div class="col-4">
                                            Password
                                        </div>
                                        <div class="col-8">
                                            <input type="text" class="form-control-input border-0" id="password" name="password" value="<%=customer.getPassword()%>"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button class="btn" style="background-color: #FFEFB7;margin-left: 15%;">Add</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../part/script.html" %>
    </body>
</html>