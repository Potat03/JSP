<%-- Document : login Created on : Apr 6, 2023, 12:42:43 PM Author : vkloo --%>

<%@page import="Entities.Customer"%>
<%@page import="Entities.Orders"%>
<%@page import="Entities.Categorylist"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    if (session == null || session.getAttribute("admin") == null || (session.getAttribute("adminmode") != "staff" && session.getAttribute("adminmode") != "manager")) {
        response.sendRedirect("login.jsp");
    }

    session.setAttribute("activePage", "dashboard");
    int packingCount = 0, shippingCount = 0, deliveredCount = 0, refundedCount = 0;

    if (session.getAttribute("packingCount") != null) {
        packingCount = (Integer) session.getAttribute("packingCount");
    }

    if (session.getAttribute("shippingCount") != null) {
        shippingCount = (Integer) session.getAttribute("shippingCount");
    }

    if (session.getAttribute("deliveredCount") != null) {
        deliveredCount = (Integer) session.getAttribute("deliveredCount");
    }

    if (session.getAttribute("refundedCount") != null) {
        refundedCount = (Integer) session.getAttribute("refundedCount");
    }

    List<Categorylist> categorylist = new Categorylist().getOrderCategories(5);

    List<Orders> order = new Orders().getRevenue();

    List<Customer> cust = new Customer().getCustomerJoined();
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
            .graph {
                /*margin: 50px 5px 50px 50px;*/
                background-color: white;
            }

            #salesChart {
                padding: 10px 10px 10px 5px;
            }

            .status {
                /*                margin: 50px 5px 50px 50px;
        border-radius: 20px;
        margin: 50px 5px 50px 50px;
        width: auto;
        height: auto;
        max-width: 800px;
        background-color: white;*/
            }

            .status-card {
                /*margin: 50px 5px 50px 50px;*/
                padding: 10px;
                width: auto;
                height: auto;
                max-width: 800px;
                background-color: white;
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
                        <div class="h3" style="padding-left: 10px;">Dashboard</div>
                    </div>
                    <div class="d-flex flex-column" style="padding: 15px 30px; gap:30px;">
                        <div class="flex-fill status">
                            <div class="d-flex flex-row h-100 gap-4">
                                <div class="p-3 status-card flex-grow-1">
                                    <h3>Packing Order</h3>
                                    <h2 class="text-center"><%=packingCount%></h2>
                                </div>
                                <div class="p-3 status-card flex-grow-1">
                                    <h3>Shipping Order</h3>
                                    <h2 class="text-center"><%=shippingCount%></h2>
                                </div>
                                <div class="p-3 status-card flex-grow-1">
                                    <h3>Delivered Order</h3>
                                    <h2 class="text-center"><%=deliveredCount%></h2>
                                </div>
                                <div class="p-3 status-card flex-grow-1">
                                    <h3>Order Refunded</h3>
                                    <h2 class="text-center"><%=refundedCount%></h2>
                                </div>
                            </div>
                        </div>
                        <div class="flex-fill status">
                            <div class="row">
                                <div class="col-6">
                                    <div class="p-4 bg-white h-100">
                                        <h3 style="padding: 10px 0px 10px 10px;">Category</h3>
                                        <canvas class="mx-auto" id="category-chart" style="width:100%; max-width:342px">Category</canvas>    
                                        <script>
                                            new Chart("category-chart", {
                                                type: "pie",
                                                data: {
                                                    labels: [
                                            <%
                                                if (categorylist != null) {
                                                    for (int i = 0; i < categorylist.size(); i++) {
                                                        out.print("\"" + categorylist.get(i).getCategoryid().getCategoryname() + "\",");
                                                    }
                                                }
                                            %>],
                                                    datasets: [{
                                                            backgroundColor: [
                                                                "#6CE5E8",
                                                                "#41B8D5",
                                                                "#2D8BBA",
                                                                "#2F5F98",
                                                                "#31356E"
                                                            ],
                                                            data: [
                                            <%
                                                if (categorylist != null) {
                                                    for (int i = 0; i < categorylist.size(); i++) {
                                                        out.print("\"" + categorylist.get(i).getProductcode().getStock() + "\",");
                                                    }
                                                }
                                            %>
                                                            ]
                                                        }]
                                                }
                                            });</script>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="p-4 bg-white h-100">
                                        <h3 style="padding: 10px 0px 10px 10px;">New Users Joined</h3>
                                        <canvas id="newUser" >New Users</canvas>
                                    </div>
                                    <script>
                                        new Chart("newUser", {
                                            type: "line",
                                            data: {
                                                labels: [
                                        <%
                                            if (cust != null) {
                                                for (int i = 0; i < cust.size(); i++) {
                                                    out.print("\"" + cust.get(i).getAddress() + "\",");
                                                }
                                            }
                                        %>],
                                                datasets: [{
                                                        fill: false,
                                                        lineTension: 0,
                                                        backgroundColor: "rgba(0,0,255,1.0)",
                                                        borderColor: "rgba(0,0,255,0.1)",
                                                        data: [<%
                                                            if (cust != null) {
                                                                for (int i = 0; i < cust.size(); i++) {
                                                                    out.print(cust.get(i).getCustomerid() + ",");
                                                                }
                                                            }
                                        %>]
                                                    }]
                                            },
                                            options: {
                                                legend: {display: false},
                                                scales: {
                                                    yAxes: [{ticks: {min: 0, max: 50}}]
                                                }
                                            }
                                        });
                                    </script>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="flex-fill" style="padding: 15px 30px;">
                        <div class="graph px-5 py-3">
                            <h3 style="padding: 10px 0px 15px 50px">Revenue</h3>
                            <canvas id="revenueChart" class="mx-auto" style="width:100%; max-width:1000px">Revenue</canvas>
                        </div>
                        <script>

                            const revenueData = [
                            <% for (int i = 0; i < order.size(); i++) {%>
                            <%=order.get(i).getTotal()%><%if ((i + 1) != order.size())%><%= ","%>
                            <%}%>
                            ];
                            const highRevenue = Math.ceil(Math.max(...revenueData) + 1000);

                            new Chart("revenueChart", {
                                type: "line",
                                data: {
                                    labels: [
                            <%
                                if (order != null) {
                                    for (int i = 0;
                                            i < order.size();
                                            i++) {
                                        out.print("\"" + order.get(i).getAddress() + "\",");
                                    }
                                }
                            %>],
                                    datasets: [{
                                            fill: false,
                                            lineTension: 0,
                                            backgroundColor: "rgba(0,0,255,1.0)",
                                            borderColor: "rgba(0,0,255,0.1)",
                                            data: [
                            <%
                                if (order != null) {
                                    for (int i = 0;
                                            i < order.size();
                                            i++) {
                                        out.print(order.get(i).getTotal() + ",");
                                    }
                                }
                            %>]
                                        },
                                    ]
                                },
                                options: {
                                    legend: {display: false},
                                    scales: {
                                        yAxes: [{ticks: {min: 0, max: highRevenue}}]
                                    }
                                }
                            });
                        </script>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../part/script.html" %>
    </body>
</html>