package Entities;

import Entities.Cartlist;
import Entities.Categorylist;
import Entities.Orderlist;
import Entities.Promotion;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-05-08T23:18:30")
@StaticMetamodel(Product.class)
public class Product_ { 

    public static volatile SingularAttribute<Product, String> image;
    public static volatile SingularAttribute<Product, Integer> productcode;
    public static volatile ListAttribute<Product, Categorylist> categorylistList;
    public static volatile SingularAttribute<Product, Date> createddate;
    public static volatile SingularAttribute<Product, Double> price;
    public static volatile SingularAttribute<Product, String> description;
    public static volatile SingularAttribute<Product, Date> modifieddate;
    public static volatile SingularAttribute<Product, String> productname;
    public static volatile SingularAttribute<Product, Integer> stock;
    public static volatile SingularAttribute<Product, Promotion> promotionid;
    public static volatile ListAttribute<Product, Cartlist> cartlistList;
    public static volatile ListAttribute<Product, Orderlist> orderlistList;

}