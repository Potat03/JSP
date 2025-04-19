/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Cart;
import Entities.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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

public class registerCustomerServlet extends HttpServlet {

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
            boolean verify = true;
            String uname = request.getParameter("uname");
            String fname = request.getParameter("fname");
            String lname = new String();
            if(request.getParameter("lname") != null){
               lname = request.getParameter("lname");
            }
            String email = request.getParameter("email");
            String passwd = request.getParameter("passwd");
            String rpasswd = request.getParameter("rpasswd");
            Date createddate = new Date(System.currentTimeMillis());
            Date modifieddate = new Date(System.currentTimeMillis());
            if (passwd.length() < 5) {
                session.setAttribute("regErrPass", "Password too short");
                verify = false;
            }

            Query checkEmail = em.createNamedQuery("Customer.findByEmail");
            checkEmail.setParameter("email", email);
            List<Customer> verifyEmail = checkEmail.getResultList();
            if (uname.matches("[^a-zA-Z]*")) {
                session.setAttribute("regErrUname", "Username contains numbers or symbols");
                verify = false;
            }

            if (fname.matches("[^a-zA-Z]*")) {
                session.setAttribute("regErrFname", "First name contains numbers or symbols");
                verify = false;
            }

            if (lname.matches("[^a-zA-Z]*")) {
                session.setAttribute("regErrLname", "Last name contains numbers or symbols");
                verify = false;
            }

            if (!verifyEmail.isEmpty()) {
                session.setAttribute("regErrEmail", "Email already used");
                verify = false;
            }

            if (!passwd.equals(rpasswd)) {
                session.setAttribute("regErrRpass", "Password and retry password doesnt match");
                verify = false;
            }

            if (verify) {
                Customer customer = new Customer(uname, fname, lname, email, passwd, null, null, createddate, modifieddate);
                utx.begin();
                em.persist(customer);
                utx.commit();

                Query qr = em.createNamedQuery("Customer.findByEmail");
                qr.setParameter("email", email);
                List<Customer> customers = qr.getResultList();
                Customer forCart = customers.get(0);
                Cart cart = new Cart(forCart.getCustomerid(), modifieddate);

                utx.begin();
                em.persist(cart);
                utx.commit();
                
                session.setAttribute("registerSuccess", "true");

                response.sendRedirect("login.jsp");
            }

            response.sendRedirect("register.jsp");
        } catch (Exception ex) {
            out.print(ex.getMessage());
        }

    }

}
