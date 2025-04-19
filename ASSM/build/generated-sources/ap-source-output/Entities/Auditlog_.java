package Entities;

import Entities.Staff;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-05-08T23:18:30")
@StaticMetamodel(Auditlog.class)
public class Auditlog_ { 

    public static volatile SingularAttribute<Auditlog, Integer> auditlogid;
    public static volatile SingularAttribute<Auditlog, Date> createddate;
    public static volatile SingularAttribute<Auditlog, String> description;
    public static volatile SingularAttribute<Auditlog, Staff> staffid;

}