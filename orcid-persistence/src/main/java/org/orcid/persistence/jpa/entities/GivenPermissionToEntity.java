package org.orcid.persistence.jpa.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 
 * @author Will Simpson
 * 
 */
@Table(name = "given_permission_to")
@Entity
public class GivenPermissionToEntity extends BaseEntity<Long> {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String giver;
    private String receiver;
    private Date approvalDate;

    @Override
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "given_permission_to_seq")
    @SequenceGenerator(name = "given_permission_to_seq", sequenceName = "given_permission_to_seq", allocationSize = 1)
    @Column(name = "given_permission_to_id")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(name = "giver_orcid")
    public String getGiver() {
        return giver;
    }

    public void setGiver(String giver) {
        this.giver = giver;
    }

    @Column(name = "receiver_orcid")
    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    @Column(name = "approval_date")
    public Date getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }
}
