package Entities;

import Entities.Cartlist;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-05-08T23:18:30")
@StaticMetamodel(Cart.class)
public class Cart_ { 

    public static volatile SingularAttribute<Cart, Integer> cartid;
    public static volatile SingularAttribute<Cart, Integer> customerid;
    public static volatile SingularAttribute<Cart, Date> modifieddate;
    public static volatile ListAttribute<Cart, Cartlist> cartlistList;

}