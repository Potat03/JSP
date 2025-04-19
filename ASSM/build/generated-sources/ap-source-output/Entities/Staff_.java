package Entities;

import Entities.Auditlog;
import Entities.Refund;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-05-08T23:18:30")
@StaticMetamodel(Staff.class)
public class Staff_ { 

    public static volatile SingularAttribute<Staff, String> password;
    public static volatile SingularAttribute<Staff, Date> createddate;
    public static volatile SingularAttribute<Staff, Date> modifieddate;
    public static volatile ListAttribute<Staff, Refund> refundList;
    public static volatile SingularAttribute<Staff, String> staffname;
    public static volatile SingularAttribute<Staff, Integer> staffid;
    public static volatile ListAttribute<Staff, Auditlog> auditlogList;

}