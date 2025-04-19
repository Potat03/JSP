<%-- Document : login Created on : Apr 6, 2023, 12:42:43 PM Author : vkloo --%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="Entities.Auditlog"%>
<%
    if(session.getAttribute("admin") == null || (session.getAttribute("adminmode") != "staff" && session.getAttribute("adminmode") != "manager")){
        response.sendRedirect("login.jsp");
    }
    session.setAttribute("activePage", "auditLog");

    List<Auditlog> auditlogs = (List<Auditlog>) session.getAttribute("auditlogs");
    SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
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
                    <div style="padding: 40px 20px 20px 20px;">
                        <div class="h3" style="padding-left: 10px;">Audit Log</div>
                    </div>
                    <div class="py-2 px-3 bg-light" style="border-radius: 10px;">
                        <div class="row justify-content-evenly border-bottom mb-2 p-1">
                            <div class="col-2 text-center">Staff ID</div>
                            <div class="col-6 text-center">Description</div>
                            <div class="col-4 text-center">Created Date</div>
                        </div>
                        <% for (int i = 0; i < auditlogs.size(); i++) {%>
                        <div class="row justify-content-evenly mb-2 align-items-center">
                            <div class="col-2 text-center"><%=auditlogs.get(i).getStaffid().getStaffid()%></div>
                            <div class="col-6 text-center"><%=auditlogs.get(i).getDescription()%></div>
                            <div class="col-4 text-center"><%=df.format(auditlogs.get(i).getCreateddate())%></div>
                        </div>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../part/script.html" %>
    </body>
</html>