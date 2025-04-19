/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entities;

import java.io.Serializable;
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
@Table(name = "CARTLIST")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cartlist.findAll", query = "SELECT c FROM Cartlist c"),
    @NamedQuery(name = "Cartlist.findByCartid", query = "SELECT c FROM Cartlist c WHERE c.cartid = :cartid"),
    @NamedQuery(name = "Cartlist.findByCartidAndProductcode", query = "SELECT c FROM Cartlist c WHERE c.cartid = :cartid AND c.productcode = :productcode"),
    @NamedQuery(name = "Cartlist.findByCartlistid", query = "SELECT c FROM Cartlist c WHERE c.cartlistid = :cartlistid"),
    @NamedQuery(name = "Cartlist.findByQuantity", query = "SELECT c FROM Cartlist c WHERE c.quantity = :quantity")})
public class Cartlist implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "CARTLISTID")
    private Integer cartlistid;
    @Column(name = "QUANTITY")
    private Integer quantity;
    @JoinColumn(name = "CARTID", referencedColumnName = "CARTID")
    @ManyToOne(optional = false)
    private Cart cartid;
    @JoinColumn(name = "PRODUCTCODE", referencedColumnName = "PRODUCTCODE")
    @ManyToOne(optional = false)
    private Product productcode;

    public Cartlist() {
    }

    public Cartlist(Integer cartlistid) {
        this.cartlistid = cartlistid;
    }

    public Cartlist(Integer quantity, Cart cartid, Product productcode) {
        this.quantity = quantity;
        this.cartid = cartid;
        this.productcode = productcode;
    }

    public Cartlist(Integer cartlistid, Integer quantity, Cart cartid) {
        this.cartlistid = cartlistid;
        this.quantity = quantity;
        this.cartid = cartid;
    }

    public Integer getCartlistid() {
        return cartlistid;
    }

    public void setCartlistid(Integer cartlistid) {
        this.cartlistid = cartlistid;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Cart getCartid() {
        return cartid;
    }

    public void setCartid(Cart cartid) {
        this.cartid = cartid;
    }

    public Product getProductcode() {
        return productcode;
    }

    public void setProductcode(Product productcode) {
        this.productcode = productcode;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (cartlistid != null ? cartlistid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cartlist)) {
            return false;
        }
        Cartlist other = (Cartlist) object;
        if ((this.cartlistid == null && other.cartlistid != null) || (this.cartlistid != null && !this.cartlistid.equals(other.cartlistid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entities.Cartlist[ cartlistid=" + cartlistid + " ]";
    }

}
