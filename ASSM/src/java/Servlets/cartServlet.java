/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Cart;
import Entities.Category;
import Entities.Customer;
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

public class cartServlet extends HttpServlet {

    @PersistenceContext
    EntityManager em;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        if (session.getAttribute("user") != null) {
            Query allProduct = em.createNamedQuery("Product.findAll");
            List<Product> products = allProduct.getResultList();
            session.setAttribute("products", products);

            Customer customer = (Customer) session.getAttribute("user");
            Query query = em.createNamedQuery("Cartlist.findByCartid");
            query.setParameter("cartid", customer.getCart());
            List<Cart> cartlist = query.getResultList();
            session.setAttribute("cartlist", cartlist);
            
            response.sendRedirect("cart.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }

}
