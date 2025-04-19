<%-- Document : login Created on : Apr 6, 2023, 12:42:43 PM Author : vkloo --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="Entities.Category"%>
<%@page import="java.util.List"%>
<%
    if(session.getAttribute("admin") == null || (session.getAttribute("adminmode") != "staff" && session.getAttribute("adminmode") != "manager")){
        response.sendRedirect("login.jsp");
    }

    session.setAttribute("activePage", "category");

    List<Category> categories = (List<Category>) session.getAttribute("categories");
%>
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
                <div class="flex-fill px-4" style="margin-left: 20%; max-width: 50%;">
                    <div class="d-flex" style="padding: 40px 20px 20px 20px;">
                        <div class="h3" style="padding-left: 10px;">Category</div>
                        <button class="ms-auto btn" style="background-color: #FFEFB7;" onclick="location.href = 'addCategory.jsp'">Add Category</button>  
                    </div>
                    <div class="py-2 px-3 bg-light" style="border-radius: 10px;">
                        <div class="row justify-content-evenly border-bottom mb-2 p-1">
                            <div class="col-2 text-center">No.</div>
                            <div class="col-6 text-center">Category Name</div>
                            <div class="col-4 text-center">Action</div>
                        </div>
                        <% for (int i = 0; i < categories.size(); i++) {%>
                        <div class="row justify-content-evenly mb-2 align-items-center">
                            <div class="col-2 text-center"><%=i + 1%></div>
                            <div class="col-6 text-center"><%=categories.get(i).getCategoryname()%></div>
                            <div class="col-4 text-center d-flex justify-content-center" style="gap: 15px;">
                                <button class="btn" style="background-color: #FFEFB7;" onclick="location.href = 'editCategory.jsp?name=<%=categories.get(i).getCategoryname()%>'">Edit</button>
                                <% if (session.getAttribute("adminmode").equals("manager")) {%>
                                <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#modal-delCatServlet<%=i%>" style="background-color: #FFEFB7;">Delete</button>
                                <div class="modal fade" id ="modal-delCatServlet<%=i%>" tabindex="-1" role="dialog" aria-labelledby="modal-delCatServlet<%=i%>" aria-hidden="true">
                                    <div class="modal-dialog modal-sm">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Confirm Delete</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p class="text-start py-1">Category Name: <%=categories.get(i).getCategoryname()%></p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button"class="btn" style="background-color: #FFEFB7;" onclick="event.preventDefault(); document.getElementById('delCatServlet<%=i%>').submit();">Delete</button>
                                                <form id="delCatServlet<%=i%>" action="adminDeleteCategoryServlet" method="POST">
                                                    <input type="hidden" id="id" name="id" value="<%=categories.get(i).getCategoryid()%>"/>
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