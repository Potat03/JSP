/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Auditlog;
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
public class adminEditPromotionServlet extends HttpServlet {

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
        int value = Integer.parseInt(request.getParameter("value"));
        String description = request.getParameter("description");
        String[] products = request.getParameterValues("product");
        Date modifieddate = new Date(System.currentTimeMillis());
        try {
            Query rm = em.createNamedQuery("Product.findAll");
            List<Product> rmIdList = rm.getResultList();
            for (Product prod : rmIdList) {
                prod.setPromotionid(null);
                utx.begin();
                em.merge(prod);
                utx.commit();
            }
            Query qr = em.createNamedQuery("Promotion.findAll");
            List<Promotion> promolist = qr.getResultList();
            Promotion editedPromo = new Promotion();
            for (Promotion promo : promolist) {
                if (promo.getPromotionid() == id) {
                    promo.setValue(value);
                    promo.setDescription(description);
                    promo.setModifieddate(modifieddate);
                    promo.setStatus("active");
                    editedPromo = promo;
                } else {
                    promo.setStatus("inactive");
                }
                utx.begin();
                em.merge(promo);
                utx.commit();
            }

            if (products != null) {
                new Product().removePromoid();
                for (String prod : products) {
                    qr = em.createNamedQuery("Product.findByProductcode");
                    qr.setParameter("productcode", Integer.parseInt(prod));
                    List<Product> productlist = qr.getResultList();
                    Product product = productlist.get(0);
                    product.setPromotionid(editedPromo);
                    utx.begin();
                    em.merge(product);
                    utx.commit();
                }
            }

            if (session.getAttribute("adminmode").equals("staff")) {
                Staff staff = (Staff) session.getAttribute("admin");
                Auditlog newAudit = new Auditlog("Edited promotion, id : " + editedPromo.getPromotionid(), modifieddate, staff);
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
