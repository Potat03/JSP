package Entities;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-05-08T23:18:30")
@StaticMetamodel(Payment.class)
public class Payment_ { 

    public static volatile SingularAttribute<Payment, Double> total;
    public static volatile SingularAttribute<Payment, String> method;
    public static volatile SingularAttribute<Payment, Date> createddate;
    public static volatile SingularAttribute<Payment, Integer> paymentid;
    public static volatile SingularAttribute<Payment, String> transactionid;

}