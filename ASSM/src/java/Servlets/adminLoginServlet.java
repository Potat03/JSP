/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Staff;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author USER
 */
public class adminLoginServlet extends HttpServlet {

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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try {

            if (username.equals("SpecialName") && password.equals("bananaPower")) {
                session.setAttribute("adminlogin", "true");
                session.setAttribute("admin", "manager");
                session.setAttribute("adminmode", "manager");
                session.setAttribute("loginstatus", "success");
                RequestDispatcher r = request.getRequestDispatcher("/admin/getAdminDashboardInfoServlet");
                r.forward(request, response);
            } else {
                Query query = em.createNamedQuery("Staff.findByStaffnameAndPassword");
                query.setParameter("staffname", username);
                query.setParameter("password", password);
                List<Staff> staffs = query.getResultList();
                if (query.getResultList().isEmpty()) {
                    session.setAttribute("adminlogin", "false");
                    session.setAttribute("loginstatus", "failed");
                    response.sendRedirect("login.jsp");
                } else {
                    List<Staff> staff = query.getResultList();
                    
                    session.setAttribute("adminlogin", "true");
                    session.setAttribute("loginstatus", "success");
                    session.setAttribute("admin", staff.get(0));
                    session.setAttribute("adminmode", "staff");

                    RequestDispatcher r = request.getRequestDispatcher("/admin/getAdminDashboardInfoServlet");
                    r.forward(request, response);
                }

            }
        } catch (Exception ex) {
            out.println(ex.getMessage());
        }
    }

}
