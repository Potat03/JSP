<%-- 
    Document   : ProductList
    Created on : Apr 7, 2023, 11:30:17 AM
    Author     : vkloo
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Entities.Product"%>
<%@page import="Entities.Category"%>
<%

    List<Product> products = (List<Product>) session.getAttribute("products");
    List<Category> categories = (List<Category>) session.getAttribute("categories");
    String[] filters = new String[0];
    if (request.getParameter("filter") != null) {
        List<Product> temp = new ArrayList();
        filters = request.getParameterValues("filter");
        for (int i = 0; i < products.size(); i++) {
            for (String filter : filters) {
                if (products.get(i).getProdCategories().contains(Integer.parseInt(filter))) {
                    temp.add(products.get(i));
                }
            }
        }
        products = temp;
    }

    if (request.getParameter("name") != null) {
        List<Product> temp = new ArrayList();
        try {
            for (int i = 0; i < products.size(); i++) {
                if (products.get(i).getProductcode() == Integer.parseInt(request.getParameter("name"))) {
                    temp.add(products.get(i));
                }
            }
        } catch (Exception ex) {
            for (int i = 0; i < products.size(); i++) {
                if (products.get(i).getProductname().toUpperCase().contains(request.getParameter("name").toUpperCase())) {
                    temp.add(products.get(i));
                }
            }
        }

        products = temp;
    }

%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="/part/link.html" %>
        <link rel="stylesheet" href="./src/css/mainpage.css">
        <link rel="stylesheet" href="./src/css/main.css">
        <title>Petto Shop</title>
        <style>
            .line{
                width: 100px;
            }

            .search{
                background-color: #FFFAF6 !important;
            }

            .price-wrapper{
                position: relative;
                display: inline-block;
            }

            .price-slash{
                position: relative;
                width: 100%;
                height: 0;
                border-top: 2px solid red;
                transform: rotate(-11deg);
                top: 14px;
            }

            .discount-price-wrapper{
                position: relative;
                display: inline-block;
            }

            .discoubnt-text{
                font-size: 10px;
            }
            .discount-wrapper{
                position: absolute;
                color:red;
                top: 0;
                right: 5px;
                padding: 7px;
                padding-bottom: 15px;
                background-color: yellow;
                clip-path: polygon(0 0, 100% 0%, 100% 100%, 50% 82%, 0 100%);
            }
        </style>
    </head>

    <body>
        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-3">
                    <form action="productList.jsp">
                        <div class="py-2 px-3">
                            <div class="search-bar mt-3">
                                <label class="p-2 h5" for="search">Search</label>
                                <div class="input-group border">
                                    <input type="text" class="form-control border-0 search" name="name" id="name" <%= (request.getParameter("name") != null) ? "value=" + request.getParameter("name") + "" : "nothing"%>>
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary border-0 search" type="button"><i class="fa fa-search"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="category-option mt-4">
                                <label class="px-2  h5">Category</label>
                                <hr>
                                <div class="container">
                                    <% for (int i = 0; i < categories.size(); i++) {%>
                                    <div class="py-1 d-flex" style="gap: 30px;">
                                        <label class="form-check-label" style="flex-grow: 1;"><%= categories.get(i).getCategoryname()%></label>
                                        <input type="checkbox" class="form-check-input" name="filter" id="filter" value="<%=categories.get(i).getCategoryid()%>"
                                               <%for (String filter : filters) {%>
                                               <%= (Integer.parseInt(filter) == categories.get(i).getCategoryid()) ? "checked" : ""%>
                                               <%}%> >
                                    </div>
                                    <%}%>

                                    <button type="submit" class="btn mt-2 ms-3" style="background-color: #FFEFB7;">Filter</button>
                                </div>                             
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col">
                    <div class="container p-3">
                        <div class="row">
                            <% for (int i = 0; i < products.size(); i++) {%>
                            <div class="col-3 p-2">
                                <div class="card py-3 px-2 position-relative h-100">
                                    <div class="onclick-wrapper position-absolute top-0 bottom-0 start-0 end-0" onclick="window.location.href = 'productDetail.jsp?id=<%=products.get(i).getProductcode()%>'"></div>
                                    <img src="src/img/product/<%= products.get(i).getImage()%>" class="card-img-top w-100" alt="productname" style="object-fit: cover;" height="210">
                                    <div class="card-body mt-4 border-top d-flex" style="flex-direction: column; justify-content: flex-end;">
                                        <h5 class="card-title" style="flex-grow:1;"><%= products.get(i).getProductname()%></h5>
                                        <div class="d-flex align-items-center">
                                            <div class="price-wrapper">
                                                <% if (products.get(i).getPromotionid() != null) {%>
                                                <div class="price-slash"></div>
                                                <%}%>
                                                <p>RM<%= products.get(i).getPrice()%></p>
                                            </div>
                                            <% if (products.get(i).getPromotionid() != null) {%>
                                            <div class="discount-price-wrapper ps-2">
                                                <p>RM<%=products.get(i).getPrice() - (products.get(i).getPrice() * products.get(i).getPromotionid().getValue() / 100)%></p>
                                            </div>
                                            <%}%>
                                        </div>
                                        <div class="buttons d-flex">
                                            <form action="addToCart" method="POST">
                                                <input type="hidden" name="id" value="<%=products.get(i).getProductcode()%>"/>
                                                <button type="submit" class="btn btn-primary mx-auto position-relative text-black border-0" style="z-index:3;background-color: #FFEFB7;">Add To Cart</button>
                                            </form>
                                        </div>
                                    </div>
                                    <% if (products.get(i).getPromotionid() != null) {%>
                                    <div class="discount-wrapper">
                                        <div class="discount-text text-center"><%=products.get(i).getPromotionid().getValue()%>%</div>
                                        <div class="discount-text text-center">OFF</div>
                                    </div>
                                    <%}%>
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="footer">   
            <%@include file="./part/footer.jsp" %>
        </div>
        <%@include file="/part/script.html" %>
    </body>
</html>
