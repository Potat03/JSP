/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entities;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
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
@Table(name = "PROMOTION")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Promotion.findAll", query = "SELECT p FROM Promotion p"),
    @NamedQuery(name = "Promotion.findByPromotionid", query = "SELECT p FROM Promotion p WHERE p.promotionid = :promotionid"),
    @NamedQuery(name = "Promotion.findByValue", query = "SELECT p FROM Promotion p WHERE p.value = :value"),
    @NamedQuery(name = "Promotion.findByStatus", query = "SELECT p FROM Promotion p WHERE p.status = :status"),
    @NamedQuery(name = "Promotion.findByCreateddate", query = "SELECT p FROM Promotion p WHERE p.createddate = :createddate"),
    @NamedQuery(name = "Promotion.findByModifieddate", query = "SELECT p FROM Promotion p WHERE p.modifieddate = :modifieddate")})
public class Promotion implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "PROMOTIONID")
    private Integer promotionid;
    @Column(name = "VALUE")
    private Integer value;
    @Lob
    @Size(max = 32700)
    @Column(name = "DESCRIPTION")
    private String description;
    @Size(max = 10)
    @Column(name = "STATUS")
    private String status;
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
    @OneToMany(mappedBy = "promotionid")
    private List<Product> productList;

    public Promotion() {
    }

    public Promotion(Integer promotionid) {
        this.promotionid = promotionid;
    }

    public Promotion(Integer promotionid, Date createddate, Date modifieddate) {
        this.promotionid = promotionid;
        this.createddate = createddate;
        this.modifieddate = modifieddate;
    }

    public Promotion(Integer value, String description, String status, Date createddate, Date modifieddate) {
        this.value = value;
        this.description = description;
        this.status = status;
        this.createddate = createddate;
        this.modifieddate = modifieddate;
    }

    public Integer getPromotionid() {
        return promotionid;
    }

    public void setPromotionid(Integer promotionid) {
        this.promotionid = promotionid;
    }

    public Integer getValue() {
        return value;
    }

    public void setValue(Integer value) {
        this.value = value;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public Date getModifieddate() {
        return modifieddate;
    }

    public void setModifieddate(Date modifieddate) {
        this.modifieddate = modifieddate;
    }

    @XmlTransient
    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (promotionid != null ? promotionid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Promotion)) {
            return false;
        }
        Promotion other = (Promotion) object;
        if ((this.promotionid == null && other.promotionid != null) || (this.promotionid != null && !this.promotionid.equals(other.promotionid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entities.Promotion[ promotionid=" + promotionid + " ]";
    }
    
}
