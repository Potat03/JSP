/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Category;
import Entities.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author USER
 */
@WebServlet(name = "indexServlet", urlPatterns = {"/index"})
public class indexServlet extends HttpServlet {

    @PersistenceContext
    EntityManager em;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Query allProduct = em.createNamedQuery("Product.findAll");
        Query allCategory = em.createNamedQuery("Category.findAll");

        List<Product> products = allProduct.getResultList();
        List<Category> categories = allCategory.getResultList();

        session.setAttribute("products", products);
        session.setAttribute("categories", categories);

        session.setAttribute("compname", "Petto");
        session.setAttribute("compaddress", "No.15 Jalan Cermai Taman Perdamai, 56000 Selangor, Wilayah Persekutuan Kuala Lumpur");
        session.setAttribute("compphone", "03-33852415");
        session.setAttribute("compemail", "pettoCS@gmail.com");
        session.setAttribute("compcopyright", "Designed by Banana Leader");

        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Query allProduct = em.createNamedQuery("Product.findAll");
        Query allCategory = em.createNamedQuery("Category.findAll");

        List<Product> products = allProduct.getResultList();
        List<Category> categories = allCategory.getResultList();

        session.setAttribute("products", products);
        session.setAttribute("categories", categories);

        session.setAttribute("compcname", "Petto");
        session.setAttribute("compaddress", "No.15 Jalan Cermai Taman Perdamai, 56000 Selangor, Wilayah Persekutuan Kuala Lumpur");
        session.setAttribute("compphone", "03-33852415");
        session.setAttribute("compemail", "pettoCS@gmail.com");
        session.setAttribute("compcopyright", "Designed by Banana Leader");

        response.sendRedirect("index.jsp");
    }

}
