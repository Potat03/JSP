<%-- Document : login Created on : Apr 6, 2023, 12:42:43 PM Author : vkloo --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="Entities.Orders"%>
<%@page import="java.util.List"%>
<%
    if(session.getAttribute("admin") == null || (session.getAttribute("adminmode") != "staff" && session.getAttribute("adminmode") != "manager")){
        response.sendRedirect("login.jsp");
    }
    session.setAttribute("activePage", "order");

    List<Orders> orders = (List<Orders>) session.getAttribute("orders");

    String filter;
    if (request.getParameter("filter") != null) {
        filter = request.getParameter("filter");
        List<Orders> filtered = new ArrayList();
        for (int i = 0; i < orders.size(); i++) {
            if (orders.get(i).getStatus().equals(filter)) {
                filtered.add(orders.get(i));
            }
        }
        orders = filtered;
    } else {
        filter = "All";
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
            .filters .active{
                text-decoration: underline;
                text-decoration-color: #FFEFB7;
                text-decoration-thickness: 4px;
                text-decoration-skip-ink: none;
                text-underline-offset: 6px;
                color: black;
            }

            .filters .not-active{
                text-decoration: none;
                color: black;
            }

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
                        <div class="h3" style="padding-left: 10px;">Customer Order List</div>
                    </div>
                    <div class="py-2 px-3 bg-light mb-4" style="border-radius: 10px;">
                        <div class="filters row text-center justify-content-evenly">
                            <div class="col-2"><a class="<%= filter.equals("All") ? "active" : "not-active"%>" href="order.jsp">All</a></div>
                            <div class="col-2"><a class="<%= filter.equals("Pay") ? "active" : "not-active"%>" href="order.jsp?filter=Pay">Pay</a></div>
                            <div class="col-2"><a class="<%= filter.equals("Packing") ? "active" : "not-active"%>" href="order.jsp?filter=Packing">Packing</a></div>
                            <div class="col-2"><a class="<%= filter.equals("Shipping") ? "active" : "not-active"%>" href="order.jsp?filter=Shipping">Shipping</a></div>
                            <div class="col-2"><a class="<%= filter.equals("Delivered") ? "active" : "not-active"%>" href="order.jsp?filter=Delivered">Delivered</a></div>
                            <div class="col-2"><a class="<%= filter.equals("Refund") ? "active" : "not-active"%>" href="order.jsp?filter=Refund">Refund</a></div>
                        </div>

                    </div>
                    <div class="py-2 px-3 bg-light" style="border-radius: 10px;">
                        <div class="row justify-content-evenly border-bottom mb-2 p-1">
                            <div class="col-6">Order ID</div>
                            <div class="col-2 text-center">Payment Method</div>
                            <div class="col-2 text-center">Status</div>
                            <div class="col-2 text-center">Action</div>
                        </div>
                        <%if (orders.size() >= 1) {
                                for (int i = 0; i < orders.size(); i++) {%>
                        <div class="row justify-content-evenly mb-2 align-items-center">

                            <div class="col-6"> <%=orders.get(i).getOrderid()%></div>
                            <div class="col-2 text-center"><%=orders.get(i).getPaymentMethod()%></div>
                            <div class="col-2 text-center" style="color: #F97561;"><%=orders.get(i).getStatus()%></div>
                            <div class="col-2 text-center"><a class="text-decoration-none text-dark" onclick="event.preventDefault(); document.getElementById('toOrderDetail<%=i%>').submit();"><i class="fa-solid fa-pen-to-square"></i></a></div>
                            <form action="adminGetOrderDetailServlet" id="toOrderDetail<%=i%>" method="POST">
                                <input type="hidden" value="<%=orders.get(i).getOrderid()%>" name="id">
                            </form>
                        </div>
                        <%}
                        } else {%>
                        <img src="../src/img/noRecord.png" style= "width:100%;height: 290px;object-fit: contain;" alt="noRecord"/>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../part/script.html" %>


    </body>
</html>