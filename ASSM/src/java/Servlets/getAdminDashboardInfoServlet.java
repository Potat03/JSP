/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Category;
import Entities.Categorylist;
import Entities.Customer;
import Entities.Orders;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
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
public class getAdminDashboardInfoServlet extends HttpServlet {

    @PersistenceContext
    EntityManager em;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        //get count of all packing order, shipping order, delivered order, refund order
        try {
            Orders order = new Orders();
            List<Orders> packing = order.getByStatus("Packing");
            session.setAttribute("packingCount", packing.size());

            List<Orders> shipping = order.getByStatus("Shipping");
            session.setAttribute("shippingCount", shipping.size());

            List<Orders> delivered = order.getByStatus("Delivered");
            session.setAttribute("deliveredCount", delivered.size());

            List<Orders> refunded = order.getByStatus("Refunded");
            session.setAttribute("refundedCount", refunded.size());

            //top 5 category of product sold
            Query query = em.createNamedQuery("Category.findAll");
            List<Category> categories = query.getResultList();

            for (Category category : categories) {
                Query query1 = em.createNamedQuery("Categorylist.findByCategoryid");
                query1.setParameter("categoryid", category);
                List<Category> categoryArr = query1.getResultList();
                session.setAttribute(category.getCategoryname().replace(" ", "").trim() + "Size", categoryArr.size());
            }

            //users joined today
            Query query2 = em.createNamedQuery("Customer.findByCreateddate");
            query2.setParameter("createddate", new Date(System.currentTimeMillis()));
            List<Customer> customers = query2.getResultList();
            session.setAttribute("customerCount", customers.size());

           
            //revenue
            
             response.sendRedirect("dashboard.jsp");
        } catch (Exception ex) {
            out.println(ex);
        }
    }

}
