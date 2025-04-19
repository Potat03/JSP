<%-- Document : login Created on : Apr 6, 2023, 12:42:43 PM Author : vkloo --%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Entities.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entities.Orderlist"%>
<%@page import="Entities.Orders"%>
<%@page import="java.util.List"%>
<%

    if (session.getAttribute("admin") == null || (session.getAttribute("adminmode") != "staff" && session.getAttribute("adminmode") != "manager")) {
        response.sendRedirect("login.jsp");
    }
    String id = null;
    List<Orderlist> orderlist = new ArrayList();
    List<Product> productlist = new ArrayList();
    Orders order = new Orders();
    if (request.getParameter("id") == null) {
        response.sendRedirect("order.jsp");
    } else {
        id = request.getParameter("id");
        order = (Orders) session.getAttribute("Order");
        orderlist = (List<Orderlist>) session.getAttribute("orderlist");
        productlist = (List<Product>) session.getAttribute("productlist");
    }
    SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
            .admin-nav-style {
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
                    <div class="row">
                        <div style="padding: 40px 20px 20px 0px;">
                            <div class="h3" style="padding-left: 10px;">Customer Order Details</div>
                            <div class="h3 pt-3" style="padding-left: 10px;">Order ID : <%=id%>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-8">
                            <div class="py-2 px-3" style="border-radius: 10px; background-color: white;">
                                <div class="row justify-content-evenly border-bottom mb-2 p-1">
                                    <div class="col-6">Product</div>
                                    <div class="col-2 text-center">Unit Price</div>
                                    <div class="col-2 text-center">Quantity</div>
                                    <div class="col-2 text-center">Total Price</div>
                                </div>
                                <% for (int i = 0; i < productlist.size(); i++) {
                                       
                                %>
                                <div class="row justify-content-evenly align-items-center py-3">
                                    <div class="d-flex align-items-center col-6">
                                        <img src="../src/img/product/<%=productlist.get(i).getImage()%>" width="100">
                                        <div style="width:185px;">
                                            <p style="text-overflow:ellipsis; overflow: hidden;"><%=productlist.get(i).getProductname()%></p>
                                        </div>
                                    </div>
                                    <div class="col-2 text-center"><%=productlist.get(i).getPrice()%></div>
                                    <div class="col-2 text-center" style="color: #F97561;"><%=orderlist.get(i).getQuantity()%></div>
                                    <div class="col-2 text-center"><%=productlist.get(i).getPrice() * orderlist.get(i).getQuantity() %></div>
                                </div>
                                <%}%>
                            </div>

                            <div class="py-2 px-3 my-5"
                                 style="border-radius: 10px; background-color: white;">
                                <div class="row justify-content-evenly border-bottom mb-2 p-1">
                                    Customer Details
                                </div>
                                <div class="row justify-content-evenly mb-2">
                                    <div class="col-4 text-start">Name</div>
                                    <div class="col-8 text-end"><%=order.getCustomerid().getFirstname() + " " + order.getCustomerid().getLastname()%></div>
                                </div>
                                <div class="row justify-content-evenly mb-2">
                                    <div class="col-4 text-start">Phone Number</div>
                                    <div class="col-8 text-end"><%=order.getPhonenumber()%></div>
                                </div>
                                <div class="row justify-content-evenly mb-2">
                                    <div class="col-4 text-start">Address</div>
                                    <div class="col-8 text-end"><%=order.getAddress()%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="py-2 px-3"
                                 style="border-radius: 10px; background-color: white;">
                                <div class="row justify-content-evenly border-bottom mb-2 p-1">
                                    Order Summary
                                </div>
                                <div class="row justify-content-evenly mb-2">
                                    <div class="col-4 text-start">Order Created</div>
                                    <div class="col-8 text-end"><%=df.format(order.getCreateddate())%></div>
                                </div>
                                <div class="row justify-content-evenly mb-2">
                                    <div class="col-4 text-start">Sub Total</div>
                                    <div class="col-8 text-end">RM <%=order.getSubtotal()%></div>
                                </div>
                                <div class="row justify-content-evenly mb-2">
                                    <div class="col-4 text-start">Discount</div>
                                    <div class="col-8 text-end">RM <%=order.getPromotionvalue()%></div>
                                </div>
                                <div class="row justify-content-evenly mb-2">
                                    <div class="col-4 text-start">Total</div>
                                    <div class="col-8 text-end">RM <%=order.getTotal()%></div>
                                </div>
                            </div>
                            <div class="py-2 px-3 my-5"
                                 style="border-radius: 10px; background-color: white;">
                                <div class="row justify-content-evenly align-items-center px-3">
                                    <div class="col-4 text-start">Order Status</div>
                                    <div class="col-8">
                                        <form class="d-flex align-items-center justify-content-end" style="gap: 20px;" action="adminUpdateOrderStatusServlet" method="POST">
                                            <input type="hidden" name="id" value="<%=order.getOrderid()%>">
                                            <select class="border" aria-label="status" name="status">
                                                <option value="Packing" <%=order.getStatus().equals("Packing") ? "selected" : ""%>>Packing</option>
                                                <option value="Shipping" <%=order.getStatus().equals("Shipping") ? "selected" : ""%>>Shipping</option>
                                                <option value="Delivered" <%=order.getStatus().equals("Delivered") ? "selected" : ""%>>Delivered</option>
                                            </select>   
                                            <button type="submit" class="btn py-1 px-2" style="background-color: #FFEFB7;">Update</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="../part/script.html" %>
    </body>

</html>