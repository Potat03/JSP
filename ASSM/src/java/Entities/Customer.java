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
import javax.persistence.Lob;
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
@Table(name = "CUSTOMER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Customer.findAll", query = "SELECT c FROM Customer c"),
    @NamedQuery(name = "Customer.findByCustomerid", query = "SELECT c FROM Customer c WHERE c.customerid = :customerid"),
    @NamedQuery(name = "Customer.findByCustomername", query = "SELECT c FROM Customer c WHERE c.customername = :customername"),
    @NamedQuery(name = "Customer.findByFirstname", query = "SELECT c FROM Customer c WHERE c.firstname = :firstname"),
    @NamedQuery(name = "Customer.findByLastname", query = "SELECT c FROM Customer c WHERE c.lastname = :lastname"),
    @NamedQuery(name = "Customer.findByEmail", query = "SELECT c FROM Customer c WHERE c.email = :email"),
    @NamedQuery(name = "Customer.findByPassword", query = "SELECT c FROM Customer c WHERE c.password = :password"),
    @NamedQuery(name = "Customer.findByPhonenumber", query = "SELECT c FROM Customer c WHERE c.phonenumber = :phonenumber"),
    @NamedQuery(name = "Customer.findByCreateddate", query = "SELECT c FROM Customer c WHERE c.createddate = :createddate"),
    @NamedQuery(name = "Customer.findByModifieddate", query = "SELECT c FROM Customer c WHERE c.modifieddate = :modifieddate"),
    @NamedQuery(name = "Customer.findByEmailAndPassword", query = "SELECT c FROM Customer c WHERE c.email = :email AND c.password = :password")})

public class Customer implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "CUSTOMERID")
    private Integer customerid;
    @Size(max = 30)
    @Column(name = "CUSTOMERNAME")
    private String customername;
    @Size(max = 20)
    @Column(name = "FIRSTNAME")
    private String firstname;
    @Size(max = 30)
    @Column(name = "LASTNAME")
    private String lastname;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "EMAIL")
    private String email;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 70)
    @Column(name = "PASSWORD")
    private String password;
    @Size(max = 20)
    @Column(name = "PHONENUMBER")
    private String phonenumber;
    @Lob
    @Size(max = 32700)
    @Column(name = "ADDRESS")
    private String address;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATEDDATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createddate;
    @Basic(optional = false)
    @NotNull
    @Column(name = "MODIFIEDDATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifieddate;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "customerid")
    private List<Orders> ordersList;

    public Customer() {
    }

    public Customer(Integer customerid) {
        this.customerid = customerid;
    }

    public Customer(Integer customerid, String email, String password, Date createddate, Date modifieddate) {
        this.customerid = customerid;
        this.email = email;
        this.password = password;
        this.createddate = createddate;
        this.modifieddate = modifieddate;
    }

    public Customer(String customername, String firstname, String lastname, String email, String password, String phonenumber, String address, Date createddate, Date modifieddate) {
        this.customername = customername;
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.password = password;
        this.phonenumber = phonenumber;
        this.address = address;
        this.createddate = createddate;
        this.modifieddate = modifieddate;
    }

    public Integer getCustomerid() {
        return customerid;
    }

    public void setCustomerid(Integer customerid) {
        this.customerid = customerid;
    }

    public String getCustomername() {
        return customername;
    }

    public void setCustomername(String customername) {
        this.customername = customername;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public Date getCreateddate() {
        return createddate;
    }

    public void setCreateddate(Date createddate) {
        this.createddate = createddate;
    }

    public Date getModifieddate() {
        return modifieddate;
    }

    public void setModifieddate(Date modifieddate) {
        this.modifieddate = modifieddate;
    }

    // custom
    public Cart getCart() {
        Cart cart = new Cart();
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        String sql = "SELECT * FROM CART WHERE CUSTOMERID = ?";
        try (Connection conn = DriverManager.getConnection(host, username, password); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, this.customerid);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                cart = new Cart(rs.getInt("CARTID"), rs.getInt("CUSTOMERID"), rs.getDate("MODIFIEDDATE"));
            }
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return cart;
    }

    public List<Customer> getCustomerJoined() {
        List<Customer> customerlist = new ArrayList();
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        String query = "SELECT COUNT(*) AS JOINED,\n"
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
                + "       END as MONTHNAME\n"
                + "FROM CUSTOMER\n"
                + "GROUP BY MONTH(CREATEDDATE)";
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                    Customer cust = new Customer();
                    cust.setCustomerid(rs.getInt("JOINED"));
                    cust.setAddress(rs.getString("MONTHNAME"));
                    customerlist.add(cust);
            }
            con.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return customerlist;
    }

    @XmlTransient
    public List<Orders> getOrdersList() {
        return ordersList;
    }

    public void setOrdersList(List<Orders> ordersList) {
        this.ordersList = ordersList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (customerid != null ? customerid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Customer)) {
            return false;
        }
        Customer other = (Customer) object;
        if ((this.customerid == null && other.customerid != null) || (this.customerid != null && !this.customerid.equals(other.customerid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entities.Customer[ customerid=" + customerid + " ]";
    }

}
