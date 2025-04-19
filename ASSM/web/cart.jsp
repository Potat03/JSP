<%@page import="Entities.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entities.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Entities.Cartlist"%>
<%@page import="Entities.Customer"%>
<%
    Customer customer = new Customer();
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    } else {
        customer = (Customer) session.getAttribute("user");
    }
    List<Cartlist> cartlist = new ArrayList();
    cartlist = (List<Cartlist>) session.getAttribute("cartlist");

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
                border: 1px solid #0000002e;
                line-height: 22px;
                text-align: center;
            }

            .counter span {
                display: block;
                border: 1px solid #0000002e;
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
                <h3>Shopping Cart</h3>
            </div>

            <div class="row justify-content-between">
                <div class="col-9">
                    <div class="container bg-white border-round px-4 py-2 mb-3">
                        <div class="cart-title d-flex flex-row px-1 align-items-center">
                            <div class="col-4">
                                <h5>Product</h5>
                            </div>
                            <div class="col-2">
                                <h5>Price</h5>
                            </div>
                            <div class="col-2">
                                <h5>Quantity</h5>
                            </div>
                            <div class="col-2">
                                <h5>Total</h5>
                            </div>
                            <div class="col-2">
                                <h5>Action</h5>
                            </div>
                        </div>
                    </div>
                    <div class="cart-item-wrapper container bg-white border-round p-2">
                        <% for (int i = 0; i < cartlist.size(); i++) {
                                int promoValue = 0;
                                if (cartlist.get(i).getProductcode().getPromotionid() != null) {
                                    promoValue = cartlist.get(i).getProductcode().getPromotionid().getValue();
                                }
                        %>
                        <div class="cart-item d-flex flex-row px-1 py-3 align-items-center">
                            <div class="d-flex align-items-center col-4">
                                <img src="./src/img/product/<%=cartlist.get(i).getProductcode().getImage()%>" width="100">
                                <div class="ps-4" style="width:185px;"><p style="overflow-wrap: break-word;"><%=cartlist.get(i).getProductcode().getProductname()%></p></div>
                            </div>
                            <div class="col-2">
                                <p>
                                    <%="RM " + (cartlist.get(i).getProductcode().getPrice() - (cartlist.get(i).getProductcode().getPrice() * promoValue / 100))%>
                                </p>
                            </div>
                            <div class="col-2" style="padding-bottom: 10px;">
                                <div class="counter">
                                    <span class="down" onclick="event.preventDefault(); document.getElementById('decrease-product-quantity-<%=i%>').submit();">-</span>
                                    <form action="modifyCartProductQuantity" id="decrease-product-quantity-<%=i%>" method="POST">
                                        <input type="hidden" name="type" value="decrease"/>
                                        <input type="hidden" name="cartid" value="<%=customer.getCart().getCartid()%>"/>
                                        <input type="hidden" name="prodid" value="<%=cartlist.get(i).getProductcode().getProductcode()%>"/>
                                    </form>
                                    <input type="text" value="<%=cartlist.get(i).getQuantity()%> ">
                                    <span class="up" onclick="event.preventDefault(); document.getElementById('increase-product-quantity-<%=i%>').submit();">+</span>
                                    <form action="modifyCartProductQuantity" id="increase-product-quantity-<%=i%>" method="POST">
                                        <input type="hidden" name="type" value="increase"/>
                                        <input type="hidden" name="cartid" value="<%=customer.getCart().getCartid()%>"/>
                                        <input type="hidden" name="prodid" value="<%=cartlist.get(i).getProductcode().getProductcode()%>"/>
                                    </form>
                                </div>
                            </div>
                            <div class="col-2">
                                <p>
                                    <%="RM " + (cartlist.get(i).getProductcode().getPrice() - (cartlist.get(i).getProductcode().getPrice() * promoValue / 100)) * cartlist.get(i).getQuantity()%>
                                </p>
                            </div>
                            <div class="col-2">
                                <h5 onclick="event.preventDefault(); document.getElementById('delete-product-<%=i%>').submit();"><i class="fa-solid fa-trash-can"></i></h5>
                                <form action="deleteFromCart" id="delete-product-<%=i%>" method="POST">
                                    <input type="hidden" name="cartid" value="<%=customer.getCart().getCartid()%>"/>
                                    <input type="hidden" name="prodid" value="<%=cartlist.get(i).getProductcode().getProductcode()%>"/>
                                </form>
                            </div>
                        </div>
                        <% }%>
                    </div>
                    <div class="cart-footer container bg-white border-round px-4 py-1 my-5">
                        <div class="cart-footer-content d-flex flex-row-reverse px-1 py-3">
                            <div class="w-50">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <div class="h5"><%= "Total Item (" + cartlist.size() + ")"%></div>
                                    </div>
                                    <div class="col">
                                        <div class="h5" style="color: #F97561;"></div>
                                    </div>
                                    <div class="col"><button class="border-round h5 px-2 py-1" style="background-color:#FFEFB7;" onclick="location.href = 'checkout.jsp'">Check out</button></div>
                                </div>
                            </div>
                        </div>
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
                                <img class="img-fluid" src="./src/img/product/<%=mightLike.get(k).getImage()%>" alt="image">
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
            <script defer>
                function increaseCount(a, b) {
                    var input = b.previousElementSibling;
                    var value = parseInt(input.value, 10);
                    value = isNaN(value) ? 0 : value;
                    value++;
                    input.value = value;
                }

                function decreaseCount(a, b) {
                    var input = b.nextElementSibling;
                    var value = parseInt(input.value, 10);
                    if (value > 1) {
                        value = isNaN(value) ? 0 : value;
                        value--;
                        input.value = value;
                    }
                }
            </script>
    </body>

</html>