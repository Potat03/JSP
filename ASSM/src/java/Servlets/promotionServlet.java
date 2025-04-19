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
public class promotionServlet extends HttpServlet {

    @PersistenceContext
    EntityManager em;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Query allPromotion = em.createNamedQuery("Promotion.findAll");

        List<Product> promotions = allPromotion.getResultList();

        session.setAttribute("promotions", promotions);

        response.sendRedirect("promotion.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Query allPromotion = em.createNamedQuery("Promotion.findAll");
        Query allProduct = em.createNamedQuery("Product.findAll");
        
        List<Product> promotions = allPromotion.getResultList();
        List<Product> products = allProduct.getResultList();
        
        session.setAttribute("promotions", promotions);
        session.setAttribute("products", products);
        
        response.sendRedirect("promotion.jsp");
    }

}
