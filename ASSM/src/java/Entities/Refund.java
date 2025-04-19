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
@Table(name = "REFUND")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Refund.findAll", query = "SELECT r FROM Refund r"),
    @NamedQuery(name = "Refund.findByRefundid", query = "SELECT r FROM Refund r WHERE r.refundid = :refundid"),
    @NamedQuery(name = "Refund.findByPaymentid", query = "SELECT r FROM Refund r WHERE r.paymentid = :paymentid"),
    @NamedQuery(name = "Refund.findByStatus", query = "SELECT r FROM Refund r WHERE r.status = :status"),
    @NamedQuery(name = "Refund.findByCreateddate", query = "SELECT r FROM Refund r WHERE r.createddate = :createddate")})
public class Refund implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "REFUNDID")
    private Integer refundid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PAYMENTID")
    private int paymentid;
    @Size(max = 10)
    @Column(name = "STATUS")
    private String status;
    @Lob
    @Size(max = 32700)
    @Column(name = "REASON")
    private String reason;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CREATEDDATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createddate;
    @JoinColumn(name = "STAFFID", referencedColumnName = "STAFFID")
    @ManyToOne(optional = false)
    private Staff staffid;

    public Refund() {
    }

    public Refund(Integer refundid) {
        this.refundid = refundid;
    }

    public Refund(Integer refundid, int paymentid, Date createddate) {
        this.refundid = refundid;
        this.paymentid = paymentid;
        this.createddate = createddate;
    }

    public Integer getRefundid() {
        return refundid;
    }

    public void setRefundid(Integer refundid) {
        this.refundid = refundid;
    }

    public int getPaymentid() {
        return paymentid;
    }

    public void setPaymentid(int paymentid) {
        this.paymentid = paymentid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
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
        hash += (refundid != null ? refundid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Refund)) {
            return false;
        }
        Refund other = (Refund) object;
        if ((this.refundid == null && other.refundid != null) || (this.refundid != null && !this.refundid.equals(other.refundid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Entities.Refund[ refundid=" + refundid + " ]";
    }
    
}
