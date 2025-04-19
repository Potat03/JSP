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
@Table(name = "STAFF")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Staff.findAll", query = "SELECT s FROM Staff s"),
    @NamedQuery(name = "Staff.findByStaffid", query = "SELECT s FROM Staff s WHERE s.staffid = :staffid"),
    @NamedQuery(name = "Staff.findByStaffname", query = "SELECT s FROM Staff s WHERE s.staffname = :staffname"),
    @NamedQuery(name = "Staff.findByStaffnameAndPassword", query = "SELECT s FROM Staff s WHERE s.staffname = :staffname AND s.password = :password"),
    @NamedQuery(name = "Staff.findByPassword", query = "SELECT s FROM Staff s WHERE s.password = :password"),
    @NamedQuery(name = "Staff.findByCreateddate", query = "SELECT s FROM Staff s WHERE s.createddate = :createddate"),
    @NamedQuery(name = "Staff.findByModifieddate", query = "SELECT s FROM Staff s WHERE s.modifieddate = :modifieddate")})
public class Staff implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "STAFFID")
    private Integer staffid;
    @Size(max = 30)
    @Column(name = "STAFFNAME")
    private String staffname;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 70)
    @Column(name = "PASSWORD")
    private String password;
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
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "staffid")
    private List<Refund> refundList;
    @OneToMany(mappedBy = "staffid")
    private List<Auditlog> auditlogList;

    public Staff() {
    }

    public Staff(Integer staffid) {
        this.staffid = staffid;
    }

    public Staff(Integer staffid, String password, Date createddate, Date modifieddate) {
        this.staffid = staffid;
        this.password = password;
        this.createddate = createddate;
        this.modifieddate = modifieddate;
    }

    public Staff(String staffname, String password, Date createddate, Date modifieddate) {
        this.staffname = staffname;
        this.password = password;
        this.createddate = createddate;
        this.modifieddate = modifieddate;
    }

    public Integer getStaffid() {
        return staffid;
    }

    public void setStaffid(Integer staffid) {
        this.staffid = staffid;
    }

    public String getStaffname() {
        return staffname;
    }

    public void setStaffname(String staffname) {
        this.staffname = staffname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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
    public List<Refund> getRefundList() {
        return refundList;
    }

    public void setRefundList(List<Refund> refundList) {
        this.refundList = refundList;
    }

    @XmlTransient
    public List<Auditlog> getAuditlogList() {
        return auditlogList;
    }

    public void setAuditlogList(List<Auditlog> auditlogList) {
        this.auditlogList = auditlogList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (staffid != null ? staffid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Staff)) {
            return false;
        }
        Staff other = (Staff) object;
        if ((this.staffid == null && other.staffid != null) || (this.staffid != null && !this.staffid.equals(other.staffid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entities.Staff[ staffid=" + staffid + " ]";
    }

}
