/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author USER
 */
@WebServlet(name = "loginServlet", urlPatterns = {"/loginServlet"})
public class loginServlet extends HttpServlet {

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
            
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            Query query = em.createNamedQuery("Customer.findByEmailAndPassword");
            query.setParameter("email",email);
            query.setParameter("password",password);
            if(query.getResultList().isEmpty()){ 
                session.setAttribute("login", "false");
                
                response.sendRedirect("login.jsp");
            }else{
                List<Customer> customer = query.getResultList();
                
                session.setAttribute("login", "true");
                session.setAttribute("user", customer.get(0));
                session.setAttribute("usermode", "customer");
                
                response.sendRedirect("profile.jsp");
            }
            
    }

}
