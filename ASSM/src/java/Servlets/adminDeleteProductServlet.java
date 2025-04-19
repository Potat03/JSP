/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Auditlog;
import Entities.Category;
import Entities.Categorylist;
import Entities.Product;
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
public class adminDeleteProductServlet extends HttpServlet {

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
        int id = Integer.parseInt(request.getParameter("id"));
        Date modifieddate = new Date(System.currentTimeMillis());

        try {
            Query qr = em.createNamedQuery("Product.findByProductcode");
            qr.setParameter("productcode", id);
            List<Product> products = qr.getResultList();
            Product deleteProduct = products.get(0);
            utx.begin();
            em.detach(deleteProduct);
            if (!em.contains(deleteProduct)) {
                deleteProduct = em.merge(deleteProduct);
            }
            em.remove(deleteProduct);
            utx.commit();
            List<Integer> categorylist = deleteProduct.getProdCategories();
            if (categorylist.size() > 0) {
                for (int category : categorylist) {
                    qr = em.createNamedQuery("Categorylist.findByCategoryid");
                    qr.setParameter("categoryid", category);
                    List<Categorylist> list = qr.getResultList();
                    Categorylist rmCat = list.get(0);

                    utx.begin();
                    em.detach(rmCat);
                    if (!em.contains(rmCat)) {
                        rmCat = em.merge(rmCat);
                    }
                    em.remove(rmCat);
                    utx.commit();
                }
            }
        } catch (Exception ex) {
            out.print(ex.getMessage());
        }

        RequestDispatcher r = request.getRequestDispatcher("/admin/productServlet");
        r.forward(request, response);
    }

}
