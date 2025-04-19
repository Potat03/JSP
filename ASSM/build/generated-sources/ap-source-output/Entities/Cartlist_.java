package Entities;

import Entities.Cart;
import Entities.Product;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-05-08T23:18:30")
@StaticMetamodel(Cartlist.class)
public class Cartlist_ { 

    public static volatile SingularAttribute<Cartlist, Product> productcode;
    public static volatile SingularAttribute<Cartlist, Integer> quantity;
    public static volatile SingularAttribute<Cartlist, Cart> cartid;
    public static volatile SingularAttribute<Cartlist, Integer> cartlistid;

}