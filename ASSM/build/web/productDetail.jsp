<%-- 
    Document   : ProductDetail
    Created on : Apr 23, 2023, 12:32 AM
    Author     : LohThiamWei
--%>
<%@page import="Entities.Product"%>
<%@page import="java.util.List"%>
<%
    List<Product> products = (List<Product>) session.getAttribute("products");
    Product product = new Product();
    for (int i = 0; i < products.size(); i++) {
        if (products.get(i).getProductcode() == Integer.parseInt(request.getParameter("id"))) {
            product = products.get(i);
        }
    }
    int promoValue = 0;
    if(product.getPromotionid() != null){
        promoValue = product.getPromotionid().getValue();
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
            .content {
                padding: 20px;
            }
            .pathInfo span{
                font-weight: 600;
                font-style: normal;
                color:#4f9796;
            }
            .product-content{
                display:flex;
                padding: 10px 15px;
                gap:20px;
            }

            .imgbox{
                width: 400px;
                display:flex;
                align-items: center;
            }
            .imgbox img{
                width: 300px;
                height: 300px;
                overflow: hidden;
            }
            .left-bar{
                display: block;
                background-color: #7b7b7b;
                width: 3px;
                height: 15px;
                border-radius: 5px;
                transform: rotate(-45deg);
                position:absolute;
                bottom: 8px;
                transition: 0.2s;
            }
            .right-bar{
                display: block;
                background-color: #7b7b7b;
                width: 3px;
                height: 15px;
                border-radius: 5px;
                transform: rotate(45deg);
                position:absolute;
                top: 8px;
                transition: 0.2s;
            }
            .right-panel{
                display:flex;
                flex-direction: column;
            }
            .promotionBox{
                display: inline;
            }
            .promotionBox div{
                background-color: #e1e7e3;
                padding: 5px 10px;
                border-radius: 5px;
                display: inline-block;
            }
            .promotionBox h6{
                margin: 0;
            }
            .promotionBox p{
                margin: 0;
                font-size: 14px;
            }
            .quantityBox{
                padding: 20px 0;
                width: 400px;
            }
            .quantityBox h6{
                margin: 0;
                padding-bottom: 10px;
                align-self:end;
            }
            .quantityBox p{
                margin: 0;
            }
            .quantityInput{
                display: flex;
                height:40px;
            }
            .quantityInput input::-webkit-inner-spin-button,
            .quantityInput input::-webkit-outer-spin-button {
                -webkit-appearance: none;
            }
            .quantityInput button{
                outline: none;
                -webkit-appearance: none;
                background-color: transparent;
                border: none;
                width: 30px;
                flex-grow: 1;
                cursor: pointer;
                margin: 0;
                padding: 0;
                transition: 0.1s;
                border: 1px #4f9796 solid;
            }
            .quantityInput button:first-child{
                border-radius: 0 5px 0 0;
            }
            .quantityInput button:last-child{
                border-radius: 0 0 5px 0;
            }
            .quantityInput button:hover{
                border: 1px #4f9796 solid;
                background-color: #4f9796;
            }
            .quantityInput button:active{
                transform: scale(1.1);
            }
            .quantityInput button:before,
            .quantityInput button:after {
                display: inline-block;
                position: absolute;
                content: "";
                width: 10px;
                height: 2px;
                background-color: #212121;
                transform: translate(-50%, -50%);
            }
            .quantityInput button.plus:after {
                transform: translate(-50%, -50%) rotate(90deg);
            }
            .quantityInput input {
                font-family: sans-serif;
                max-width: 60px;
                padding: 5px;
                font-size: 20px;
                text-align: center;
                border: 1px #4f9796 solid;
                border-radius: 5px 0 0 5px;
                outline: none;
            }
            .btnBox{
                display: flex;
                flex-direction: column;
            }
            .addCartBox{
                display:flex;
                width: 400px;
                justify-content: space-between;
                flex-grow: 1;
                align-items: flex-end;
            }
            .addCartBtn{
                font-size:15px;
                color:white;
                background-color: #4f9796;
                border:none;
                width:160px;
                height: 40px;
                font-weight: bold;
                border-radius: 10px;
                transition: 0.2s;
                letter-spacing:1px;
                opacity:0.7;
            }
            .addCartBtn:hover{
                letter-spacing:2px;
                opacity:1;
            }
            .addCartBtn:active{
                letter-spacing:3px;
            }
            .promotionPrice{
                font-weight:bold;
                font-size:28px;
                position:relative;
                color: #00000057;
            }
            .promotionPrice hr{
                position:absolute;
                background-color: #4f9796;
                border:none;
                width: 100%;
                height: 2px;
                top: 5px;
                left: 0;
                z-index: 1;
                opacity:1;
            }
            .price{
                font-weight:bold;
                font-size: 28px;
            }
            .saved{
                display: flex;
                flex-direction: column;
            }
            .saved p{
                margin:0;
                line-height: 15px;
            }
            .saved span:first-child{
                font-size:12px;
                margin-top: 5px;
            }
        </style>
    </head>

    <body>

        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>
        <div class="container">
            <%if (session.getAttribute("successAdd") != null) {%>
            <div class="alert alert-success alert-dismissible fade show position-absolute w-25" role="alert" style="  position: absolute;
                 top: 5%;
                 left: 50%;
                 transform: translate(-50%, 0%);">
                <h4 class="alert-heading">Success!</h4>
                <hr>
                <p class="mb-0"><%=session.getAttribute("successAdd")%></p>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%session.removeAttribute("successAdd");
                }%>
            <%if (session.getAttribute("failAdd") != null) {%>
            <div class="alert alert-danger alert-dismissible fade show position-absolute w-25" role="alert" style="  position: absolute;
                 top: 5%;
                 left: 50%;
                 transform: translate(-50%, 0%);">
                <h4 class="alert-heading">Failed!</h4>
                <hr>
                <p class="mb-0"><%=session.getAttribute("failAdd")%></p>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%session.removeAttribute("failAdd");
                }%>
            <div class="content" style="min-height: 500px;">
                <p class="pathInfo">Home / Product / <span><%=product.getProductname()%></span></p>

                <form action="addToCart" method="POST">
                    <div class="product-content">
                        <div class="left-panel">
                            <div class="imgbox">
                                <img src="./src/img/product/<%=product.getImage()%>" id="imgDisplay" alt="prod">
                            </div>
                        </div>
                        <div class="right-panel">
                            <h3><%=product.getProductname()%></h3>
                            <p><%=product.getDescription()%></p>
                            <%if (product.getPromotionid() != null) {%>
                            <div class="promotionBox">
                                <div>
                                    <h6><%=product.getPromotionid().getValue()%>% Offer</h6>
                                    <p>Buy one get <%=product.getPromotionid().getValue()%>% offer meh</p>
                                </div>
                            </div>
                            <%}%>
                            <div class="priceBox">
                                <div style="padding-top: 5px;display:flex;align-items: baseline;">RM&nbsp
                                    <div class="<%=(product.getPromotionid() != null)?"promotionPrice":"price"%>"><%=(product.getPromotionid() != null)?"<hr>":""%><%=product.getPrice()%></div> 
                                    <%if (product.getPromotionid() != null) {%>
                                    &nbsp&nbsp
                                    <div style="font-weight:bold;font-size: 30px;"><%=product.getPrice() - (product.getPrice() * promoValue / 100)%></div> 
                                    <%}%>
                                    &nbsp
                                    <div style="font-weight:normal;font-size: 12px;">each</div>
                                </div>
                            </div>
                            <div class="quantityBox">
                                <h6>Stock left: <span><%=product.getStock()%></span></h6>
                                <p style="font-size:12px;">Quantity :</p>
                                <div class="quantityInput">
                                    <input class="quantity" min="1" max="10" name="quantity" value="1" type="number" id="quantity" oninput="check(this)">
                                    <div class="btnBox">
                                        <button type="button" onclick="increase()" class="plus"></button>
                                        <button type="button" onclick="decrease()" ></button>
                                    </div>
                                </div>
                            </div>
                            <div class="addCartBox">
                                <h4 style="margin:0;">RM <span id="totalDisplay"><%=product.getPrice() - (product.getPrice() * promoValue / 100)%></span></h4>
                                <div class="saved">
                                    <p><span>Saved</span><br>RM <span style="font-weight:bold;" id="savedDisplay"><%=product.getPrice() * promoValue / 100%></span></p>
                                </div>
                                <button class="addCartBtn" type="submit">
                                    Add To Cart
                                </button>
                            </div>
                            <input type="hidden" name="id" value="<%=product.getProductcode()%>">
                            <input type="hidden" id="stock" value="<%=product.getStock()%>">
                            <input type="hidden" id="promotion" value="<%=promoValue%>">
                            <input type="hidden" id="price" value="<%=product.getPrice()%>">
                            <input type="hidden" id="total" value="20">

                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div id="footer">   
            <%@include file="./part/footer.jsp" %>
        </div>
        <%@include file="/part/script.html" %>
    </body>

    <script>
        let imageDisplay = document.getElementById("imgDisplay");
        function increase() {
            document.getElementById("quantity").value++;
            check();
        }
        function decrease() {
            document.getElementById("quantity").value--;
            check();
        }
        function check() {
            let el = document.getElementById("quantity");
            let quantity = parseInt(el.value);
            let max = parseInt(document.getElementById("stock").value);
            if (quantity > max) {
                el.value = max;
                quantity = max;
            } else if (quantity < 1) {
                el.value = 1;
                quantity = 1;   
            } else if (isNaN(quantity)){
                el.value = 1;
                quantity = 1;
            }
            console.log(quantity);
            let promotion = parseInt(document.getElementById("promotion").value);
            let price = parseInt(document.getElementById("price").value);
            let total = price * quantity * ((100 - promotion) / 100);
            let saved = price * quantity * (promotion / 100);
            document.getElementById("totalDisplay").innerHTML = total.toFixed(2);
            document.getElementById("total").value = total.toFixed(2);
            document.getElementById("savedDisplay").innerHTML = saved.toFixed(2);
        }
    </script>
</html>
