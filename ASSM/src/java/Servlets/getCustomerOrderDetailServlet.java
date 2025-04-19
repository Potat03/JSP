/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Customer;
import Entities.Orderlist;
import Entities.Orders;
import java.io.IOException;
import java.io.PrintWriter;
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
public class getCustomerOrderDetailServlet extends HttpServlet {

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
        int id = Integer.parseInt(request.getParameter("orderid"));
        Customer customer = (Customer) session.getAttribute("user");
        Query allOrder = em.createNamedQuery("Orderlist.findByOrderid");
        allOrder.setParameter("orderid", new Orders(id));
        List<Orderlist> orderlist = allOrder.getResultList();
        out.print(orderlist);

        session.setAttribute("orderlist", orderlist);
        if (request.getParameter("refund") != null) {
            session.setAttribute("refund", "true");
        }
        response.sendRedirect("profileOrderDetails.jsp?id="+request.getParameter("orderid"));
    }

}
