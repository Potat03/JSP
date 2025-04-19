/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Staff;
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
public class adminEditStaffServlet extends HttpServlet {
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
        boolean verify = true;
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String passwd = request.getParameter("password");
        Date modifieddate = new Date(System.currentTimeMillis());

        if (name.matches("[^a-zA-Z]*")) {
            session.setAttribute("regErrName", "Last name contains numbers or symbols");
            verify = false;
        }

        if (passwd.length() < 5) {
            session.setAttribute("regErrPass", "Password too short");
            verify = false;
        }

        if (verify) {
            try {
                Query qr = em.createNamedQuery("Staff.findByStaffid");
                qr.setParameter("staffid", id);
                List<Staff> stafflist = qr.getResultList();
                Staff editedStaff = stafflist.get(0);
                editedStaff.setStaffname(name);
                editedStaff.setPassword(passwd);
                editedStaff.setModifieddate(modifieddate);
                utx.begin();
                em.merge(editedStaff);
                utx.commit();
            } catch (Exception ex) {
                System.out.print(ex.getMessage());
            }
            RequestDispatcher r = request.getRequestDispatcher("/admin/staffServlet");
            r.forward(request, response);

        } else {
            response.sendRedirect("/editStaff.jsp");
        }

    }

}
