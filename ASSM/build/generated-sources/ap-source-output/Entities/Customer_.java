package Entities;

import Entities.Orders;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-05-08T23:18:30")
@StaticMetamodel(Customer.class)
public class Customer_ { 

    public static volatile SingularAttribute<Customer, String> firstname;
    public static volatile SingularAttribute<Customer, String> password;
    public static volatile SingularAttribute<Customer, String> address;
    public static volatile SingularAttribute<Customer, Date> createddate;
    public static volatile SingularAttribute<Customer, Integer> customerid;
    public static volatile SingularAttribute<Customer, String> phonenumber;
    public static volatile SingularAttribute<Customer, Date> modifieddate;
    public static volatile SingularAttribute<Customer, String> customername;
    public static volatile SingularAttribute<Customer, String> email;
    public static volatile ListAttribute<Customer, Orders> ordersList;
    public static volatile SingularAttribute<Customer, String> lastname;

}