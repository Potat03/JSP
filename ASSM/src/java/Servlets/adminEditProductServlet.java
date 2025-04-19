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
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.transaction.UserTransaction;

/**
 *
 * @author USER
 */
@MultipartConfig
public class adminEditProductServlet extends HttpServlet {

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
        String name = request.getParameter("name");
        Part imgPart = request.getPart("image");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String description = request.getParameter("description");
        String[] categories = request.getParameterValues("category");
        Date modifieddate = new Date(System.currentTimeMillis());

        Query qr = em.createNamedQuery("Product.findByProductcode");
        qr.setParameter("productcode", id);
        List<Product> products = qr.getResultList();
        Product editedProduct = products.get(0);
        editedProduct.setProductname(name);

        if (imgPart != null) {
            try {
                String imageName = imgPart.getSubmittedFileName();
                if (imageName != null && !imageName.isEmpty()) {
                    editedProduct.setImage(imageName);
                }
                InputStream imgContent = imgPart.getInputStream();

                String webDirectory = getServletContext().getRealPath("/");
                File imgFile = new File(webDirectory + "/src/img/product/", imageName);

                FileOutputStream outputStream = new FileOutputStream(imgFile);
                byte[] buffer = new byte[2048];
                int bytesRead;
                while ((bytesRead = imgContent.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            } catch (Exception ex) {
                //out.print(ex.getMessage());
            }
        }

        try {
            editedProduct.setPrice(price);
            editedProduct.setStock(stock);
            editedProduct.setDescription(description);
            editedProduct.setModifieddate(modifieddate);

            utx.begin();
            em.merge(editedProduct);
            utx.commit();
            if (categories.length > 0) {
                new Categorylist().deleteListByProd(editedProduct.getProductcode());
                List<Integer> catlist = editedProduct.getProdCategories();
                if (catlist.size() > 0) {
                    for (int category : catlist) {
                        qr = em.createNamedQuery("Categorylist.findByCategoryid");
                        qr.setParameter("categoryid", new Category(category));
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
                for (String categoryid : categories) {
                    Query query = em.createNamedQuery("Category.findByCategoryid");
                    query.setParameter("categoryid", Integer.parseInt(categoryid));
                    List<Category> category = query.getResultList();
                    Categorylist categorylist = new Categorylist(category.get(0),editedProduct);
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
                Auditlog newAudit = new Auditlog("Edited Product, Name:" + editedProduct.getProductname(), modifieddate, staff);
                utx.begin();
                em.persist(newAudit);
                utx.commit();
            }
        } catch (Exception ex) {
            out.print(ex.getMessage());
        }

        RequestDispatcher r = request.getRequestDispatcher("/admin/productServlet");
        r.forward(request, response);
    }

}
