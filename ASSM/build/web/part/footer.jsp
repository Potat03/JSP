  <footer>
        <div class="pageFooter">
            <div class="page-Footer container">
                <div class="footerLogo">
                    <img src="./src/img/petto.jpg" class="footerShopLogo" onclick="window.location.href = 'index.jsp'" draggable="false" style="cursor:pointer;">
                </div>
                <div class="footerNav">
                    <p class="fw-bold">Navigation</p>
                    <div class="footerNavItem">
                        <p onclick="window.location.href = 'aboutUs.jsp'">About Us</p>
                        <p onclick="window.location.href = 'contact.jsp'">Contact Us</p>
                    </div>
                </div>
    
                <div class="footerLegal">
                    <p class="fw-bold">Legal</p>
                    <div class="footerLegalItem">
                        <p onclick="window.location.href = 'termCondition.jsp'">Term & Condition</p>
                        <p onclick="window.location.href = 'privacy.jsp'">Privacy policy</p>
                    </div>
                </div>
    
                <div class="footerSocial">
                    <p class="fw-bold">Social Media</p>
                    <div class="footerSocialItem">
                        <div>
                            <a href="https://www.instagram.com/instagram/"><i class="fa-brands fa-instagram" style="color: blueviolet;"></i>Instagram</a>
                        </div>
                        <div>
                            <a href="https://www.facebook.com/facebook"><i class="fa-brands fa-facebook" style="color: dodgerblue;"></i>Facebook</a>
                    
                        </div>
                        <div>
                            <a href="https://twitter.com/Twitter"><i class="fa-brands fa-twitter" style="color: deepskyblue;"></i>Twitter</a>
                        </div>
                    </div>
                    <p class="fw-bold">Payment</p>
                    <div class="footerPaymentItem">
                        <ul class="row">
                            <li class="col-6 pb-3"><img src="./src/img/visa.jpg"></li>
                            <li class="col-6 pb-3"><img src="./src/img/master.jpg"></li>
                            <li class="col-6 pb-3"><img src="./src/img/fpx.jpg"></li>
                            <li class="col-6 pb-3"><img src="./src/img/duitnow.jpg"></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="page-copyright container d-flex">
                <div class="footer-copyright-content">
                    <span><i class="fa-regular fa-copyright"></i> <%=session.getAttribute("compname")%>. All Rights Reserved </span>
                </div>
                <div class="footer-copyright-content2">
                    <span><%=session.getAttribute("compcopyright")%></span>
                </div>
            </div>
        </div>
    </footer>