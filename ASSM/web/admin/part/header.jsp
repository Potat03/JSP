<%
    String activePage = new String();
    activePage = (String) session.getAttribute("activePage");
%>
<%@page import="Entities.Staff"%>

<style>
    .nav-link{
        opacity: 0.7;
        cursor: pointer;
        user-select: none;
    }

    .nav-link:hover{
        opacity: 0.9; 
    }

    .nav-link.active{
        opacity: 1; 
    }
</style>

<nav class="admin-nav" style="position: sticky;">
    <div class="admin-logo-area">
        <div class="d-flex" style="padding: 30px 25px 20px 25px;">
            <div class="col-4 p-0">
                <img src="../src/img/petto.jpg" class="admin-logo">
            </div>
            <div class="col-8 admin-right">
                <h5 style="color: #41756C;">Petto</h5>
                <p class="m-0" style="color:#41756C;"><span style="color:#51897F;">Hello, </span>
                    <%
                        if (session.getAttribute("adminmode") != null && session.getAttribute("adminmode").equals("staff") && session.getAttribute("admin") != null) {
                            Staff headerStaff = (Staff) session.getAttribute("admin");
                    %>
                    <%=headerStaff.getStaffname()%>
                    <%} else {%>
                    <%="Manager"%>
                    <%}%>
                </p>
            </div>
        </div>
    </div>

    <ul class="navbar-nav justify-content-between d-flex text-center" id="navbar-nav">
        <li class="nav-item" id="nav-item">
            <a class="nav-link <%= activePage.equals("dashboard") ? "active" : ""%>" href="dashboard.jsp">
                <div class="nav-icon"><i class="fa-solid fa-house"></i></div>
                <div class="nav-text">Dashboard</div>
                <div class="nav-angle"><i class="fa-solid fa-chevron-right"></i></div>
            </a>
            <!--<form id="product" action="productServlet" method="post">
            </form>-->
        </li>
        <li class="nav-item" id="nav-item">
            <a class="nav-link <%= activePage.equals("order") ? "active" : ""%>" onclick="event.preventDefault(); document.getElementById('order').submit();">
                <div class="nav-icon"><i class="fa-solid fa-cart-shopping"></i></div>
                <div class="nav-text">Order</div>
                <div class="nav-angle"><i class="fa-solid fa-chevron-right"></i></div>
            </a>
            <form id="order" action="orderServlet" method="post">
            </form>
        </li>
        <li class="nav-item" id="nav-item">
            <a class="nav-link <%= activePage.equals("product") ? "active" : ""%>" onclick="event.preventDefault(); document.getElementById('product').submit();">
                <div class="nav-icon"><i class="fa-solid fa-box"></i></div>
                <div class="nav-text">Product</div>
                <div class="nav-angle"><i class="fa-solid fa-chevron-right"></i></div>
            </a>
            <form id="product" action="productServlet" method="post">
            </form>
        </li>
        <li class="nav-item">
            <a class="nav-link <%= activePage.equals("category") ? "active" : ""%>" onclick="event.preventDefault(); document.getElementById('category').submit();">
                <div class="nav-icon"><i class="fa-solid fa-tag"></i></div>
                <div class="nav-text">Category</div>
                <div class="nav-angle"><i class="fa-solid fa-chevron-right"></i></div>
            </a>
            <form id="category" action="categoryServlet" method="post">
            </form>
        </li>
        <li class="nav-item">
            <a class="nav-link <%= activePage.equals("promotion") ? "active" : ""%>" onclick="event.preventDefault(); document.getElementById('promotion').submit();">
                <div class="nav-icon"><i class="fa-solid fa-dollar"></i></div>
                <div class="nav-text">Promotion</div>
                <div class="nav-angle"><i class="fa-solid fa-chevron-right"></i></div>
            </a>
            <form id="promotion" action="promotionServlet" method="post">
            </form>
        </li>
        <% if (session.getAttribute("adminmode") != null && session.getAttribute("adminmode").equals("manager")) {%>
        <li class="nav-item">
            <a class="nav-link <%= activePage.equals("staff") ? "active" : ""%>" onclick="event.preventDefault(); document.getElementById('staff').submit();">
                <div class="nav-icon"><i class="fa-solid fa-users"></i></div>
                <div class="nav-text">Staff</div>
                <div class="nav-angle"><i class="fa-solid fa-chevron-right"></i></div>
            </a>
            <form id="staff" action="staffServlet" method="post">
            </form>
        </li>
        <li class="nav-item">
            <a class="nav-link <%= activePage.equals("customer") ? "active" : ""%>" onclick="event.preventDefault(); document.getElementById('customer').submit();">
                <div class="nav-icon"><i class="fa-solid fa-chart-column"></i></div>
                <div class="nav-text">Customer</div>
                <div class="nav-angle"><i class="fa-solid fa-chevron-right"></i></div>
            </a>
            <form id="customer" action="customerServlet" method="post">
            </form>
        </li>
        <li class="nav-item">
            <a class="nav-link <%= activePage.equals("auditLog") ? "active" : ""%>" onclick="event.preventDefault(); document.getElementById('auditlog').submit();">
                <div class="nav-icon"><i class="fa-solid fa-clock-rotate-left"></i></div>
                <div class="nav-text">Audit Log</div>
                <div class="nav-angle"><i class="fa-solid fa-chevron-right"></i></div>
            </a>
            <form id="auditlog" action="auditLogServlet" method="post">
            </form>
        </li>
        <li class="nav-item">
            <a class="nav-link <%= activePage.equals("report") ? "active" : ""%>" onclick="event.preventDefault(); document.getElementById('report').submit();">
                <div class="nav-icon"><i class="fa-solid fa-file"></i></div>
                <div class="nav-text">Reports</div>
                <div class="nav-angle"><i class="fa-solid fa-chevron-right"></i></div>
            </a>
            <form id="report" action="reportServlet" method="post">
            </form>
        </li>
        <%}%>

        <div class="fixed-bottom py-3" style="width: 250px;">
            <% if (session.getAttribute("adminmode") != null && !session.getAttribute("adminmode").equals("manager")) {%>
            <li class="nav-item">
                <a class="nav-link <%= activePage.equals("setting") ? "active" : ""%>" href="settings.jsp">
                    <div class="nav-icon"><i class="fa-solid fa-gear"></i></div>
                    <div class="nav-text">Settings</div>
                </a>
            </li>
            <%}%>
            <li class="nav-item">
                <a class="nav-link" onclick="event.preventDefault(); document.getElementById('logoutServlet').submit();">
                    <div class="nav-icon"><i class="fa-solid fa-arrow-right-from-bracket"></i></div>
                    <div class="nav-text">Log Out</div>

                </a>
                <form id="logoutServlet" action="adminLogoutServlet" method="post">
                </form>
            </li>
        </div>
    </ul>