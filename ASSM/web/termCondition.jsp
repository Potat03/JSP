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
        <title>Petto - Term & Condition</title>
        <style>
        .termCondition-area{
            padding: 40px 0
        }

        .termCondition-area h4{
            padding-bottom: 15px;
            font-family: var(--font1);
        }
        .term-details li{
            padding-bottom: 15px;
        }
        </style>

    </head>

    <body>
        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>

        <div class="termCondition-outlayer">
            <div class="container">
                <div class="termCondition-area">
                    <h4>Term and Condition</h4>
                    <div class="term-details">
                        <p style="font-weight: 300;">Personal Data Protection Act - Petto Sdn. Bhd. (552023-W)</p>
                        <p>It is a long established fact that a reader will be distracted by the readable content of a
                        page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal 
                        distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. 
                        Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a 
                        search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over 
                        the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>
                        <ul>
                            <li>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, 
                            by injected humour, or randomised words which don't look even slightly believable.</li>
                            <li>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, 
                            by injected humour, or randomised words which don't look even slightly believable.</li>
                            <li>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, 
                            by injected humour, or randomised words which don't look even slightly believable.</li>
                            <li>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, 
                            by injected humour, or randomised words which don't look even slightly believable.</li>
                            <li>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, 
                            by injected humour, or randomised words which don't look even slightly believable.</li>
                        </ul>

                    </div>
                </div>
            </div>
        </div>
        <div id="footer">   
            <%@include file="/part/footer.jsp" %>
        </div>
        <%@include file="/part/script.html" %>
    </body>
</html>
