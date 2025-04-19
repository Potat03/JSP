<%-- 
    Document   : contact us
    Created on : Apr 6, 2023, 12:42:43 PM
    Author     : kai xin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="/part/link.html" %>
        <link rel="stylesheet" href="./src/css/main.css">
        <title>Petto Shop - Contact Us</title>
        <style>
            .contact-item{
                display:flex;
                padding-bottom: 15px;
            }
            
            .contact-item-icon{
                padding-right: 40px;
            }

            .contact-item a{
                text-decoration:none;
                color: black;
            }

            .contact-item a:hover{
                color: grey;
            }

            .hour-title , .hour-item{
                display: flex;
                flex-direction: column;
            }

            .hour-title{
                padding-right: 35px;
            }

            section{
                padding: 80px 0;
            }

            .contact-area{
                position: relative;
                background: #FFFAF6;
                border-radius: 0% 0% 0% 0% / 0% 0% 0% 0%;
                box-shadow: 20px 20px rgba(0,0,0,.15);
            }

            .contact-inner-area{
                padding: 30px;
                font-family: var(--font1);
            }

        </style>
    </head>
    <body>
        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>

        <section>
            <div class=container>
                <div class="contact-area">
                    <div class="contact-inner-area">
                        <div class="row">
                            <div class="col-6">
                                <div>
                                    <h4>Contact Us</h4>
                                    <p>Our friendly staff would love to hear from you !</p>
                                </div>
                                <div class="contact-details">
                                    <div class="contact-item">
                                        <div class="contact-item-icon">
                                            <i class="fa-solid fa-location-dot" style="color: #FFCA0F;"></i>
                                        </div>
                                        <span>
                                            No.15 Jalan Cermai Taman Perdamai,
                                            56000 Selangor, Wilayah Persekutuan Kuala Lumpur
                                        </span>
                                    </div>
                                    <div class="contact-item">
                                        <div class="contact-item-icon">
                                            <i class="fa-solid fa-phone" style="color: #FFCA0F;"></i>
                                        </div>
                                        <a href="tel:03-33852415">03-33852415</a>
                                    </div>
                                    <div class="contact-item">
                                        <div class="contact-item-icon">
                                            <i class="fa-regular fa-clock" style="color: #FFCA0F;"></i>
                                        </div>
                                        <div class="contact-opening-hours d-flex">
                                            <div class="hour-title">
                                                <span>Weekday</span>
                                                <span>Weekend</span>
                                                <span>Holiday</span>
                                            </div>

                                            <div class="hour-item">
                                                <span>08:30 - 20:30</span>
                                                <span>08:30 - 20:30</span>
                                                <span>08:30 - 20:30</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="contact-item">
                                        <div class="contact-item-icon">
                                            <i class="fa-regular fa-envelope" style="color: #FFCA0F;"></i>
                                        </div>
                                        <a href="mailto:pettoCS@gmail.com">pettoCS@gmail.com</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6">
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2385.8818696662074!2d101.65850701675319!3d3.175641213177475!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31cc488a3f25ff3d%3A0xdddf2c708ac36c5a!2sSolaris%20Mont%20Kiara%2C%2050480%20Kuala%20Lumpur%2C%20Federal%20Territory%20of%20Kuala%20Lumpur!5e0!3m2!1sen!2smy!4v1682593959693!5m2!1sen!2smy" 
                                width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" 
                                referrerpolicy="no-referrer-when-downgrade"></iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </div>    
        </section>
        <div id="footer"><div id="header">
                <%@include file="./part/footer.jsp" %>
            </div></div>
            <%@include file="/part/script.html" %>
    </body>
</html>
