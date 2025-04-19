/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entities;

import java.io.Serializable;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author USER
 */
@Entity
@Table(name = "CATEGORYLIST")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Categorylist.findAll", query = "SELECT c FROM Categorylist c"),
    @NamedQuery(name = "Categorylist.findByCategorylistid", query = "SELECT c FROM Categorylist c WHERE c.categorylistid = :categorylistid"),
    @NamedQuery(name = "Categorylist.findByProductcode", query = "SELECT c FROM Categorylist c WHERE c.productcode = :productcode"),
    @NamedQuery(name = "Categorylist.findByCategoryid", query = "SELECT c FROM Categorylist c WHERE c.categoryid = :categoryid")})
public class Categorylist implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "CATEGORYLISTID")
    private Integer categorylistid;
    @JoinColumn(name = "CATEGORYID", referencedColumnName = "CATEGORYID")
    @ManyToOne(optional = false)
    private Category categoryid;
    @JoinColumn(name = "PRODUCTCODE", referencedColumnName = "PRODUCTCODE")
    @ManyToOne(optional = false)
    private Product productcode;

    public Categorylist() {
    }

    public Categorylist(Integer categorylistid) {
        this.categorylistid = categorylistid;
    }

    public Categorylist(Category categoryid, Product productcode) {
        this.categoryid = categoryid;
        this.productcode = productcode;
    }

    public Integer getCategorylistid() {
        return categorylistid;
    }

    public void setCategorylistid(Integer categorylistid) {
        this.categorylistid = categorylistid;
    }

    public Category getCategoryid() {
        return categoryid;
    }

    public void setCategoryid(Category categoryid) {
        this.categoryid = categoryid;
    }

    public Product getProductcode() {
        return productcode;
    }

    public void setProductcode(Product productcode) {
        this.productcode = productcode;
    }

    //custom
    public void deleteListByProd(int productcode) {
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement("DELETE * FROM CATEGORYLIST WHERE PRODUCTCODE = ?");
            stmt.setInt(1, productcode);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            System.err.println(ex);
        }
    }

    public void deleteListByCat(int categoryid) {
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement("DELETE * FROM CATEGORYLIST WHERE CATEGORYID = ?");
            stmt.setInt(1, categoryid);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            System.err.println(ex);
        }
    }

    public List<Categorylist> getOrderCategories(int num) {
        List<Categorylist> emptyList = new ArrayList();
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        String query = "SELECT C.CATEGORYID, C.CATEGORYNAME, K.SOLD FROM CATEGORY C, (\n"
                + "SELECT C.CATEGORYID, SUM(F.TOTAL) AS SOLD FROM \n"
                + "(SELECT DISTINCT P.PRODUCTCODE ,P.TOTAL FROM CATEGORYLIST C, (SELECT PRODUCTCODE,SUM(QUANTITY) AS TOTAL FROM ORDERLIST GROUP BY PRODUCTCODE ) P ) F, CATEGORYLIST C \n"
                + "WHERE C.PRODUCTCODE = F.PRODUCTCODE \n"
                + "GROUP BY C.CATEGORYID) K\n"
                + "WHERE C.CATEGORYID = K.CATEGORYID\n"
                + "ORDER BY SOLD DESC\n"
                + "FETCH FIRST " + num + " ROW ONLY";
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                List<Categorylist> catlist = new ArrayList();

                do {
                    Categorylist categorylist = new Categorylist();
                    Category category = new Category();
                    category.setCategoryid(rs.getInt("CATEGORYID"));
                    category.setCategoryname(rs.getString("CATEGORYNAME"));
                    categorylist.setCategoryid(category);
                    Product product = new Product();
                    product.setStock(rs.getInt("SOLD"));
                    categorylist.setProductcode(product);
                    catlist.add(categorylist);
                } while (rs.next());
                return catlist;
            }
            con.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return emptyList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (categorylistid != null ? categorylistid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Categorylist)) {
            return false;
        }
        Categorylist other = (Categorylist) object;
        if ((this.categorylistid == null && other.categorylistid != null) || (this.categorylistid != null && !this.categorylistid.equals(other.categorylistid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entities.Categorylist[ categorylistid=" + categorylistid + " ]";
    }

}
