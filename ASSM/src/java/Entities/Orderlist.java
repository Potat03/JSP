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
@Table(name = "ORDERLIST")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Orderlist.findAll", query = "SELECT o FROM Orderlist o"),
    @NamedQuery(name = "Orderlist.findByOrderlist", query = "SELECT o FROM Orderlist o WHERE o.orderlist = :orderlist"),
    @NamedQuery(name = "Orderlist.findByQuantity", query = "SELECT o FROM Orderlist o WHERE o.quantity = :quantity"),
    @NamedQuery(name = "Orderlist.findByOrderid", query = "SELECT o FROM Orderlist o WHERE o.orderid = :orderid")})
public class Orderlist implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ORDERLIST")
    private Integer orderlist;
    @Column(name = "QUANTITY")
    private Integer quantity;
    @JoinColumn(name = "ORDERID", referencedColumnName = "ORDERID")
    @ManyToOne(optional = false)
    private Orders orderid;
    @JoinColumn(name = "PRODUCTCODE", referencedColumnName = "PRODUCTCODE")
    @ManyToOne(optional = false)
    private Product productcode;

    public Orderlist() {
    }

    public Orderlist(Integer orderlist) {
        this.orderlist = orderlist;
    }

    public Orderlist(Integer quantity, Orders orderid, Product productcode) {
        this.quantity = quantity;
        this.orderid = orderid;
        this.productcode = productcode;
    }

    public Orderlist(Integer orderlist, Integer quantity, Orders orderid, Product productcode) {
        this.orderlist = orderlist;
        this.quantity = quantity;
        this.orderid = orderid;
        this.productcode = productcode;
    }
    
    

    public Integer getOrderlist() {
        return orderlist;
    }

    public void setOrderlist(Integer orderlist) {
        this.orderlist = orderlist;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Orders getOrderid() {
        return orderid;
    }

    public void setOrderid(Orders orderid) {
        this.orderid = orderid;
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
        hash += (orderlist != null ? orderlist.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Orderlist)) {
            return false;
        }
        Orderlist other = (Orderlist) object;
        if ((this.orderlist == null && other.orderlist != null) || (this.orderlist != null && !this.orderlist.equals(other.orderlist))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entities.Orderlist[ orderlist=" + orderlist + " ]";
    }

}
