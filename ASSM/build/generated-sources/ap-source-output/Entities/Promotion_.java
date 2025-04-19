package Entities;

import Entities.Product;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-05-08T23:18:30")
@StaticMetamodel(Promotion.class)
public class Promotion_ { 

    public static volatile SingularAttribute<Promotion, Date> createddate;
    public static volatile SingularAttribute<Promotion, String> description;
    public static volatile SingularAttribute<Promotion, Date> modifieddate;
    public static volatile SingularAttribute<Promotion, Integer> value;
    public static volatile SingularAttribute<Promotion, Integer> promotionid;
    public static volatile ListAttribute<Promotion, Product> productList;
    public static volatile SingularAttribute<Promotion, String> status;

}