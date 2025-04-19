<%-- Document : login Created on : Apr 6, 2023, 12:42:43 PM Author : vkloo --%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Entities.Promotion"%>
<%@page import="java.util.List"%>
<%
    if (session.getAttribute("admin") == null || (session.getAttribute("adminmode") != "staff" && session.getAttribute("adminmode") != "manager")) {
        response.sendRedirect("login.jsp");
    }
    session.setAttribute("activePage", "promotion");

    List<Promotion> promotions = (List<Promotion>) session.getAttribute("promotions");
    SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");

%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Petto Shop - Admin</title>
        <%@include file="../part/link.html" %>
        <link rel="stylesheet" href="../src/css/admin.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
        <style>
            .admin-nav-style{
                max-width: 250px;
                background-color: white;
                height: 100%;
                position: fixed;
            }
        </style>
    </head>

    <body>
        <div>
            <div class="d-flex">
                <div class="flex-fill admin-nav-style">
                    <%@include file="./part/header.jsp" %>
                </div>
                <div class="flex-fill px-4" style="margin-left: 20%;">
                    <div class="d-flex" style="padding: 40px 20px 20px 20px;">
                        <div class="h3" style="padding-left: 10px;">Promotion</div>
                        <button class="ms-auto btn" style="background-color: #FFEFB7;" onclick="location.href = 'addPromotion.jsp'">Add Promotion</button>  
                    </div>
                    <div class="py-2 px-3 bg-light" style="border-radius: 10px;">
                        <div class="row justify-content-evenly border-bottom mb-2 p-1">
                            <div class="col-1 text-center">No.</div>
                            <div class="col-2 text-center">Promotion ID</div>
                            <div class="col-3 text-center">Promotion Date</div>
                            <div class="col-2 text-center">Description</div>
                            <div class="col-2 text-center">Status</div>
                            <div class="col-2 text-end" style="padding-right: 7%;">Action</div>
                        </div>
                        <% for (int i = 0; i < promotions.size(); i++) {%>
                        <div class="row justify-content-evenly mb-2 align-items-center">
                            <div class="col-1 text-center"><%=i + 1%></div>
                            <div class="col-2 text-center"><%=promotions.get(i).getPromotionid()%></div>
                            <div class="col-3 text-center"><%=df.format(promotions.get(i).getCreateddate())%></div>
                            <div class="col-2 text-center"><%=promotions.get(i).getDescription()%></div>
                            <div class="col-2 text-center"><%=promotions.get(i).getStatus()%></div>
                            <div class="col-2 text-center d-flex justify-content-end" style="gap: 15px;">
                                <%if (promotions.get(i).getStatus().equals("active")) {%>
                                <button type="button" class="btn" style="background-color: #FFEFB7;" onclick="event.preventDefault(); document.getElementById('deactivePromoServlet<%=i%>').submit();">Deactive</button>
                                <form id="deactivePromoServlet<%=i%>" action="adminDeactivePromotionServlet" method="POST">
                                    <input type="hidden" id="id" name="id" value="<%=promotions.get(i).getPromotionid()%>"/>
                                </form>
                                <%}%>
                                <button class="btn" style="background-color: #FFEFB7;" onclick="location.href = 'editPromotion.jsp?id=<%=promotions.get(i).getPromotionid()%>'">Edit</button>
                                <% if (session.getAttribute("adminmode").equals("manager")) {%>                                
                                <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#modal-delPromoServlet<%=i%>" style="background-color: #FFEFB7;">Delete</button>
                                <div class="modal fade" id ="modal-delPromoServlet<%=i%>" tabindex="-1" role="dialog" aria-labelledby="modal-delProdServlet<%=i%>" aria-hidden="true">
                                    <div class="modal-dialog modal-sm">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Confirm Delete</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p class="text-start py-1">Product Name: <%=promotions.get(i).getPromotionid()%></p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button"class="btn" style="background-color: #FFEFB7;" onclick="event.preventDefault(); document.getElementById('delPromoServlet<%=i%>').submit();">Delete</button>
                                                <form id="delPromoServlet<%=i%>" action="adminDeletePromotionServlet" method="POST">
                                                    <input type="hidden" id="id" name="id" value="<%=promotions.get(i).getPromotionid()%>"/>
                                                </form>
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                        </div>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../part/script.html" %>
    </body>
</html>