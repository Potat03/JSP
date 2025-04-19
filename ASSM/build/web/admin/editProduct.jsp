<%-- Document : login Created on : Apr 6, 2023, 12:42:43 PM Author : vkloo --%>

<%@page import="Entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="Entities.Product"%>
<%

    if(session.getAttribute("admin") == null || (session.getAttribute("adminmode") != "staff" && session.getAttribute("adminmode") != "manager")){
        response.sendRedirect("login.jsp");
    }   
    Product prod = new Product();
    int code = Integer.parseInt(request.getParameter("id"));
    List<Category> categories = (List<Category>) session.getAttribute("categories");
    List<Product> productsObj = (List<Product>) session.getAttribute("products");
    for (int i = 0; i < productsObj.size(); i++) {
        if (productsObj.get(i).getProductcode() == code) {
            prod = productsObj.get(i);
        }
    }
    List<Integer> categoryList = prod.getProdCategories();
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
            .form-control-input{
                background-color: #E6EAE6 !important;
                border-radius: 10px !important;
                padding: 5px 15px;
            }
        </style>
    </head>

    <body>
        <div>
            <div class="d-flex">
                <div class="flex-fill admin-nav-style">
                    <%@include file="./part/header.jsp" %>
                </div>
                <div class="flex-fill px-4" style="margin-left: 20%; max-width: 70%;">
                    <div style="padding: 40px 20px 20px 20px;">
                        <div class="h3" style="padding-left: 10px;">Edit Product</div>
                    </div>
                    <div class="container py-4 px-4 bg-light" style="border-radius: 10px;">
                        <form action="adminEditProductServlet" method="POST" enctype='multipart/form-data'> 
                            <input type="hidden" id="id" name="id" value="<%=prod.getProductcode()%>"/>
                            <div class="row" style="gap: 20px;column-gap: 10%;">
                                <div class="col-5">
                                    <div class="row align-items-center">
                                        <div class="col-4">
                                            Product Name
                                        </div>
                                        <div class="col-8">
                                            <input type="text" class="form-control-input border-0" id="name" name="name" value="<%=prod.getProductname()%>" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-5">
                                    <div class="row align-items-center">
                                        <div class="col-4">
                                            Product Image
                                        </div>
                                        <div class="col-8">
                                            <input type="file" class="form-control" id="image" name="image"/>                                        
                                        </div>
                                    </div>
                                </div>
                                <div class="col-5">
                                    <div class="row align-items-center">
                                        <div class="col-4">
                                            Price
                                        </div>
                                        <div class="col-8">
                                            <input type="text" class="form-control-input border-0" id="price" name="price" value="<%=prod.getPrice()%>" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-5">
                                    <div class="row align-items-center">
                                        <div class="col-4">
                                            Stock
                                        </div>
                                        <div class="col-8">
                                            <input type="text" class="form-control-input border-0" id="stock" name="stock" value="<%=prod.getStock()%>" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-5">
                                    <div class="row">
                                        <div class="col-4">
                                            Description
                                        </div>
                                        <div class="col-8">
                                            <textarea class="form-control-input border-0 w-100" id="description" name="description" style="min-height: 79px" required><%=prod.getDescription()%></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-5">
                                    <div class="row align-items-center">
                                        <div class="col-4">
                                            Categories
                                        </div>
                                        <div class="col-8">
                                            <button type="button" style="background-color: #FFEFB7;" class="btn " data-bs-toggle="modal" data-bs-target="#categories-modal">
                                                Choose
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button class="btn" style="background-color: #FFEFB7;margin-left: 15%;">Save</button>
                                </div>
                            </div>
                            <div class="modal fade" id="categories-modal" tabindex="-1" aria-labelledby="categories-moda" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalLabel">Categories</h1>
                                        </div>
                                        <div class="modal-body">
                                            <%for (int i = 0; i < categories.size(); i++) {
                                                    int cid = (int) categories.get(i).getCategoryid();
                                            %>
                                            <div class="d-flex py-2 px-5" style="gap:10px;">
                                                <input class="form-control-checkbox" type="checkbox" id="category<%=cid%>" name="category" value="<%=cid%>" 
                                                       <%= (categoryList.contains(cid)) ? "checked" : ""%>>
                                                <label class="noselect" for="<%=cid%>"><%=categories.get(i).getCategoryname()%></label>
                                            </div>
                                            <%}%>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Save changes</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../part/script.html" %>
    </body>
</html>