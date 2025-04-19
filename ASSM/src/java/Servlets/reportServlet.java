/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Category;
import Entities.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author USER
 */
public class reportServlet extends HttpServlet {

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
        
        response.sendRedirect("productReport.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        Query allProduct = em.createNamedQuery("Product.findAll");
        Query allCategory = em.createNamedQuery("Category.findAll");

        List<Product> products = allProduct.getResultList();
        List<Category> categories = allCategory.getResultList();

        session.setAttribute("products", products);
        session.setAttribute("categories", categories);
        
        response.sendRedirect("productReport.jsp");
    }

}
