/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entities;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@Table(name = "CATEGORY")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c"),
    @NamedQuery(name = "Category.findByCategoryid", query = "SELECT c FROM Category c WHERE c.categoryid = :categoryid"),
    @NamedQuery(name = "Category.findByCategoryname", query = "SELECT c FROM Category c WHERE c.categoryname = :categoryname"),
    @NamedQuery(name = "Category.findByCreateddate", query = "SELECT c FROM Category c WHERE c.createddate = :createddate"),
    @NamedQuery(name = "Category.findByModifieddate", query = "SELECT c FROM Category c WHERE c.modifieddate = :modifieddate")})
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "CATEGORYID")
    private Integer categoryid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "CATEGORYNAME")
    private String categoryname;
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
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "categoryid")
    private List<Categorylist> categorylistList;

    public Category() {
    }

    public Category(Integer categoryid) {
        this.categoryid = categoryid;
    }

    public Category(Integer categoryid, String categoryname, Date createddate, Date modifieddate) {
        this.categoryid = categoryid;
        this.categoryname = categoryname;
        this.createddate = createddate;
        this.modifieddate = modifieddate;
    }

    public Category(String categoryname, Date createddate, Date modifieddate) {
        this.categoryname = categoryname;
        this.createddate = createddate;
        this.modifieddate = modifieddate;
    }

    public Integer getCategoryid() {
        return categoryid;
    }

    public void setCategoryid(Integer categoryid) {
        this.categoryid = categoryid;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
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
//    public List<Category> getMostSoldCategory() {
//        SELECT c.categoryname
//        , SUM(ol.quantity) as total_sold
//        FROM category c JOIN categorylist cl ON c
//        .categoryname = cl.categoryname
//        JOIN product p ON cl.productcode = p.productcode
//        JOIN orderlist ol ON p.productcode = ol.productcode
//        GROUP BY c.categoryname ORDER BY total_sold DESC FETCH NEXT 5 ROWS ONLY;
//    }
    @XmlTransient
    public List<Categorylist> getCategorylistList() {
        return categorylistList;
    }

    public void setCategorylistList(List<Categorylist> categorylistList) {
        this.categorylistList = categorylistList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (categoryid != null ? categoryid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Category)) {
            return false;
        }
        Category other = (Category) object;
        if ((this.categoryid == null && other.categoryid != null) || (this.categoryid != null && !this.categoryid.equals(other.categoryid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entities.Category[ categoryid=" + categoryid + " ]";
    }

}
