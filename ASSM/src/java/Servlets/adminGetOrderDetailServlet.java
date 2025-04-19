/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Customer;
import Entities.Orderlist;
import Entities.Orders;
import Entities.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.Order;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author USER
 */
public class adminGetOrderDetailServlet extends HttpServlet {

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
        int id = Integer.parseInt(request.getParameter("id"));
        Query qr = em.createNamedQuery("Orders.findByOrderid");
        qr.setParameter("orderid", id);
        List<Order> order = qr.getResultList();
        Query allOrderlist = em.createNamedQuery("Orderlist.findByOrderid");
        allOrderlist.setParameter("orderid", new Orders(id));
        List<Orderlist> orderlist = allOrderlist.getResultList();
        List<Product> productlist = new ArrayList();
        for (Orderlist list : orderlist) {
            Query allProductlist = em.createNamedQuery("Product.findByProductcode");
            allProductlist.setParameter("productcode", list.getProductcode().getProductcode());
            List<Product> products = allProductlist.getResultList();
            productlist.add(products.get(0));
        }

        session.setAttribute("orderlist", orderlist);
        session.setAttribute("Order", order.get(0));
        session.setAttribute("productlist", productlist);
        response.sendRedirect("orderDetails.jsp?id=" + request.getParameter("id"));
    }

}
