/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Entities.Cartlist;
import Entities.Category;
import Entities.Customer;
import Entities.Orderlist;
import Entities.Orders;
import Entities.Payment;
import Entities.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;

public class createOrderServlet extends HttpServlet {

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
            boolean verify = true;
            String mobile = request.getParameter("mobile");
            String address = request.getParameter("address");
            String method = request.getParameter("method");
            String cardnum = request.getParameter("cardnum");
            String edate = request.getParameter("edate");
            String nameoncard = request.getParameter("nameoncard");
            String cvv = request.getParameter("cvv");
            double subtotal = Double.parseDouble(request.getParameter("subtotal"));
            double shipping = Double.parseDouble(request.getParameter("shipping"));
            double discount = Double.parseDouble(request.getParameter("discount"));
            double total = Double.parseDouble(request.getParameter("totalAmt"));
            Date createddate = new Date(System.currentTimeMillis());
            Date modifieddate = new Date(System.currentTimeMillis());
            String status = "Packing";
            Customer customer = (Customer) session.getAttribute("user");
            try {
                if (method.equals("Card")) {
                    if (cardnum.length() != 16 || cardnum.contains("[^0-9]+")) {
                        verify = false;
                        session.setAttribute("OrderErrCardnum", "Invalid Format");
                    }

                    if (edate == null || edate.length() != 5 || edate.contains("[a-zA-Z]+")) {
                        verify = false;
                        session.setAttribute("OrderErrEdate", "Invalid Format");
                    }

                    if (nameoncard == null || nameoncard.contains("[^a-zA-Z]*")) {
                        verify = false;
                        session.setAttribute("OrderErrNameCard", "Invalid Format");
                    }

                    if (cvv == null || cvv.contains("[^0-9]+") || cvv.length() != 3) {
                        verify = false;
                        session.setAttribute("OrderErrCVV", "Invalid Format");
                    }

                }

                if (verify) {
                    boolean checkTransacid = false;
                    String DIGITS = "0123456789";
                    int LENGTH = 10;
                    String transactionid = "";
                    
                    while (!checkTransacid) {
                        Query check = em.createNamedQuery("Payment.findByTransactionid");
                        StringBuilder sb = new StringBuilder();
                        Random random = new Random();
                        for (int i = 0; i < LENGTH; i++) {
                            int index = random.nextInt(DIGITS.length());
                            sb.append(DIGITS.charAt(index));
                        }
                        check.setParameter("transactionid", sb.toString());
                        List<Payment> paymentlist = check.getResultList();
                        if(paymentlist.isEmpty()){
                            checkTransacid = true;
                            transactionid = sb.toString();
                        }
                    }

                    Payment payment = new Payment(transactionid, method, total, createddate);
                    utx.begin();
                    em.persist(payment);
                    utx.commit();
                    Orders order = new Orders(payment.getPaymentid(), discount, subtotal, total, mobile, address, status, createddate, customer);

                    utx.begin();
                    em.persist(order);
                    utx.commit();

                    Query query = em.createNamedQuery("Cartlist.findByCartid");
                    query.setParameter("cartid", customer.getCart());
                    List<Cartlist> cartlist = query.getResultList();
                    for (Cartlist item : cartlist) {
                        Orderlist orderlist = new Orderlist(item.getQuantity(), order, item.getProductcode());
                        utx.begin();
                        em.persist(orderlist);
                        em.detach(item);
                        if (!em.contains(item)) {
                            item = em.merge(item);
                        }
                        em.remove(item);
                        utx.commit();
                    }
                    session.setAttribute("orderSuccess", order);
                    RequestDispatcher r = request.getRequestDispatcher("/index");
                    r.forward(request, response);
                } else {
                    response.sendRedirect("checkout.jsp");
                }
            } catch (Exception ex) {
                out.println(ex.getMessage());
            }

        } else {
            response.sendRedirect("login.jsp");
        }
    }

}
