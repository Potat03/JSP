package Entities;

import Entities.Staff;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-05-08T23:18:30")
@StaticMetamodel(Refund.class)
public class Refund_ { 

    public static volatile SingularAttribute<Refund, String> reason;
    public static volatile SingularAttribute<Refund, Date> createddate;
    public static volatile SingularAttribute<Refund, Integer> paymentid;
    public static volatile SingularAttribute<Refund, Integer> refundid;
    public static volatile SingularAttribute<Refund, Staff> staffid;
    public static volatile SingularAttribute<Refund, String> status;

}