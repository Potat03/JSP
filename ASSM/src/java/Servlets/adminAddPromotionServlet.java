/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Auditlog;
import Entities.Category;
import Entities.Product;
import Entities.Promotion;
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
public class adminAddPromotionServlet extends HttpServlet {

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
        int value = Integer.parseInt(request.getParameter("value"));
        String description = request.getParameter("description");
        Date createddate = new Date(System.currentTimeMillis());
        Date modifieddate = new Date(System.currentTimeMillis());
        Promotion promo = new Promotion(value, description, "inactive", createddate, modifieddate);
        try {
            utx.begin();
            em.persist(promo);
            utx.commit();

            if (session.getAttribute("adminmode").equals("staff")) {
                Staff staff = (Staff) session.getAttribute("admin");
                Auditlog newAudit = new Auditlog("Added new promotion", createddate, staff);
                utx.begin();
                em.persist(newAudit);
                utx.commit();
            }

        } catch (Exception ex) {
            out.print(ex.getMessage());
        }

        RequestDispatcher r = request.getRequestDispatcher("/admin/promotionServlet");
        r.forward(request, response);
    }

}
