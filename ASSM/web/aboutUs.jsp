<%-- 
    Document   : About Us
    Created on : Apr 7, 2023, 11:30:17 AM
    Author     : kai xin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./src/css/profile.css">
        <link rel="stylesheet" href="./src/css/main.css">
        <%@include file="/part/link.html" %>
        <title>Petto - About Us</title>
        <style>
        .about-outlayer{
            padding: 20px 0;
        }

        .about-innerLayer{
            position: relative;
            background: #FFFAF6;
            border-radius: 0% 0% 0% 0% / 0% 0% 0% 0%;
            box-shadow: 20px 20px rgba(0,0,0,.15);
            padding: 40px 30px;
        }

        .about-title{
            border-bottom: 1px solid #d3d3d3;
            width: 180px;
            font-family: var(--font1);
            letter-spacing: 4px;
        }

        .about-details{
            padding-bottom: 40px;
        }

        .about-pet-service{
            padding-bottom: 30px;
        }

        .history-title{
            text-align: center;
            padding-top: 20px;
        }

        .history-pic{
            width: 100%;
        }

        .about-his-right{
            display:flex;
            align-items: center;
        }
        
        .about-history-dot{
            justify-content: space-evenly;
        }

        .about-history-txt{
            justify-content: space-evenly;
        }

        .about-history-dot .his-btn{
            border-radius: 50%;
            color: white;
            width: 15px;
            height: 15px;
            background-color: #D3D3D3;
            cursor: pointer;
            user-select: none;
        }

        .his-btn.active{
            background-color: var(--yellowColor);
            border:none;
        }

        span{
            letter-spacing: 1px;
        }
        
        .about-commitment a{
            color: var(--yellowColor);
        }
        </style>

    </head>

    <body>
        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>

        <div class="about-outlayer">
            <div class="container">
                <div class="about-innerLayer">
                    <div class="about-details">
                        <p class="fw-bold about-title">About Us</p>
                        <h5>Welcome To Petto Shop</h5>
                        <span>Petto Shop has been established in Malaysia since 2010. Our main goal is to please pet owners and pets. 
                        And sell the freshest produce at the best prices, as well as provide friendly and helpful service. So 
                        that pet owners and pets can enjoy the most comfortable and happy shopping experience.</span>

                        <div class="about-history">
                            <p class="fw-bold history-title">Petto Shop History</p>
                            <div class="about-history-dot d-flex" id="btn-area">
                                <p class="his-btn active" id="his1" onclick="changeContent('his1')">.</p>
                                <p class="his-btn" id="his2" onclick="changeContent('his2')">.</p>
                                <p class="his-btn" id="his3" onclick="changeContent('his3')">.</p>
                            </div>
                            <div class="about-history-txt d-flex">
                                <p>2010</p>
                                <p>2015</p>
                                <p>2020</p>
                            </div>
                            <div class=g-0>
                                <div class="row">
                                    <div class="col-6">
                                        <img src="src/img/aboutUs/aboutPet.png" class="history-pic" id="hisImg">
                                    </div>
                                    <div class="col-6 about-his-right">
                                        <div class="about-his-details">
                                            <h5 id="hisTitle">Welcome</h5>
                                            <span id="hisTxt">Lorem ipsum dolor sit amet consectetur adipisicing elit. 
                                            Atque ab quis nesciunt reprehenderit, asperiores laudantium corporis voluptate</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="about-pet-service">
                        <p class="fw-bold about-title">Pet Service</p>
                        <ul>
                            <li>You can shop at any of our 100 outlets in Malaysia and enjoy the same top quality and service</li>
                            <li>A Pet Care Consultant is also available in our store and is a Hill's Certified Veterinary Nutrition 
                            Advocate. Can provide you with professional advice at any time</li>
                            <li>In our store, pet owners can enjoy shopping with their pets.</li>
                        </ul>
                    </div>
                    <div class="about-commitment">
                        <p class="fw-bold about-title">Our Commitment</p>
                        <p>To give pet owners the best possible experience, we offer:</p>
                        <p>GUARANTEE - Our exchange policy allows you to return the guaranteed product within 7 days. More details see on <a href="termCondition.jsp">Term & Condition</a></p>
                        <p>Knowledge - Our pet consultants must have certification from pet training schools and give you the best advice on pet care</p>
                        <p>Convenience - 24-hour online shopping and timely home delivery to meet your needs</p>
                        <p>Breeds - We will bring you products for different pet breeds</p>
                        <p>Freshness - ensuring that every product is always fresh</p>
                        <p>Member Privileges - Ability to enjoy membership benefits at our store</p>
                    </div>
                </div>
            </div>
        </div>
        <div id="footer">   
            <%@include file="/part/footer.jsp" %>
        </div>
        <%@include file="/part/script.html" %>
        <script>
            function changeContent(hisID) {
            const image = document.getElementById("hisImg");
            const title = document.getElementById("hisTitle");
            const text = document.getElementById("hisTxt");
            var header = document.getElementById("btn-area");
            var btns = header.getElementsByClassName("his-btn");

                for (var i = 0; i < btns.length; i++) {
                    btns[i].addEventListener("click", function() {
                    var current = document.getElementsByClassName("active");
                    current[0].className = current[0].className.replace(" active", "");
                    this.className += " active";
                    });
                }
                switch(hisID) {
                    case "his1":
                        image.src = "src/img/aboutUs/aboutPet.png";
                        title.innerText = "Welcome";
                        text.innerText = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Atque ab quis nesciunt reprehenderit, asperiores laudantium corporis voluptate";
                        button.classList.add('active');
                        break;
                    case "his2":
                        image.src = "src/img/aboutUs/aboutPet2.png";
                        title.innerText = "Let have a nice experience";
                        text.innerText = "Lorem ipsum dolor sit amet consectetur adipisicing elit.Atque ab quis nesciunt reprehenderit, asperiores laudantium corporis voluptate";
                        break;
                    case "his3":
                        image.src = "src/img/aboutUs/aboutPet3.jpg";
                        title.innerText = "Thank You For Visiting";
                        text.innerText = "Lorem ipsum dolor sit amet consectetur adipisicing elit.Atque ab quis nesciunt reprehenderit, asperiores laudantium corporis voluptate";
                        break;
                    default:
                        break;
                }
                
            }
        </script>
    </body>
</html>
