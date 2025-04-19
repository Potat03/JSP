/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Auditlog;
import Entities.Category;
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
public class adminEditCategoryServlet extends HttpServlet {

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
        String ogname = request.getParameter("ogname");
        String name = request.getParameter("name");
        Date modifieddate = new Date(System.currentTimeMillis());

        Query qr = em.createNamedQuery("Category.findByCategoryname");
        qr.setParameter("categoryname", ogname);
        List<Category> categories = qr.getResultList();
        Category editedCategory = categories.get(0);
        editedCategory.setCategoryname(name);
        editedCategory.setModifieddate(modifieddate);
        try {
            utx.begin();
            em.merge(editedCategory);
            utx.commit();

            if (session.getAttribute("adminmode").equals("staff")) {
                Staff staff = (Staff) session.getAttribute("admin");
                Auditlog newAudit = new Auditlog("Edited Category, Name:" + editedCategory.getCategoryname(), modifieddate, staff);
                utx.begin();
                em.persist(newAudit);
                utx.commit();
            }
        } catch (Exception ex) {
            out.print(ex.getMessage());
        }

        RequestDispatcher r = request.getRequestDispatcher("/admin/categoryServlet");
        r.forward(request, response);

    }

}
