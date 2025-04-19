<%@page import="Entities.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entities.Orders"%>
<%@page import="Entities.Orderlist"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entities.Customer"%>
<%
    Customer customer = new Customer();
    String refund = new String();
    if (session.getAttribute("login") != null && session.getAttribute("login").equals("true")) {
        customer = (Customer) session.getAttribute("user");

    } else {
        response.sendRedirect("login.jsp");
    }

    List<Orderlist> orderlist = (List<Orderlist>) session.getAttribute("orderlist");
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="./part/link.html" %>
        <link rel="stylesheet" href="./src/css/main.css">
        <title>Petto Shop</title>
        <style>
            body {
                background-color: #f5f5f5;
            }

            .container .border-round {
                border-radius: 10px;
            }

            .counter {
                display: flex;
                align-items: center;
            }

            .counter input {
                width: 50px;
                border: 1px solid #00002e;
                line-height: 22px;
                text-align: center;
            }

            .counter span {
                display: block;
                border: 1px solid #00002e;
                padding: 0 10px;
                cursor: pointer;
                user-select: none;
            }

            .sticky-side-bar {
                position: sticky;
                top: 10%;
                height: 25vh;
            }

            .sticky-side-bar .image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        </style>
    </head>

    <body>
        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>

        <!-- Content Area -->
        <div class="container pt-3">
            <div class="title py-3">
                <h3>Order Details</h3>
                <h3>Order ID : <%=request.getParameter("id")%></h3>
            </div>

            <div class="row justify-content-between mb-5">
                <div class="col-9">
                    <div class="container bg-white border-round px-4 py-2 mb-3">
                        <div class="cart-title d-flex flex-row px-1 align-items-center text-center">
                            <div class="col-4 text-start">
                                <h5>Product</h5>
                            </div>
                            <div class="col-3">
                                <h5>Price</h5>
                            </div>
                            <div class="col-3">
                                <h5>Quantity</h5>
                            </div>
                            <div class="col-2">
                                <h5>Total</h5>
                            </div>
                        </div>
                    </div>
                    <div class="cart-item-wrapper container bg-white border-round p-2">
                        <% for (int i = 0; i < orderlist.size(); i++) {%>
                        <div class="cart-item d-flex flex-row px-1 py-3 align-items-center text-center">
                            <div class="d-flex align-items-center col-4">
                                <img src="./src/img/product/<%=orderlist.get(i).getProductcode().getImage()%>" width="100">
                                <div style="width:185px;"><p style="overflow-wrap: break-word;"><%=orderlist.get(i).getProductcode().getProductname()%></p></div>
                            </div>
                            <div class="col-3">
                                <p>
                                    <%= "RM " + orderlist.get(i).getProductcode().getPrice()%>
                                </p>
                            </div>
                            <div class="col-3" style="padding-bottom: 10px;">
                                <p>
                                    <%= orderlist.get(i).getQuantity()%>
                                </p>
                            </div>
                            <div class="col-2">
                                <p>
                                    <%= "RM " + (orderlist.get(i).getProductcode().getPrice() * orderlist.get(i).getQuantity())%>   
                                </p>
                            </div>
                        </div>
                        <% }%>
                    </div>
                </div>

                <div class="sticky-side-bar col-3">
                    <div class="bg-white border-round text-center px-2 py-2 mb-3 align-items-center">
                        <h5>You Might Also Like</h5>
                    </div>
                    <div class="bg-white border-round p-3 container">
                        <% List<Product> mightLike = new Product().getYouMightLike(customer.getCustomerid(), 2, 1);
                            for (int k = 0; k < mightLike.size(); k++) {
                        %>
                        <div class="row py-4">
                            <div class="col-4">
                                <img class="img-fluid" src="./src/img/product/<%=mightLike.get(k).getImage()%>">
                            </div>
                            <div class="col-8">
                                <p><%=mightLike.get(k).getProductname()%></p>
                                <p>RM<%=mightLike.get(k).getPrice()%></p>
                                <button class="border-round" style="background-color:#FFEFB7;" onclick="location.href = 'productDetail.jsp?id=<%=mightLike.get(k).getProductcode()%>'">Go To Page</button>
                            </div>
                        </div>
                        <%}%>
                    </div>
                </div>

            </div>

            <%@include file="./part/script.html" %>
    </body>

</html>