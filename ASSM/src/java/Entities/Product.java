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
@Table(name = "PRODUCT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p"),
    @NamedQuery(name = "Product.findByProductcode", query = "SELECT p FROM Product p WHERE p.productcode = :productcode"),
    @NamedQuery(name = "Product.findByProductname", query = "SELECT p FROM Product p WHERE p.productname = :productname"),
    @NamedQuery(name = "Product.findByPrice", query = "SELECT p FROM Product p WHERE p.price = :price"),
    @NamedQuery(name = "Product.findByStock", query = "SELECT p FROM Product p WHERE p.stock = :stock"),
    @NamedQuery(name = "Product.findByCreateddate", query = "SELECT p FROM Product p WHERE p.createddate = :createddate"),
    @NamedQuery(name = "Product.findByModifieddate", query = "SELECT p FROM Product p WHERE p.modifieddate = :modifieddate")})
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "PRODUCTCODE")
    private Integer productcode;
    @Size(max = 40)
    @Column(name = "PRODUCTNAME")
    private String productname;
    @Lob
    @Size(max = 32700)
    @Column(name = "DESCRIPTION")
    private String description;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "PRICE")
    private Double price;
    @Column(name = "STOCK")
    private Integer stock;
    @Lob
    @Size(max = 32700)
    @Column(name = "IMAGE")
    private String image;
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
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "productcode")
    private List<Orderlist> orderlistList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "productcode")
    private List<Cartlist> cartlistList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "productcode")
    private List<Categorylist> categorylistList;
    @JoinColumn(name = "PROMOTIONID", referencedColumnName = "PROMOTIONID")
    @ManyToOne
    private Promotion promotionid;

    public Product() {
    }

    public Product(Integer productcode) {
        this.productcode = productcode;
    }

    public Product(Integer productcode, Date createddate, Date modifieddate) {
        this.productcode = productcode;
        this.createddate = createddate;
        this.modifieddate = modifieddate;
    }

    public Product(int productcode, String productname, String description, Double price, Integer stock, String image, Promotion promotionid) {
        this.productcode = productcode;
        this.productname = productname;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.image = image;
        this.promotionid = promotionid;
    }

    public Product(int productcode, String productname, Integer stock, String image) {
        this.productcode = productcode;
        this.productname = productname;
        this.stock = stock;
        this.image = image;
    }

    public Product(Integer productcode, String productname, String description, Double price, Integer stock, String image, Date modifieddate, Promotion promotionid) {
        this.productcode = productcode;
        this.productname = productname;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.image = image;
        this.modifieddate = modifieddate;
        this.promotionid = promotionid;
    }

    public Product(Integer productcode, String productname, String description, Double price, Integer stock, String image, Date createddate, Date modifieddate, Promotion promotionid) {
        this.productcode = productcode;
        this.productname = productname;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.image = image;
        this.createddate = createddate;
        this.modifieddate = modifieddate;
        this.promotionid = promotionid;
    }

    public Product(String productname, String description, Double price, Integer stock, String image, Date createddate, Date modifieddate, Promotion promotionid) {
        this.productname = productname;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.image = image;
        this.createddate = createddate;
        this.modifieddate = modifieddate;
        this.promotionid = promotionid;
    }

    public Product rsToProduct(ResultSet rs) {

        Product resultProduct = null;

        try {
            resultProduct = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble("PRICE"), rs.getInt(5), rs.getString(6), new Promotion(rs.getInt("PROMOTIONID")));
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return resultProduct;
    }

    public Integer getProductcode() {
        return productcode;
    }

    public void setProductcode(Integer productcode) {
        this.productcode = productcode;
    }

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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

    //custom
    public List<Integer> getBestSelling() {
        List<Integer> product = new ArrayList();
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement("SELECT PRODUCT.PRODUCTCODE, COUNT(*) AS ORDER_COUNT \n"
                    + "FROM ORDERLIST \n"
                    + "JOIN PRODUCT ON ORDERLIST.PRODUCTCODE = PRODUCT.PRODUCTCODE \n"
                    + "GROUP BY PRODUCT.PRODUCTCODE, PRODUCT.PRODUCTNAME \n"
                    + "ORDER BY ORDER_COUNT DESC \n"
                    + "FETCH NEXT 8 ROWS ONLY");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                product.add(rs.getInt("PRODUCTCODE"));
            }
            con.close();

        } catch (SQLException ex) {
            System.err.println(ex);
            product.add(9999);
        }

        return product;
    }

    public List<Integer> getProdCategories() {
        List<Integer> category = new ArrayList();
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement("SELECT CATEGORYLIST.CATEGORYID "
                    + "FROM CATEGORYLIST "
                    + "WHERE CATEGORYLIST.PRODUCTCODE = ?");
            stmt.setInt(1, this.productcode);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                category.add(rs.getInt("CATEGORYID"));
            }
            con.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return category;
    }

    public List<Product> getYouMightLike(int id, int number, int mode) {
        List<Product> mightLike = new ArrayList();
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        String query = "SELECT *\n"
                + "FROM PRODUCT p \n"
                + "WHERE NOT EXISTS (\n"
                + "  SELECT 1 \n"
                + "  FROM cartlist c \n"
                + "  WHERE c.cartid = (SELECT CARTID FROM CART WHERE CUSTOMERID = ?)\n"
                + "  AND c.productcode = p.productcode\n"
                + ") ORDER BY RANDOM() FETCH FIRST " + number + " ROWS ONLY";
        if (mode == 2) {
            query = "SELECT p.productcode\n"
                    + "FROM PRODUCT p \n"
                    + "WHERE NOT EXISTS (\n"
                    + "  SELECT 1 \n"
                    + "  FROM orderlist o \n"
                    + "  WHERE o.orderid IN (SELECT ORDERID FROM ORDER WHERE CUSTOMERID = ?)\n"
                    + "  AND o.productcode = p.productcode\n"
                    + ") ORDER BY RANDOM() FETCH FIRST " + number + " ROWS ONLY";
        }

        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                mightLike.add(rsToProduct(rs));
            }
            con.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return mightLike;
    }

    public void removePromoid() {
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement("UPDATE PRODUCT SET PROMOTIONID = NULL");
            stmt.executeUpdate();
            con.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }
    }

    public List<Product> getMostSalesProduct(int no, int month) {
        List<Product> products = new ArrayList();
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement("SELECT P.PRODUCTCODE, P.PRODUCTNAME, K.TOTAL, P.IMAGE\n"
                    + "FROM PRODUCT P\n"
                    + "LEFT JOIN (SELECT P.PRODUCTCODE, COALESCE(SUM(S.QUANTITY), 0) AS TOTAL FROM PRODUCT P\n"
                    + "LEFT JOIN (SELECT * FROM ORDERLIST WHERE ORDERID IN (SELECT ORDERID FROM ORDERS WHERE MONTH(CREATEDDATE) = ? "
                    + "AND YEAR(CREATEDDATE) = YEAR(CURRENT_DATE))) S\n"
                    + "ON P.PRODUCTCODE = S.PRODUCTCODE  \n"
                    + "GROUP BY P.PRODUCTCODE, P.PRODUCTNAME, P.CREATEDDATE\n"
                    + ") K ON P.PRODUCTCODE = K.PRODUCTCODE\n"
                    + "ORDER BY K.TOTAL DESC, P.CREATEDDATE\n"
                    + "FETCH FIRST ? ROW ONLY");
            stmt.setInt(1, month);
            stmt.setInt(2, no);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                products.add(new Product(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4)));
            }
            con.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return products;
    }

    public List<Product> getLeastSalesProduct(int no, int month) {
        List<Product> products = new ArrayList();
        String host = "jdbc:derby://localhost:1527/pettodb";
        String username = "nbuser";
        String password = "nbuser";
        try {
            Connection con = DriverManager.getConnection(host, username, password);
            PreparedStatement stmt = con.prepareStatement("SELECT P.PRODUCTCODE, P.PRODUCTNAME, K.TOTAL, P.IMAGE\n"
                    + "FROM PRODUCT P\n"
                    + "LEFT JOIN (SELECT P.PRODUCTCODE, COALESCE(SUM(S.QUANTITY), 0) AS TOTAL FROM PRODUCT P\n"
                    + "LEFT JOIN (SELECT * FROM ORDERLIST WHERE ORDERID IN (SELECT ORDERID FROM ORDERS WHERE MONTH(CREATEDDATE) = ? "
                    + "AND YEAR(CREATEDDATE) = YEAR(CURRENT_DATE))) S\n"
                    + "ON P.PRODUCTCODE = S.PRODUCTCODE  \n"
                    + "GROUP BY P.PRODUCTCODE, P.PRODUCTNAME, P.CREATEDDATE\n"
                    + ") K ON P.PRODUCTCODE = K.PRODUCTCODE\n"
                    + "ORDER BY K.TOTAL, P.CREATEDDATE\n"
                    + "FETCH FIRST ? ROW ONLY");
            stmt.setInt(1, month);
            stmt.setInt(2, no);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                products.add(new Product(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4)));
            }
            con.close();
        } catch (SQLException ex) {
            System.err.println(ex);
        }

        return products;
    }

    @XmlTransient
    public List<Orderlist> getOrderlistList() {
        return orderlistList;
    }

    public void setOrderlistList(List<Orderlist> orderlistList) {
        this.orderlistList = orderlistList;
    }

    @XmlTransient
    public List<Cartlist> getCartlistList() {
        return cartlistList;
    }

    public void setCartlistList(List<Cartlist> cartlistList) {
        this.cartlistList = cartlistList;
    }

    @XmlTransient
    public List<Categorylist> getCategorylistList() {
        return categorylistList;
    }

    public void setCategorylistList(List<Categorylist> categorylistList) {
        this.categorylistList = categorylistList;
    }

    public Promotion getPromotionid() {
        return promotionid;
    }

    public void setPromotionid(Promotion promotionid) {
        this.promotionid = promotionid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (productcode != null ? productcode.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Product)) {
            return false;
        }
        Product other = (Product) object;
        if ((this.productcode == null && other.productcode != null) || (this.productcode != null && !this.productcode.equals(other.productcode))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entities.Product[ productcode=" + productcode + " ]";
    }

}
