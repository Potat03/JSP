/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Cart;
import Entities.Cartlist;
import Entities.Product;
import java.io.IOException;
import java.io.PrintWriter;
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
import javax.transaction.UserTransaction;

/**
 *
 * @author USER
 */
public class modifyCartProductQuantity extends HttpServlet {

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

        PrintWriter out = response.getWriter();
        String type = request.getParameter("type");
        int cartid = Integer.parseInt(request.getParameter("cartid"));
        int prodid = Integer.parseInt(request.getParameter("prodid"));
        try {
            Query query = em.createNamedQuery("Cart.findByCartid");
            query.setParameter("cartid", cartid);
            List<Cart> cart = query.getResultList();
            Query qr = em.createNamedQuery("Cartlist.findByCartidAndProductcode");
            Query qr1 = em.createNamedQuery("Product.findByProductcode");
            qr1.setParameter("productcode", prodid);
            List<Product> prodList = qr1.getResultList();
            Product product = prodList.get(0);
            qr.setParameter("cartid", cart.get(0));
            qr.setParameter("productcode", prodList.get(0));
            List<Cartlist> cartlistList = qr.getResultList();
            Cartlist cartlist = cartlistList.get(0);
            if (type.equals("increase")) {
                cartlist.setQuantity(cartlist.getQuantity() + 1);
                product.setStock(product.getStock() - 1);
            } else if (type.equals("decrease") && cartlist.getQuantity() > 1) {
                cartlist.setQuantity(cartlist.getQuantity() - 1);
                product.setStock(product.getStock() + 1);
            }
            utx.begin();
            em.merge(cartlist);
            em.merge(product);
            utx.commit();
        } catch (Exception ex) {
            out.println(ex.getMessage());
        }

        RequestDispatcher r = request.getRequestDispatcher("/cartServlet");
        r.forward(request, response);
    }
}
