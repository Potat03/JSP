<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="Entities.Payment"%>
<%@page import="Entities.Orders"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Entities.Product"%>
<%@page import="java.util.ArrayList"%>
<%
    List<Product> products = new ArrayList();
    products = (List<Product>) session.getAttribute("products");
    Product prod = new Product();
    List<Integer> bestSelling = prod.getBestSelling();
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="./part/link.html"%>
        <link rel="stylesheet" href="./src/css/mainpage.css">
        <link rel="stylesheet" href="./src/css/main.css">
        <title>Petto Shop</title>
    </head>
    <body>
        <%if (session.getAttribute("orderSuccess") != null) {
                Orders order = (Orders) session.getAttribute("orderSuccess");
                Payment payment = order.getPayment();
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(order.getCreateddate());
                calendar.add(Calendar.DAY_OF_YEAR, 3);
                Date deliverDate = calendar.getTime();
        %>
        <div class="alert alert-success position-absolute w-75 alert-dismissible fade show" role="alert" style="
             z-index: 999;
             top: 2%;
             left: 50%;
             transform: translate(-50%, 0%);
             ">
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            <h4 class="alert-heading">Order Succesfully Created!</h4>
            <p>Transaction ID     : <%=payment.getTransactionid()%></p>
            <p>Order Made On      : <%=order.getCreateddate()%></p>
            <p>Estimated Delivery : <%=deliverDate%></p>
            <hr>
            <p class="mb-0">To see your order, <span class="text-primary" onclick="event.preventDefault(); document.getElementById('customer-order-detail-form').submit();">Click here!</span></p>
            <form id="customer-order-detail-form" action="getCustomerOrderDetailServlet" method="POST">
                <input type="hidden" id="orderid" name="orderid" value="<%=order.getOrderid()%>">
            </form>
        </div>
        <%session.removeAttribute("orderSuccess");
            }%>
        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>
        <div class="container">
            <div class="mainPage-corousel">
                <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="./src/img/sliderPic.png" class="d-block w-100" alt="..." onclick="event.preventDefault(); document.getElementById('filter_none').submit();">
                        </div>
                        <div class="carousel-item">
                            <img src="./src/img/sliderPic2.png" class="d-block w-100" alt="..." onclick="event.preventDefault(); document.getElementById('filter_none').submit();">
                        </div>
                        <div class="carousel-item">
                            <img src="./src/img/sliderPic3.png" class="d-block w-100" alt="..." onclick="event.preventDefault(); document.getElementById('filter_none').submit();">
                        </div>
                        <div class="carousel-item">
                            <img src="./src/img/sliderPic4.jpg" class="d-block w-100" alt="..." onclick="event.preventDefault(); document.getElementById('filter_none').submit();">
                        </div>
                    </div>
                    <form id="filter_none" action="getProductList" method="post">
                    </form>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls"
                            data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls"
                            data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
            </div>

            <div class="bestSell-area py-5">
                <h6 class="bestSell-txt pb-4">BEST SELLING</h6>
                <div class="row">
                    <%for (int i = 0; i < products.size(); i++) {
                            if (bestSelling.contains(products.get(i).getProductcode())) {
                    %>
                    <div class="col-3 p-3">
                        <div class="card rounded h-100"  style="border-color: darkkhaki;" onclick="location.href='productDetail.jsp?id=<%= products.get(i).getProductcode()%>'">
                            <div class="card-img-top p-3">
                                <img class="img-thumbnail border-0" src="./src/img/product/<%= products.get(i).getImage()%>" draggable="false" width="210" alt="product">
                            </div>
                            <hr style="border-color: darkkhaki;">
                            <div class="card-body">
                                <div class="card-title">
                                    <p><%= products.get(i).getProductname()%></p>
                                </div>
                                <div class="card-text">
                                    <p>RM<%= products.get(i).getPrice()%></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%}
                        }%>
                </div>
            </div>

            <div class="mainPage-partner">
                <h6 class="partner-txt pb-5">THE PREMIUM BRANDS</h6>
                <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <div class="row">
                                <% for (int i = 1; i < 5; i++) {%>
                                <div class="col-lg-3">
                                    <img src="./src/img/partnetLogo/logo<%=i%>.png" class="d-block w-100" alt="...">
                                </div>
                                <%}%>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <div class="row">
                                <% for (int i = 5; i < 9; i++) {%>
                                <div class="col-lg-3">
                                    <img src="./src/img/partnetLogo/logo<%=i%>.png" class="d-block w-100" alt="...">
                                </div>
                                <%}%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="mainPage-join d-flex">
            <div class="mainPage-joinArea">
                <div class="joinTxt-area ">
                    <div class="joinTxt">
                        <h5 class="pb-3">Come And Join Our Member</h5>
                        <h5 class="pb-3">To Enjoy Our Member Benefits</h5>
                    </div>
                    <div class="joinbtn pt-3">
                        <button type="button" onclick="window.location.href = 'register.jsp'">JOIN US</button>
                    </div>
                </div>

            </div>
            <div class="mainPage-joinBg">
                <img src="./src/img/joinUs/catbg.png" class="joinPic-cat">
            </div>
        </div>

        <div id="footer">
            <%@include file="./part/footer.jsp" %>
        </div>

        <%@include file="./part/script.html" %>
    </body>

</html>