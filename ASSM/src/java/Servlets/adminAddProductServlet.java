/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Auditlog;
import Entities.Category;
import Entities.Categorylist;
import Entities.Product;
import Entities.Staff;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
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
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

/**
 *
 * @author USER
 */
@MultipartConfig
public class adminAddProductServlet extends HttpServlet {

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

        String name = request.getParameter("name");
        String image = request.getPart("image").getSubmittedFileName();
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String description = request.getParameter("description");
        String[] categories = request.getParameterValues("category");
        Date createddate = new Date(System.currentTimeMillis());
        Date modifieddate = new Date(System.currentTimeMillis());

        Product newProd = new Product(name, description, price, stock, image, createddate, modifieddate, null);
        
        try {
            Part imgPart = request.getPart("image");
            String imageName = imgPart.getSubmittedFileName();
            InputStream imgContent = imgPart.getInputStream();

            String webDirectory = getServletContext().getRealPath("/");
            File imgFile = new File(webDirectory + "/src/img/product/", imageName);

            FileOutputStream outputStream = new FileOutputStream(imgFile);
            byte[] buffer = new byte[2048];
            int bytesRead;
            while ((bytesRead = imgContent.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }

            outputStream.close();
            imgContent.close();

            utx.begin();
            em.persist(newProd);
            utx.commit();

            if (categories.length > 0) {
                for (String categoryid : categories) {
                    Query query = em.createNamedQuery("Category.findByCategoryid");
                    query.setParameter("categoryid", Integer.parseInt(categoryid));
                    List<Category> category = query.getResultList();
                    Categorylist categorylist = new Categorylist(category.get(0), newProd);
                    try {
                        utx.begin();
                        em.persist(categorylist);
                        utx.commit();
                    } catch (Exception ex) {
                        out.print(ex.getMessage());
                    }
                }
            }
            if (session.getAttribute("adminmode").equals("staff")) {
                Staff staff = (Staff) session.getAttribute("admin");
                Auditlog newAudit = new Auditlog("Added new product", createddate, staff);
                utx.begin();
                em.persist(newAudit);
                utx.commit();
            }
        } catch (Exception ex) {
            out.println(ex.getMessage());
        }

        RequestDispatcher r = request.getRequestDispatcher("/admin/productServlet");
        r.forward(request, response);
    }

}
