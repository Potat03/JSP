<%-- Document : login Created on : Apr 6, 2023, 12:42:43 PM Author : vkloo --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="Entities.Customer"%>
<%@page import="java.util.List"%>
<%

    if(session.getAttribute("admin") == null || (session.getAttribute("adminmode") != "staff" && session.getAttribute("adminmode") != "manager")){
        response.sendRedirect("login.jsp");
    }
    session.setAttribute("activePage", "customer");

    List<Customer> customers = (List<Customer>) session.getAttribute("customers");
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
        </style>
    </head>

    <body>
        <div>
            <div class="d-flex">
                <div class="flex-fill admin-nav-style">
                    <%@include file="./part/header.jsp" %>
                </div>
                <div class="flex-fill px-4" style="margin-left: 20%;">
                    <div style="padding: 40px 20px 20px 20px;">
                        <div class="h3" style="padding-left: 10px;">Customer</div>
                    </div>
                    <div class="py-2 px-3 bg-light" style="border-radius: 10px;">
                        <div class="row justify-content-evenly border-bottom mb-2 p-1">
                            <div class="col-1 text-center">No.</div>
                            <div class="col-2 text-center">CustomerName</div>
                            <div class="col-1 text-center">First Name</div>
                            <div class="col-1 text-center">Last Name</div>
                            <div class="col-3 text-center">Email</div>
                            <div class="col-2 text-center">Phone</div>
                            <div class="col-2 text-center">Action</div>
                        </div>
                        <% for (int i = 0; i < customers.size(); i++) {%>
                        <div class="row justify-content-evenly mb-2 align-items-center">
                            <div class="col-1 text-center"><%=i + 1%></div>
                            <div class="col-2 text-center"><%=customers.get(i).getCustomername()%></div>
                            <div class="col-1 text-center"><%=customers.get(i).getFirstname()%></div>
                            <div class="col-1 text-center"><%=customers.get(i).getLastname()%></div>
                            <div class="col-3 text-center"><%=customers.get(i).getEmail()%></div>
                            <div class="col-2 text-center"><%=customers.get(i).getPhonenumber()%></div>
                            <div class="col-2 text-center d-flex justify-content-center" style="gap: 15px;">
                                <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#modal-delCustomerServlet<%=i%>" style="background-color: #FFEFB7;">Delete</button>
                                <div class="modal fade" id ="modal-delCustomerServlet<%=i%>" tabindex="-1" role="dialog" aria-labelledby="modal-delCustomerServlet<%=i%>" aria-hidden="true">
                                    <div class="modal-dialog modal-sm">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Confirm Delete</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p class="text-start py-1">Customer Name: <%=customers.get(i).getCustomername()%></p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button"class="btn" style="background-color: #FFEFB7;" onclick="event.preventDefault(); document.getElementById('delCustomerServlet<%=i%>').submit();">Delete</button>
                                                <form id="delCustomerServlet<%=i%>" action="adminDeleteCustomerServlet" method="POST">
                                                    <input type="hidden" id="id" name="id" value="<%=customers.get(i).getCustomerid()%>"/>
                                                </form>
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../part/script.html" %>
    </body>
</html>