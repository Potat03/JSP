<%@page import="java.util.List"%>
<%@page import="Entities.Cartlist"%>
<%@page import="Entities.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Customer customer = new Customer();
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    } else {
        customer = (Customer) session.getAttribute("user");
    }

    List<Cartlist> cartlist = (List<Cartlist>) session.getAttribute("cartlist");
    double subtotal = 0;
    double shipping = 25;
    double discount = 0;
    double promo = 0;
    double total = 0;
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="./part/link.html" %>
        <link rel="stylesheet" href="./src/css/main.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Petto Shop</title>
        <style>
            body {
                background-color: #f5f5f5;
            }

            .userinfo {
                margin-top: 5px;
                padding: 1px 20px 1px 20px;
                text-align: center;
                background-color: #E6EAE6;
                border: none;
                border-radius: 25px;
            }

            .userinfoadd {
                margin-top: 5px;
                width:80%;
                text-align: center;
                background-color: #E6EAE6;
                border: none;
                border-radius: 25px;
            }
            .paymentinfo {
                margin-top: 5px;
                padding: 1px 20px 1px 20px;
                text-align: center;
                background-color: #E6EAE6;
                border: none;
                border-radius: 25px;
            }


            .container .border-round {
                border-radius: 10px;
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
            hr {
                margin-top: 2px;
                margin-left:auto;
                margin-right:auto;
                width: 100%;
            }

            #carddetails {
                display:none;
            }
            .productpic {
                width: 100%;
                height: auto;
            }

            .summary {
                max-height: 320px;
            }

            #confirmorder {
                width:80%;
                border-radius: 15px;
                background-color: #FFEFB7;
                border: none;
                margin-bottom: 10px;
                padding: 2px 0px 2px 0px;
            }

            #confirmorder:hover {
                box-shadow: 0 2px 8px peachpuff;
                transition: .5s;
            }

            input[type="radio"]:checked {
                accent-color: grey;
            }

            .summary::-webkit-scrollbar {
                width: 5px;
            }

            /* Track */
            .summary::-webkit-scrollbar-track {
                box-shadow: inset 0 0 1px grey;
                border-radius: 25px;
            }

            /* Handle */
            .summary::-webkit-scrollbar-thumb {
                background: orange;
                border-radius: 5px;
            }

            /* Handle on hover */
            .summary::-webkit-scrollbar-thumb:hover {
                background: orange;
            }

        </style>
    </head>

    <body>
        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>

        <!-- Content Area -->
        <form action="createOrderServlet" method="POST">
            <div class="container pt-3">
                <div class="title py-3">
                    <h3>Shopping Cart</h3>
                </div>

                <div class="row justify-content-between">
                    <div class="col-8">
                        <div class="container bg-white border-round px-4 py-2">
                            <div class="d-flex flex-row px-1 align-items-center">
                                <h5>Delivery Information</h5>
                            </div>
                            <hr/>
                            <div class="row">
                                <div class="col-sm-6">
                                    <h5>First Name</h5>
                                    <input class="userinfo" type="text" name="fname" value="<%=(!customer.getFirstname().isEmpty()) ? customer.getFirstname() : ""%>" disabled required>
                                </div>
                                <div class="col-sm-6">
                                    <h5>Last Name</h5>
                                    <input class="userinfo" type="text" name="lname" value="<%=(!customer.getLastname().isEmpty()) ? customer.getLastname() : ""%>" disabled required>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-sm-6">
                                    <h5>Mobile</h5>
                                    <input class="userinfo" type="text" name="mobile" value="<%=(customer.getPhonenumber() != null) ? customer.getPhonenumber() : ""%>" required>
                                </div>
                                <div class="col-sm-6">
                                    <h5>Email</h5>
                                    <input class="userinfo" type="text" name="email" value="<%=(!customer.getEmail().isEmpty()) ? customer.getEmail() : ""%>" disabled required>
                                </div>
                            </div>
                            <div class="row mt-3 mb-3">
                                <div class="col-sm-12">
                                    <h5>Address</h5>
                                    <input class="userinfoadd" type="text" name="address" value="<%=(customer.getAddress() != null) ? customer.getAddress() : ""%>" required>
                                </div>
                            </div>
                            <div class="d-flex flex-row px-1 align-items-center">
                                <h5>Payment Method</h5>
                            </div>
                            <hr/>
                            <div class="d-flex flex-column">
                                <!-- Debit Credit Card -->
                                <div class="p-2 align-items-center d-flex" style="gap:10px;">
                                    <input type="radio" id="card" name="method" value="Card" required>
                                    <i class="fa fa-credit-card" style="font-size:36px"></i>
                                    <label for="card">Debit Card/ Credit Card</label><br>
                                </div>
                                <div id="carddetails" class="p-2 mx-3">
                                    <div class="row">
                                        <div class="col-sm-6 d-flex flex-column" >
                                            <h5>Card Number</h5>
                                            <input class="paymentinfo" id="cardnum" type="text" name="cardnum">
                                            <%if (session.getAttribute("OrderErrCardnum") != null) {%><span><%=session.getAttribute("OrderErrCardnum")%></span><%session.removeAttribute("OrderErrCardnum");
                                                }%>
                                        </div>
                                        <div class="col-sm-6  d-flex flex-column">
                                            <h5>Expiry Date (MM/YY)</h5>
                                            <input class="paymentinfo" id="expdate" type="text" name="edate">
                                            <%if (session.getAttribute("OrderErrEdate") != null) {%><span><%=session.getAttribute("OrderErrEdate")%></span><%session.removeAttribute("OrderErrEdate");
                                                }%>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-sm-6  d-flex flex-column">
                                            <h5>Name on Card</h5>
                                            <input class="paymentinfo" id="nameoncard" type="text" name="nameoncard">
                                            <%if (session.getAttribute("OrderErrNameCard") != null) {%><span><%=session.getAttribute("OrderErrNameCard")%></span><%session.removeAttribute("OrderErrNameCard");
                                                                                            }%>

                                        </div>
                                        <div class="col-sm-6 d-flex flex-column">
                                            <h5>CVV</h5>
                                            <input class="paymentinfo" id="cvv" type="password" name="cvv">
                                            <%if (session.getAttribute("OrderErrCVV") != null) {%><span><%=session.getAttribute("OrderErrCVV")%></span><%session.removeAttribute("OrderErrCVV");
                                                                                            }%>

                                        </div>
                                    </div>
                                </div>
                                <!-- Cash -->
                                <div class="p-2 align-items-center d-flex" style="gap:10px;">                                
                                    <input type="radio" id="cash" name="method" value="Cash">
                                    <i class="fa fa-money" style="font-size:36px"></i>
                                    <label for="card">Cash</label><br>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- sidebar -->
                    <div class="sticky-side-bar col-4">
                        <div class="bg-white border-round text-center mb-2 align-items-center px-2 py-2">
                            <h5 class="border-bottom py-2">Summary Order</h5>
                            <div class="summary d-flex flex-column" style="overflow-y: scroll; overflow-x: hidden;">
                                <% for (int i = 0; i < cartlist.size(); i++) {
                                        int promoValue = 0;
                                        if (cartlist.get(i).getProductcode().getPromotionid() != null) {
                                            promoValue = cartlist.get(i).getProductcode().getPromotionid().getValue();
                                        }

                                        subtotal += cartlist.get(i).getProductcode().getPrice() * cartlist.get(i).getQuantity();
                                        discount += (cartlist.get(i).getProductcode().getPrice() * promoValue / 100) * cartlist.get(i).getQuantity();
                                %>
                                <div class="p-3">
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <img class="productpic" src="./src/img/product/<%=cartlist.get(i).getProductcode().getImage()%>" alt="alt"/>
                                        </div>
                                        <div class="col-sm-7">
                                            <div class="d-flex flex-column">
                                                <div class="pb-1 text-start"><%=cartlist.get(i).getProductcode().getProductname()%></div>
                                                <div class="text-start"><%= "RM " + (cartlist.get(i).getProductcode().getPrice() - (cartlist.get(i).getProductcode().getPrice() * promoValue / 100)) + " X " + cartlist.get(i).getQuantity()%></div>
                                                <div class="text-end">Item total</div>
                                                <div class="text-end" style="color:#F97561;"><%=(cartlist.get(i).getProductcode().getPrice() - (cartlist.get(i).getProductcode().getPrice() * promoValue / 100)) * cartlist.get(i).getQuantity()%></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                            <!-- calculation -->
                            <div class="pt-4 pb-2 amount d-flex flex-column border-top mt-3" >
                                <div class="row">
                                    <div class="col-8">
                                        <p>Subtotal</p>
                                    </div>
                                    <div class="col-4 text-start">
                                        <p><%="RM " + subtotal%></p>
                                        <input type="hidden" name="subtotal" value="<%=subtotal%>"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-8">
                                        <p>Shipping</p>
                                    </div>
                                    <div class="col-4 text-start">
                                        <% if (subtotal >= 200)
                                                shipping = 0;
                                        %>
                                        <p><%="RM " + shipping%></p>
                                        <input type="hidden" name="shipping" value="<%=shipping%>"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-8">
                                        <p>Discount</p>
                                    </div>
                                    <div class="col-4 text-start">
                                        <p><%="RM " + discount%></p>
                                        <input type="hidden" name="discount" value="<%=discount%>"/>
                                    </div>
                                </div>
                            </div>
                            <div class="pt-4 amount d-flex flex-column border-top" >
                                <div class="row">
                                    <div class="col-8">
                                        <p>Total</p>
                                    </div>
                                    <div class="col-4 text-start">
                                        <% total = (subtotal + shipping - discount);%>
                                        <p><%="RM " + total%></p>
                                        <input type="hidden" name="totalAmt" value="<%=total%>"/>
                                    </div>
                                </div>
                            </div>
                            <input class="mt-2" id="confirmorder" type="submit" name="submit" value="Confirm Order">
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <%@include file="./part/script.html" %>

        <script defer>
            $(document).ready(function () {
                $('input[name="method"]').change(function () {
                    console.log("test");
                    var inputValue = $(this).attr("value");
                    if (inputValue === "Card") {
                        $('#cardnum').prop("required", true);
                        $('#expdate').prop("required", true);
                        $('#nameoncard').prop("required", true);
                        $('#cvv').prop("required", true);
                        $("#carddetails").show();
                    } else if (inputValue === "Cash") {
                        $('#cardnum').val('');
                        $('#expdate').val('');
                        $('#nameoncard').val('');
                        $('#cvv').val('');
                        $('#cardnum').prop("required", false);
                        $('#expdate').prop("required", false);
                        $('#nameoncard').prop("required", false);
                        $('#cvv').prop("required", false);
                        $("#carddetails").hide();
                    }
                });
            });
        </script>
    </body>
</html>