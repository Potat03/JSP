/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entities;

import java.io.Serializable;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author USER
 */
@Entity
@Table(name = "ORDERS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Orders.findAll", query = "SELECT o FROM Orders o"),
    @NamedQuery(name = "Orders.findByOrderid", query = "SELECT o FROM Orders o WHERE o.orderid = :orderid"),
    @NamedQuery(name = "Orders.findByCustomerid", query = "SELECT o FROM Orders o WHERE o.customerid = :customerid"),
    @NamedQuery(name = "Orders.findByPaymentid", query = "SELECT o FROM Orders o WHERE o.paymentid = :paymentid"),
    @NamedQuery(name = "Orders.findByPromotionvalue", query = "SELECT o FROM Orders o WHERE o.promotionvalue = :promotionvalue"),
    @NamedQuery(name = "Orders.findBySubtotal", query = "SELECT o FROM Orders o WHERE o.subtotal = :subtotal"),
    @NamedQuery(name = "Orders.findByTotal", query = "SELECT o FROM Orders o WHERE o.total = :total"),
    @NamedQuery(name = "Orders.findByPhonenumber", query = "SELECT o FROM Orders o WHERE o.phonenumber = :phonenumber"),
    @NamedQuery(name = "Orders.findByCreateddate", query = "SELECT o FROM Orders o WHERE o.createddate = :createddate")})
public class Orders implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ORDERID")
    private Integer orderid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PAYMENTID")
    private int paymentid;
    // @Max(value=?) @Min(value=?)//if you know range of your decimal fields
    // consider using these annotations to enforce field validation
    @Column(name = "PROMOTIONVALUE")
    private Double promotionvalue;
    @Column(name = "SUBTOTAL")
    private Double subtotal;
    @Column(name = "TOTAL")
    private Double total;
    @Size(max = 20)
    @Column(name = "PHONENUMBER")
    private String phonenumber;
    @Lob
    @Size(max = 32700)
    @Column(name = "ADDRESS")
    private String address;
    @Lob
    @Size(max = 32700)
    @Column(name = "STATUS")
    private String status;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATEDDATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createddate;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "orderid")
    private List<Orderlist> orderlistList;
    @JoinColumn(name = "CUSTOMERID", referencedColumnName = "CUSTOMERID")
    @ManyToOne(optional = false)
    private Customer customerid;

    public Orders() {
    }

    public Orders(Integer orderid) {
        this.orderid = orderid;
    }

    public Orders(Integer orderid, int paymentid, Date createddate) {
        this.orderid = orderid;
        this.paymentid = paymentid;
        this.createddate = createddate;
    }

    public Orders(int paymentid, Double promotionvalue, Double subtotal, Double total, String phonenumber,
            String address, String status, Date createddate, Customer customerid) {
        this.paymentid = paymentid;
        this.promotionvalue = promotionvalue;
        this.subtotal = subtotal;
        this.total = total;
        this.phonenumber = phonenumber;
        this.address = address;
        this.status = status;
        this.createddate = createddate;
        this.customerid = customerid;
    }

    public Integer getOrderid() {
        return orderid;
    }

    public void setOrderid(Integer orderid) {
        this.orderid = orderid;
    }

    public int getPaymentid() {
        return paymentid;
    }

    public void setPaymentid(int paymentid) {
        this.paymentid = paymentid;
    }

    public Double getPromotionvalue() {
        return promotionvalue;
    }

    public void setPromotionvalue(Double promotionvalue) {
        this.promotionvalue = promotionvalue;
    }

    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreateddate() {
        return createddate;
    }

    public void setCreateddate(Date createddate) {
        this.createddate = createddate;
    }

    // custom
    public List<Orders> getByStatus(String status) {
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        List<Orders> orders = new ArrayList<>();
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con
                    .prepareStatement("SELECT * FROM ORDERS WHERE CAST( STATUS AS VARCHAR(128)) = ?");
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Orders order = new Orders();
                order.setOrderid(rs.getInt("ORDERID"));
                order.setPaymentid(rs.getInt("PAYMENTID"));
                order.setPromotionvalue(rs.getDouble("PROMOTIONVALUE"));
                order.setSubtotal(rs.getDouble("SUBTOTAL"));
                order.setTotal(rs.getDouble("TOTAL"));
                order.setPhonenumber(rs.getString("PHONENUMBER"));
                order.setAddress(rs.getString("ADDRESS"));
                order.setStatus(rs.getString("STATUS"));
                order.setCreateddate(rs.getDate("CREATEDDATE"));
                orders.add(order);
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return orders;
    }

    public String getPaymentMethod() {
        String method = null;
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement("SELECT PAYMENT.METHOD "
                    + "FROM PAYMENT WHERE PAYMENT.PAYMENTID = ?");
            stmt.setInt(1, this.paymentid);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                method = rs.getString("METHOD");
            }
            con.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return method;
    }

    public Payment getPayment() {
        Payment payment = new Payment();
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM PAYMENT WHERE PAYMENT.PAYMENTID = ?");
            stmt.setInt(1, this.paymentid);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                payment.setPaymentid(rs.getInt("PAYMENTID"));
                payment.setMethod(rs.getString("METHOD"));
                payment.setTransactionid(rs.getString("TRANSACTIONID"));
                payment.setTotal(rs.getDouble("TOTAL"));
            }
            con.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return payment;
    }

    public List<Orders> getRevenue() {
        List<Orders> emptyList = new ArrayList();
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        String query = "SELECT SUM(TOTAL) AS REVENUE, \n"
                + "CASE \n"
                + "         WHEN MONTH(CREATEDDATE) = 1 THEN 'January' \n"
                + "         WHEN MONTH(CREATEDDATE) = 2 THEN 'February' \n"
                + "         WHEN MONTH(CREATEDDATE) = 3 THEN 'March' \n"
                + "         WHEN MONTH(CREATEDDATE) = 4 THEN 'April' \n"
                + "         WHEN MONTH(CREATEDDATE) = 5 THEN 'May' \n"
                + "         WHEN MONTH(CREATEDDATE) = 6 THEN 'June' \n"
                + "         WHEN MONTH(CREATEDDATE) = 7 THEN 'July' \n"
                + "         WHEN MONTH(CREATEDDATE) = 8 THEN 'August' \n"
                + "         WHEN MONTH(CREATEDDATE) = 9 THEN 'September' \n"
                + "         WHEN MONTH(CREATEDDATE) = 10 THEN 'October' \n"
                + "         WHEN MONTH(CREATEDDATE) = 11 THEN 'November' \n"
                + "         WHEN MONTH(CREATEDDATE) = 12 THEN 'December' \n"
                + "       END as MONTH_NAME\n"
                + "FROM ORDERS\n"
                + "GROUP BY MONTH(CREATEDDATE)";
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                List<Orders> order = new ArrayList();
                do {
                    Orders orders = new Orders();
                    orders.setTotal(rs.getDouble("REVENUE"));
                    orders.setAddress(rs.getString("MONTH_NAME"));
                    order.add(orders);
                } while (rs.next());
                return order;
            }
            con.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return emptyList;
    }

    @XmlTransient
    public List<Orderlist> getOrderlistList() {
        return orderlistList;
    }

    public void setOrderlistList(List<Orderlist> orderlistList) {
        this.orderlistList = orderlistList;
    }

    public Customer getCustomerid() {
        return customerid;
    }

    public void setCustomerid(Customer customerid) {
        this.customerid = customerid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (orderid != null ? orderid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Orders)) {
            return false;
        }
        Orders other = (Orders) object;
        if ((this.orderid == null && other.orderid != null)
                || (this.orderid != null && !this.orderid.equals(other.orderid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entities.Orders[ orderid=" + orderid + " ]";
    }

}
