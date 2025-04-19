package Entities;

import Entities.Orders;
import Entities.Product;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-05-08T23:18:30")
@StaticMetamodel(Orderlist.class)
public class Orderlist_ { 

    public static volatile SingularAttribute<Orderlist, Product> productcode;
    public static volatile SingularAttribute<Orderlist, Integer> quantity;
    public static volatile SingularAttribute<Orderlist, Orders> orderid;
    public static volatile SingularAttribute<Orderlist, Integer> orderlist;

}