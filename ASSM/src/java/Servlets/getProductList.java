/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Category;
import Entities.Product;
import java.io.IOException;
import java.util.List;
import javax.persistence.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author USER
 */
@WebServlet(name = "getProductList", urlPatterns = {"/getProductList"})
public class getProductList extends HttpServlet {

    @PersistenceContext
    EntityManager em;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Query allProduct = em.createNamedQuery("Product.findAll");
        Query allCategory = em.createNamedQuery("Category.findAll");

        List<Product> products = allProduct.getResultList();
        List<Category> categories = allCategory.getResultList();

        session.setAttribute("products", products);
        session.setAttribute("categories", categories);

        response.sendRedirect(request.getHeader("referer"));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String filter = request.getParameter("filter");
        String name = request.getParameter("name");

        Query allProduct = em.createNamedQuery("Product.findAll");
        Query allCategory = em.createNamedQuery("Category.findAll");

        List<Product> products = allProduct.getResultList();
        List<Category> categories = allCategory.getResultList();

        session.setAttribute("products", products);
        session.setAttribute("categories", categories);

        if (filter != null && name == null) {
            response.sendRedirect("productList.jsp?filter=" + filter);
        }else if (filter == null && name == null){
            response.sendRedirect("productList.jsp");
        } 
        else {
            response.sendRedirect("productList.jsp?name=" + name);
        }
    }

}
