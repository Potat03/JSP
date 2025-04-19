<%-- Document : productReport Created on : May 3, 2023, 6:20:12 PM Author : LohThiamWei --%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="Entities.Product"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.YearMonth"%>
<%

    if (session.getAttribute("admin") == null || (session.getAttribute("adminmode") != "staff" && session.getAttribute("adminmode") != "manager")) {
        response.sendRedirect("login.jsp");
    }

    session.setAttribute("activePage", "report");
    
    YearMonth currentYearMonth = YearMonth.now();
    Month currentMonth = currentYearMonth.getMonth();
    String monthSelected = currentMonth.toString();
    int monthInt = currentMonth.getValue();
    if (request.getParameter("month") != null) {
        monthSelected = request.getParameter("month")+"";
        Month month = Month.valueOf(monthSelected);
        monthInt = month.getValue();
    }
    
    
    List<Product> mostProducts = new Product().getMostSalesProduct(10, monthInt);
    List<Product> leastProducts = new Product().getLeastSalesProduct(10, monthInt);

    List<String> months = Arrays.asList(
            "January", "February", "March", "April",
            "May", "June", "July", "August",
            "September", "October", "November", "December"
    );
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
            .contentWrap{
                display:flex;
                flex-direction:column;
                gap:20px;

            }
            .content1, .content2{
                display: flex;
                width: 100%;
                gap:20px;
                flex-wrap: wrap;
                background-color: white;
            }
            .content-left{
                background-color: white;
                padding: 30px;
                max-width:600px;
                min-width: 500px;
                flex-grow: 1;
                display:flex;
                flex-direction:column;
                justify-content: center;
                gap:10px;
            }
            .content-left p{
                font-weight: bold;
                text-align: center;
                font-size: 24px;
                margin:0;
            }
            .content-right{
                min-width: 400px;
                background-color: white;
                flex-grow: 1;
                padding: 30px;
            }
            .content-right .title{
                font-weight: bold;
                font-size: 24px;
                padding: 0 0 5px 0;
                margin:0;
            }
            .itemsListWrap{
                display:flex;
                flex-direction:column;
                gap:15px;
                padding: 10px 30px 10px 5px;
                max-height: 400px;
                height:300px;
                overflow-y: scroll;
                position:relative;
            }
            .itemsWrap{
                position:relative;
            }
            .itemsWrap:before{
                content:"";
                box-shadow: 0px 14px 8px -7px rgba(255,255,255,1) inset;
                position:absolute;
                top:0;
                left:0;
                width:98%;
                height:300px;
                z-index: 1;
                pointer-events: none;
            }
            .itemsWrap:after{
                content:"";
                box-shadow: 0px -14px 8px -7px rgba(255,255,255,1) inset;
                position:absolute;
                top:0;
                left:0;
                width:98%;
                height:300px;
                z-index: 1;
                pointer-events: none;
            }
            .items{
                padding: 5px 10px;
                background-color: #e3e9e5;
                box-shadow: 3px 3px 5px 1px #d8d8d8;
                border-radius: 5px;
                display: flex;
                gap:20px;
                align-items:center;
            }
            .items img{
                width: 60px;
                height: 60px;
            }
            .items p{
                margin:0;
            }
            .items div{
                display:flex;
            }
            .itemInnerWrap p{
                font-size: 15px;
                min-width: 40px;
                text-align: left;
                align-self: center;
                padding-left: 5px;
            }
            .itemName{
                font-size: 18px;
                font-weight: 500;
                flex-grow: 1;
            }
            .itemSold{
                font-size: 14px;
                font-weight: normal;
                min-width: 60px;
                align-self: flex-end;
            }
            .itemSold span{
                font-weight: 500;
                font-size: 18px;
            }
            .itemsListWrap::-webkit-scrollbar-track
            {
                -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.1);
                border-radius: 10px;
                background-color: #F5F5F5;
            }
            .itemsListWrap::-webkit-scrollbar
            {
                width: 5px;
                border-radius: 10px;
                background-color: #d8d8d8;
            }
            .itemsListWrap::-webkit-scrollbar-thumb
            {
                border-radius: 10px;
                -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.2);
                background-color: #41756C;
            }
            .monthBtn{
                padding: 5px 15px;
                flex-grow: 1;
                text-align: center;
                cursor: pointer;
                opacity:0.6;
            }
            .monthBtn:hover{
                opacity:1;
            }
            .monthSelcted{
                background-color: #e9e9e9;
                opacity:1;
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
                        <div class="h3" style="padding-left: 10px;">Product Sales Report - (<%=monthSelected.substring(0,1)+monthSelected.toLowerCase().substring(1)%>)</div>
                    </div>
                    <div class="contentWrap" style="padding-bottom: 60px;">
                        <div style="padding-top:5px;background-color:white;">
                            <p style="margin:0;font-weight:600;padding-left:15px">Month Selection</p>
                            <div style="display:flex;;justify-content:space-between;">
                                <%for (int m = 0; m < months.size(); m++) {%>
                                <div class="monthBtn <%if (months.get(m).toUpperCase().equals(monthSelected))%><%="monthSelcted"%>" onclick="event.preventDefault();changeMonth('<%=months.get(m).toUpperCase()%>');" ><%= months.get(m)%></div>
                                <%}%>
                                <form method="get" action="./productReport.jsp" id="monthForm">
                                    <input type="hidden" name="month" id="monthSelect" value="<%=monthSelected%>">
                                </form>
                            </div>
                        </div>
                        <div class="content1">
                            <div class="content-left">
                                <canvas id="mostSalesChart" style="width:100%;"></canvas>
                                <p>Most Sales Products</p>
                            </div>
                            <div class="content-right">
                                <p class="title">Most Sales Product List</p>
                                <div class="itemsWrap">
                                    <div class="itemsListWrap">
                                        <% for (int i = 0; i < mostProducts.size(); i++) {%>
                                        <div class="items">
                                            <div class="itemInnerWrap">
                                                <p class="ranking">#
                                                    <%= (i + 1)%>
                                                </p>
                                                <img src="../src/img/product/<%= mostProducts.get(i).getImage()%>">
                                            </div>
                                            <p class="itemName"><%= mostProducts.get(i).getProductname()%></p>
                                            <p class="itemSold"><span><%= mostProducts.get(i).getStock()%></span> Sold</p>
                                        </div>
                                        <%}%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="content2">
                            <div class="content-left">
                                <canvas id="leastSalesChart" style="width:100%;"></canvas>
                                <p>Least Sales Products</p>
                            </div>
                            <div class="content-right">
                                <p class="title">Least Sales Product List</p>
                                <div class="itemsWrap">
                                    <div class="itemsListWrap">
                                        <% for (int i = 0; i < leastProducts.size(); i++) {%>
                                        <div class="items">
                                            <div class="itemInnerWrap">
                                                <p class="ranking">#
                                                    <%= (i + 1)%>
                                                </p>
                                                <img src="../src/img/product/<%= leastProducts.get(i).getImage()%>">
                                            </div>
                                            <p class="itemName"><%= leastProducts.get(i).getProductname()%></p>
                                            <p class="itemSold"><span><%= leastProducts.get(i).getStock()%></span> Sold</p>
                                        </div>
                                        <%}%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../part/script.html" %>
        <script>
            const mostLabels = [
            <% for (int i = 0; i < mostProducts.size(); i++) {%>
            <%="\'#" + (i + 1) + "\'"%><%if ((i + 1) != mostProducts.size())%><%= ","%>
            <%}%>
            ];
            const mostData = [
            <% for (int i = 0; i < mostProducts.size(); i++) {%>
            <%=mostProducts.get(i).getStock()%><%if ((i + 1) != mostProducts.size())%><%= ","%>
            <%}%>
            ];
            const largestMost = Math.max(...mostData) + 5;

            const leastLabels = [
            <% for (int i = 0; i < leastProducts.size(); i++) {%>
            <%="\'#" + (i + 1) + "\'"%><%if ((i + 1) != leastProducts.size())%><%= ","%>
            <%}%>
            ];
            const leastData = [
            <% for (int i = 0; i < leastProducts.size(); i++) {%>
            <%= leastProducts.get(i).getStock()%>
            <%if ((i + 1) != leastProducts.size())%>
            <%= ","%>
            <%}%>
            ];
            const largestLeast = Math.max(...leastData) + 5;

            new Chart("mostSalesChart", {
                type: "bar",
                data: {
                    labels: mostLabels,
                    datasets: [{
                            data: mostData,
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    legend: {
                        display: false
                    },
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    max: largestMost,
                                    callback: function (value, index, values) {
                                        if (Math.floor(value) === value) {
                                            return value;
                                        }
                                    }
                                }
                            }]
                    }
                }
            });
            new Chart("leastSalesChart", {
                type: "bar",
                data: {
                    labels: leastLabels,
                    datasets: [{
                            data: leastData,
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    legend: {
                        display: false
                    },
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    max: largestLeast,
                                    callback: function (value, index, values) {
                                        if (Math.floor(value) === value) {
                                            return value;
                                        }
                                    }
                                }
                            }]
                    }
                }
            });

            function changeMonth(month) {
                document.getElementById("monthSelect").value = month;
                document.getElementById('monthForm').submit();
            }
        </script>
    </body>
</html>