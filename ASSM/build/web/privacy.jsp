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
        <title>Petto - Privacy Policy</title>
        <style>
        .privacy-area{
            padding: 40px 0
        }

        .privacy-area h4{
            font-family: var(--font1);
        }

        .privacy-title{
            font-weight: 500;
            padding-top: 30px;
            margin-bottom: 6px;
        }
        </style>

    </head>

    <body>
        <div id="header">
            <%@include file="/part/header.jsp" %>
        </div>

        <div>
            <div class="container">
                <div class="privacy-area">
                    <h4>Privacy Policy</h4>
                    <div class=privacy-details>
                        <p class="privacy-title">Accountability</p>
                        <span>We will be responsible for all personal data collected. All personal data
                        collected will be used and processed fairly and lawfully while in 
                        our possession and custody. We ensure all our customers that we will
                        be accountable for our organisations compliance to our Privacy 
                        Policy.</span>
                        <p class="privacy-title">Specifying Purposes</p>
                        <span>Personal data collected, will not be used for a new purpose unless we obtain consent 
                        from our customers. We are the sole owner of the personally identifiable information collected 
                        on this site. We collect personally identifiable information for the sole purpose of 
                        registering a user for our web site.</span>
                        <p class="privacy-title">Consent</p>
                        <span>We assure all customers that all personal information collected would be used or 
                        disclosed only for the purposes for which it was collected.</span>
                        <p class="privacy-title">Limiting Collection</p>
                        <span>Only the necessary personal data is collected from customers for business purposes. 
                        Both the amount and the type of data collected shall be limited to that which is necessary
                         to fulfill the purposes identified.</span>
                        <p class="privacy-title">Accuracy</p>
                        <span>We ensure our customers that all personal information collected is accurate and 
                        kept up to date. We do not maintain duplicate copies of personal information in different systems.</span>
                        <p class="privacy-title">Safeguards</p>
                        <span>We ensure our customers that appropriate security safeguards are in place 
                        to protect personal data against unauthorized access, misuse, disclosure, copying, 
                        use, alteration, accidental loss or theft, destruction or damage.Only authorized personals have 
                        access to our systems. Consultants, contractors or other external parties do not have access to the data.</span>
                        <p class="privacy-title">Openness</p>
                        <span>Our data protection policy (Privacy Policy) is displayed on the web 
                        site and the policy is set out in the same language medium as the web site. 
                        We encourage all our customers to read our Privacy Policy to understand our objectives 
                        of collection their personal data.</span>
                        <p class="privacy-title">Links</p>
                        <span>This web site contains links to other sites. Please be aware that we are not 
                        responsible for the privacy practises of such other sites. 
                        This Privacy Policy applies soley to information collected by this
                        web site.</span>
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
