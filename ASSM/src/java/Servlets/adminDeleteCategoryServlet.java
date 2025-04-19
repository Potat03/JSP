/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Auditlog;
import Entities.Category;
import Entities.Categorylist;
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
public class adminDeleteCategoryServlet extends HttpServlet {

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
        String id = request.getParameter("id");
        Date modifieddate = new Date(System.currentTimeMillis());
        try {
            Query qr = em.createNamedQuery("Category.findByCategoryid");
            qr.setParameter("categoryid", Integer.parseInt(id));
            List<Category> categories = qr.getResultList();
            Category deleteCategory = categories.get(0);
            utx.begin();
            em.detach(deleteCategory);
            if (!em.contains(deleteCategory)) {
                deleteCategory = em.merge(deleteCategory);
            }
            em.remove(deleteCategory);
            utx.commit();
            new Categorylist().deleteListByCat(deleteCategory.getCategoryid());
            
        } catch (Exception ex) {
            out.print(ex.getMessage());
        }

        RequestDispatcher r = request.getRequestDispatcher("/admin/categoryServlet");
        r.forward(request, response);
    }

}
