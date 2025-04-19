<%-- Document : login Created on : Apr 6, 2023, 12:42:43 PM Author : vkloo --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%
    if(session.getAttribute("admin") == null || (session.getAttribute("adminmode") != "staff" && session.getAttribute("adminmode") != "manager")){
        response.sendRedirect("login.jsp");
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
                        <div class="h3" style="padding-left: 10px;">Add Category</div>
                    </div>
                    <div class="container py-4 px-4 bg-light col-5 m-0" style="border-radius: 10px;">
                        <form method="POST" action="adminAddCategoryServlet">
                            <div class="row" style="gap: 20px;">
                                <div class="col-12">
                                    <div class="row align-items-center">
                                        <div class="col-4">
                                            Category Name
                                        </div>
                                        <div class="col-8">
                                            <input type="text" class="form-control-input border-0" id="name" name="name"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button class="btn" style="background-color: #FFEFB7;margin-left: 65%;">Add</button>
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