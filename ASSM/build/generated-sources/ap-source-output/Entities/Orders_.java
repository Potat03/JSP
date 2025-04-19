package Entities;

import Entities.Customer;
import Entities.Orderlist;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-05-08T23:18:30")
@StaticMetamodel(Orders.class)
public class Orders_ { 

    public static volatile SingularAttribute<Orders, Double> total;
    public static volatile SingularAttribute<Orders, String> address;
    public static volatile SingularAttribute<Orders, Integer> orderid;
    public static volatile SingularAttribute<Orders, Date> createddate;
    public static volatile SingularAttribute<Orders, Integer> paymentid;
    public static volatile SingularAttribute<Orders, Double> subtotal;
    public static volatile SingularAttribute<Orders, String> phonenumber;
    public static volatile SingularAttribute<Orders, Customer> customerid;
    public static volatile SingularAttribute<Orders, Double> promotionvalue;
    public static volatile SingularAttribute<Orders, String> status;
    public static volatile ListAttribute<Orders, Orderlist> orderlistList;

}