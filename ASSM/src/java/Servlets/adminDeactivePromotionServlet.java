/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Category;
import Entities.Categorylist;
import Entities.Product;
import Entities.Promotion;
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
public class adminDeactivePromotionServlet extends HttpServlet {

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
                    promo.setStatus("inactive");
                }
                utx.begin();
                em.merge(promo);
                utx.commit();
            }

            Query allProduct = em.createNamedQuery("Product.findAll");
            Query allCategory = em.createNamedQuery("Category.findAll");

            List<Product> products = allProduct.getResultList();
            List<Category> categories = allCategory.getResultList();

            session.setAttribute("products", products);
            session.setAttribute("categories", categories);

        } catch (Exception ex) {
            out.print(ex.getMessage());
        }

        RequestDispatcher r = request.getRequestDispatcher("/admin/promotionServlet");
        r.forward(request, response);
    }

}
