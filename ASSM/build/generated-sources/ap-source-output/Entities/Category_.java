package Entities;

import Entities.Categorylist;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.7.10.v20211216-rNA", date="2023-05-08T23:18:30")
@StaticMetamodel(Category.class)
public class Category_ { 

    public static volatile ListAttribute<Category, Categorylist> categorylistList;
    public static volatile SingularAttribute<Category, Date> createddate;
    public static volatile SingularAttribute<Category, Date> modifieddate;
    public static volatile SingularAttribute<Category, String> categoryname;
    public static volatile SingularAttribute<Category, Integer> categoryid;

}