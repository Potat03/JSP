/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Orders;
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
public class orderServlet extends HttpServlet {

    @PersistenceContext
    EntityManager em;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Query allOrder = em.createNamedQuery("Orders.findAll");

        List<Product> Orders = allOrder.getResultList();

        session.setAttribute("order", Orders);

        response.sendRedirect("order.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Query allOrder = em.createNamedQuery("Orders.findAll");
        Query allProducts = em.createNamedQuery("Product.findAll");

        List<Orders> orders = allOrder.getResultList();
        List<Product> prods = allProducts.getResultList();

        session.setAttribute("orders", orders);
        session.setAttribute("products", prods);

        response.sendRedirect("order.jsp");
    }

}
