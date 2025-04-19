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
public class editCustomerServlet extends HttpServlet {

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
            customer.setFirstname(request.getParameter("fname"));
            customer.setLastname(request.getParameter("lname"));
            customer.setPhonenumber(request.getParameter("phonenum"));
            customer.setAddress(request.getParameter("address"));
            customer.setModifieddate(new Date(System.currentTimeMillis()));
            utx.begin();
            em.merge(customer);
            //merge to edit
            //remove to delete
            utx.commit();
            session.setAttribute("user", customer);
            session.setAttribute("editCustSuccess", "true");
            response.sendRedirect("profile.jsp");
        } catch (Exception ex) {
            out.println(ex.getMessage());
        }

    }

}
