<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entities.Customer"%>
<%@page import="Entities.Orders"%>
<%@page import="java.util.List"%>
<%
    session.setAttribute("activePage", "order");
    Customer customer = new Customer();
    
    if (session.getAttribute("login") != null && session.getAttribute("login").equals("true")) {
        customer = (Customer) session.getAttribute("user");

    } else {
        response.sendRedirect("login.jsp");
    }
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
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./src/css/profile.css">
        <link rel="stylesheet" href="./src/css/main.css">
        <%@include file="/part/link.html" %>
        <title>Customer Order</title>
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
                        <div class="profileOrder-col-right-area">
                            <div class="py-2 px-3 bg-light mb-4" style="border-radius: 10px;">
                                <div class="filters row text-center justify-content-evenly">
                                    <div class="col-2"><a class="<%= filter.equals("All") ? "active" : "not-active"%>" href="profileOrder.jsp">All</a></div>
                                    <div class="col-2"><a class="<%= filter.equals("Pay") ? "active" : "not-active"%>" href="profileOrder.jsp?filter=Pay">Pay</a></div>
                                    <div class="col-2"><a class="<%= filter.equals("Packing") ? "active" : "not-active"%>" href="profileOrder.jsp?filter=Packing">Packing</a></div>
                                    <div class="col-2"><a class="<%= filter.equals("Shipping") ? "active" : "not-active"%>" href="profileOrder.jsp?filter=Shipping">Shipping</a></div>
                                    <div class="col-2"><a class="<%= filter.equals("Delivered") ? "active" : "not-active"%>" href="profileOrder.jsp?filter=Delivered">Delivered</a></div>
                                    <div class="col-2"><a class="<%= filter.equals("Refund") ? "active" : "not-active"%>" href="profileOrder.jsp?filter=Refund">Refund</a></div>
                                </div>
                            </div>

                            <div class="py-3 px-4 bg-light" style="border-radius: 10px;">
                                <% if (orders.size() >= 1) {
                                        for (int i = 0; i < orders.size(); i++) {
                                            String status = orders.get(i).getStatus();
                                            String statusMsg = new String();
                                            if (status.equals("Pay")) {
                                                statusMsg = "User Havn't Pay";
                                            } else if (status.equals("Packing")) {
                                                statusMsg = "Parcel Is Packing";
                                            } else if (status.equals("Shipping")) {
                                                statusMsg = "Parcel Is Shipping";
                                            } else if (status.equals("Deliver")) {
                                                statusMsg = "Parcel Has Been Delivered";
                                            } else if (status.equals("Refund")) {
                                                statusMsg = "Order Refunded";
                                            }
                                %>
                                <div class="row py-3">
                                    <div class="order-title d-flex">
                                        <div class="order-title-left">
                                            <span>Order ID</span>
                                        </div>
                                        <div class="order-title-right">
                                            <span style="padding-right: 30px; color:#51897F;">
                                                <%=statusMsg%>
                                            </span>
                                            <span class="order-status-style"><%=orders.get(i).getStatus()%></span>
                                        </div>
                                    </div>
                                    <div class="order-bottom d-flex">
                                        <div class="order-btm-id">
                                            <span><%=orders.get(i).getOrderid()%></span>
                                        </div>
                                        <div class="col-4 d-flex justify-content-end">
                                            <div class="order-btm-btn col-5" onclick="event.preventDefault(); document.getElementById('customer-order-detail-form-<%=i%>').submit();">
                                                <span>View Details</span>
                                                <form id="customer-order-detail-form-<%=i%>" action="getCustomerOrderDetailServlet" method="POST">
                                                    <input type="hidden" id="orderid" name="orderid" value="<%=orders.get(i).getOrderid()%>">
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%}
                                } else {%>
                                     <img src="./src/img/noRecord.png" style= "width:100%;height: 290px;object-fit: contain;" alt="noRecord"/>
                                <%}%>
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
