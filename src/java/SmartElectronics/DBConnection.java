
package SmartElectronics;

import java.sql.*;
public class DBConnection {
    private static Connection con;
    public static Connection getConnection(){
        try{
       Class.forName("com.mysql.jdbc.Driver");
       con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce", "root", "");
       
    

    }catch(Exception e){
    e.printStackTrace();
    System.out.println(e);
    }
        return con;
    }
}
