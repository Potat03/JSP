/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Cart;
import Entities.Cartlist;
import Entities.Category;
import Entities.Categorylist;
import Entities.Customer;
import Entities.Orderlist;
import Entities.Orders;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;

/**
 *
 * @author USER
 */
public class adminDeleteCustomerServlet extends HttpServlet {

    @PersistenceContext
    EntityManager em;

    @Resource
    UserTransaction utx;

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
        try {
            Query qr = em.createNamedQuery("Customer.findByCustomerid");
            Query qr2 = em.createNamedQuery("Orderlist.findByOrderid");
            Query qr3 = em.createNamedQuery("Cart.findByCustomerid");
            Query qr4 = em.createNamedQuery("Cartlist.findByCartid");
            Query qr1 = em.createNamedQuery("Orders.findByCustomerid");
            qr.setParameter("customerid", id);
            Customer c = (Customer) qr.getSingleResult();
            qr1.setParameter("customerid", c);
            List<Orders> o = qr1.getResultList();
            for (Orders order : o) {
                qr2.setParameter("orderid", order);
                List<Orderlist> ol = qr2.getResultList();
                
                for (Orderlist ol1 : ol) {
                    utx.begin();
                    em.detach(ol1);
                    if (!em.contains(ol1)) {
                        ol1 = em.merge(ol1);
                    }
                    em.remove(ol1);
                    utx.commit();
                }
                
                utx.begin();
                em.detach(order);
                if (!em.contains(order)) {
                    order = em.merge(order);
                }
                em.remove(order);
                utx.commit();
            }
            qr3.setParameter("customerid", id);
            List<Cart> c1 = qr3.getResultList();
            for (Cart c2 : c1) {
                qr4.setParameter("cartid", c2);
                List<Cartlist> cl = qr4.getResultList();
                
                for (Cartlist cl1 : cl) {
                    utx.begin();
                    em.detach(cl1);
                    if (!em.contains(cl1)) {
                        cl1 = em.merge(cl1);
                    }
                    em.remove(cl1);
                    utx.commit();
                }
                
                utx.begin();
                em.detach(c2);
                if (!em.contains(c2)) {
                    c2 = em.merge(c2);
                }
                em.remove(c2);
                utx.commit();
            }
            utx.begin();
            em.detach(c);
            if (!em.contains(c)) {
                c = em.merge(c);
            }
            em.remove(c);
            utx.commit();

            RequestDispatcher r = request.getRequestDispatcher("/admin/customerServlet");
            r.forward(request, response);
        } catch (Exception ex) {
            out.print(ex.getMessage());
        }
    }

}
