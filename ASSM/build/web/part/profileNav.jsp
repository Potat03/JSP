<%
    String activePage = (String) session.getAttribute("activePage");
%>
<body>
    <div class="col-left-area">
        <div class="my-profile-area">
            <a class="profile-nav <%= activePage.equals("profile") ? "active" : ""%>" href="profile.jsp"><i class="fa-solid fa-user"></i><span>My Profile</span></a>
        </div>
        <div class="change-pass-area">
            <a class="profile-nav <%= activePage.equals("password") ? "active" : ""%>" href="profileChangePass.jsp"><i class="fa-solid fa-lock"></i><span>Change Password</span></a>
        </div>
        <div class="order-area">
            <a class="profile-nav <%= activePage.equals("order") ? "active" : ""%>" onclick="event.preventDefault(); document.getElementById('customer-order-form').submit();"><i class="fa-solid fa-clipboard"></i><span>Order</span></a>
            <form id="customer-order-form" action="getCustomerOrdersServlet" method="POST"></form>
        </div>
        <div class="logout-area">
            <a class="profile-nav" onclick="event.preventDefault(); document.getElementById('customer-logout-form').submit();"><i class="fa-solid fa-right-from-bracket"></i><span>Logout</span></a>
            <form id="customer-logout-form" action="logoutServlet" method="POST"></form>
        </div>
    </div>
</body>
    