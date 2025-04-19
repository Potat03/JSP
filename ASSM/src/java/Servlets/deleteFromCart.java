/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Cart;
import Entities.Cartlist;
import Entities.Customer;
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
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;

/**
 *
 * @author USER
 */
public class deleteFromCart extends HttpServlet {

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

        int cartid = Integer.parseInt(request.getParameter("cartid"));
        int prodid = Integer.parseInt(request.getParameter("prodid"));
        try {
            Query qr = em.createNamedQuery("Cartlist.findByCartidAndProductcode");
            qr.setParameter("cartid", new Cart(cartid));
            qr.setParameter("productcode", new Product(prodid));
            List<Cartlist> cartlistList = qr.getResultList();
            Cartlist cartlist = cartlistList.get(0);

            utx.begin();
            em.detach(cartlist);
            if (!em.contains(cartlist)) {
                cartlist= em.merge(cartlist);
            }
            em.remove(cartlist);
            utx.commit();

            Query qr1 = em.createNamedQuery("Product.findByProductcode");
            qr1.setParameter("productcode",prodid);
            List<Product> prodList = qr1.getResultList();
            Product product = prodList.get(0);
            product.setStock(product.getStock() + cartlist.getQuantity());

            utx.begin();
            em.merge(product);
            utx.commit();

        } catch (Exception ex) {
            out.println(ex.getMessage());
        }

        RequestDispatcher r = request.getRequestDispatcher("/cartServlet");
        r.forward(request, response);
    }

}
