/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author USER
 */
@Entity
@Table(name = "AUDITLOG")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Auditlog.findAll", query = "SELECT a FROM Auditlog a"),
    @NamedQuery(name = "Auditlog.findByAuditlogid", query = "SELECT a FROM Auditlog a WHERE a.auditlogid = :auditlogid"),
    @NamedQuery(name = "Auditlog.findByCreateddate", query = "SELECT a FROM Auditlog a WHERE a.createddate = :createddate")})
public class Auditlog implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "AUDITLOGID")
    private Integer auditlogid;
    @Lob
    @Size(max = 32700)
    @Column(name = "DESCRIPTION")
    private String description;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATEDDATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createddate;
    @JoinColumn(name = "STAFFID", referencedColumnName = "STAFFID")
    @ManyToOne
    private Staff staffid;

    public Auditlog() {
    }

    public Auditlog(Integer auditlogid) {
        this.auditlogid = auditlogid;
    }

    public Auditlog(Integer auditlogid, Date createddate) {
        this.auditlogid = auditlogid;
        this.createddate = createddate;
    }

    public Auditlog(String description, Date createddate, Staff staffid) {
        this.description = description;
        this.createddate = createddate;
        this.staffid = staffid;
    }

    public Integer getAuditlogid() {
        return auditlogid;
    }

    public void setAuditlogid(Integer auditlogid) {
        this.auditlogid = auditlogid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreateddate() {
        return createddate;
    }

    public void setCreateddate(Date createddate) {
        this.createddate = createddate;
    }

    public Staff getStaffid() {
        return staffid;
    }

    public void setStaffid(Staff staffid) {
        this.staffid = staffid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (auditlogid != null ? auditlogid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Auditlog)) {
            return false;
        }
        Auditlog other = (Auditlog) object;
        if ((this.auditlogid == null && other.auditlogid != null) || (this.auditlogid != null && !this.auditlogid.equals(other.auditlogid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entities.Auditlog[ auditlogid=" + auditlogid + " ]";
    }

}
