/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Cart;
import Entities.Cartlist;
import Entities.Category;
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
public class addToCart extends HttpServlet {

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

        if (session.getAttribute("user") != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = 1;
            if (request.getParameter("quantity") != null) {
                quantity = Integer.parseInt(request.getParameter("quantity"));
            }
            try {
                Query qr1 = em.createNamedQuery("Product.findByProductcode");
                qr1.setParameter("productcode", id);
                List<Product> prodList = qr1.getResultList();
                Product product = prodList.get(0);
                Query qr4 = em.createNamedQuery("Cartlist.findByCartidAndProductcode");
                int stock = product.getStock();
                product.setStock(stock - quantity);
                Customer customer = (Customer) session.getAttribute("user");

                qr4.setParameter("cartid", customer.getCart());
                qr4.setParameter("productcode", product);
                if (qr4.getResultList().isEmpty()) {
                    Cartlist cartlist = new Cartlist(quantity, customer.getCart(), product);
                    utx.begin();
                    em.merge(product);
                    em.persist(cartlist);
                    utx.commit();

                    Query allProduct = em.createNamedQuery("Product.findAll");
                    Query allCategory = em.createNamedQuery("Category.findAll");

                    List<Product> products = allProduct.getResultList();
                    List<Category> categories = allCategory.getResultList();

                    session.setAttribute("products", products);
                    session.setAttribute("categories", categories);

                    session.setAttribute("successAdd", "Product have been added to cart");
                } else {
                    throw new Exception();
                }
            } catch (Exception ex) {
                session.setAttribute("failAdd", "Product is already in cart");
                out.println(ex.getMessage());
            }
            response.sendRedirect("productDetail.jsp?id=" + id);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

}
