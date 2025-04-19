/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
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
public class editCustomerPasswdServlet extends HttpServlet {

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
        try {
            Query query = em.createNamedQuery("Customer.findByCustomerid");
            query.setParameter("customerid", Integer.parseInt(request.getParameter("id")));

            List<Customer> customerlist = query.getResultList();
            Customer customer = customerlist.get(0);
            if (request.getParameter("currentPass").equals(customer.getPassword())) {
                if (request.getParameter("newPass").equals(request.getParameter("confirmPass"))) {
                    if (!request.getParameter("newPass").equals(customer.getPassword())) {
                        customer.setPassword(request.getParameter("newPass"));
                        customer.setModifieddate(new Date(System.currentTimeMillis()));
                        utx.begin();
                        em.merge(customer);
                        //merge to edit
                        //remove to delete
                        utx.commit();
                        session.setAttribute("user", customer);
                        session.setAttribute("editPasswdSuccess", "true");
                    } else {
                        session.setAttribute("passErr", "The new password is same as the current password. Please try another");
                    }
                } else {
                    session.setAttribute("passErr", "The confirm password value is not same as the new password.");
                }
            } else {
                session.setAttribute("passErr", "Wrong Password Entered.");
            }

            response.sendRedirect("profileChangePass.jsp");

        } catch (Exception ex) {
            out.println(ex.getMessage());
        }

    }
}
