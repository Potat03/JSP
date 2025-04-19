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
public class adminDeleteStaffServlet extends HttpServlet {

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
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Query qr = em.createNamedQuery("Staff.findByStaffid");
            qr.setParameter("staffid", id);
            List<Staff> stafflist = qr.getResultList();
            Staff deleteStaff = stafflist.get(0);
            utx.begin();
            em.detach(deleteStaff);
            if (!em.contains(deleteStaff)) {
                deleteStaff = em.merge(deleteStaff);
            }
            em.remove(deleteStaff);
            utx.commit();
        } catch (Exception ex) {
            System.out.print(ex.getMessage());
        }
        RequestDispatcher r = request.getRequestDispatcher("/admin/staffServlet");
        r.forward(request, response);

    }

}
