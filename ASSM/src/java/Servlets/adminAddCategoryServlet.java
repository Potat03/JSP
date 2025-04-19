/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Auditlog;
import Entities.Category;
import Entities.Product;
import Entities.Staff;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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
public class adminAddCategoryServlet extends HttpServlet {

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

        String name = request.getParameter("name");
        Date createddate = new Date(System.currentTimeMillis());
        Date modifieddate = new Date(System.currentTimeMillis());
        Category newCategory = new Category(name, createddate, modifieddate);
        try {
            utx.begin();
            em.persist(newCategory);
            utx.commit();
            if (session.getAttribute("adminmode").equals("staff")) {
                Staff staff = (Staff) session.getAttribute("admin");
                Auditlog newAudit = new Auditlog("Added new category", createddate, staff);
                utx.begin();
                em.persist(newAudit);
                utx.commit();
            }
        } catch (Exception ex) {
            System.out.print(ex.getMessage());
        }

        RequestDispatcher r = request.getRequestDispatcher("/admin/categoryServlet");
        r.forward(request, response);

    }

}
