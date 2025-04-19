<%@page import="java.util.List"%>
<%@page import="Entities.Category"%>
<div class="pageHeader">
    <div class="page-upper container">
        <div class="mainpage-logo">
            <img src="./src/img/petto.jpg" class="shopLogo" onclick="window.location.href = 'index.jsp'" draggable="false">
        </div>

        <div class="page-search" style="padding-top: 18px;">
            <form class="form-inline my-2 my-lg-0" id="nav-form-search" action="getProductList" method="post">
                <input id="nav-search" class="form-control mr-sm-2" type="search" name="name" placeholder="Search Here" aria-label="Search">
            </form>
        </div>

        <div class="mainpage-user d-flex">
            <div style="padding-right: 30px; font-size: 20px; cursor:pointer;" onclick="window.location.href = 'profile.jsp'">
                <i class="fa-solid fa-user"></i>
            </div>
            <div style="font-size: 20px; cursor:pointer;" onclick="event.preventDefault(); document.getElementById('customer-cart-form').submit();">
                <i class="fa-solid fa-bag-shopping"></i>
                <form id="customer-cart-form" action="cartServlet" method="POST">
                </form>
            </div>
        </div>
    </div>

    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
            <button class="navbar-toggler" type="button" data-toggle="collapse"
                    data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <div class="navItem-area">

                        <div class="nav-left d-flex">
                            <li class="nav-item">
                                <a class="nav-link" onclick="event.preventDefault(); document.getElementById('filter_none').submit();">PRODUCTS</a>
                                <form id="filter_none" action="getProductList" method="post">
                                </form>
                            </li>
                            <% List<Category> navCat = (List<Category>) session.getAttribute("categories");
                                for (int i = 0; i < 5; i++) {
                            %>
                            <li class="nav-item">
                                <a class="nav-link" onclick="event.preventDefault(); document.getElementById('filter_<%=navCat.get(i).getCategoryname()%>').submit();"><%=navCat.get(i).getCategoryname()%></a>
                                <form id="filter_<%=navCat.get(i).getCategoryname()%>" action="getProductList" method="post">
                                    <input type="hidden" name="filter" value="<%=navCat.get(i).getCategoryid()%>">
                                </form>
                            </li>
                            <%}%>
                        </div>
                        <div class="nav-right d-flex">
                            <li class="nav-item">
                                <a class="nav-link" href="aboutUs.jsp">About Us</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="contact.jsp">Contact</a>
                            </li>
                        </div>
                    </div>
                </ul>
            </div>
        </div>
    </nav>

</div>
<script>
    var search = document.getElementById("nav-search");
    search.addEventListener("keypress", function (event) {
        if (event.key === "Enter") {
            event.preventDefault();
            document.getElementById("nav-form-search").submit();
        }
    });
</script>