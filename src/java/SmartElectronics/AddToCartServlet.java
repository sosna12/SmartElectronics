
package SmartElectronics;

import java.io.IOException;
//import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;


public class AddToCartServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest rq, HttpServletResponse rp)
            throws ServletException, IOException {
  
    }

 

    @Override
protected void doPost(HttpServletRequest rq, HttpServletResponse rp)
        throws ServletException, IOException {

    HttpSession session = rq.getSession();

    // Check login
    if(session == null || session.getAttribute("user_id") == null){
        rp.sendRedirect("login.html");
        return;
    }

    // ✅ Get correct user_id from session
    int user_id = (int) session.getAttribute("user_id");

    // ✅ Get product data
    int product_id = Integer.parseInt(rq.getParameter("product_id"));
    int quantity = 1; // always 1 for now

    try {
        Connection con = DBConnection.getConnection();

        // DEBUG (VERY IMPORTANT)
        System.out.println("USER_ID: " + user_id);
        System.out.println("PRODUCT_ID: " + product_id);

        // Insert into cart
       // Check if product already exists in cart
PreparedStatement check = con.prepareStatement(
    "SELECT * FROM cart WHERE user_id=? AND product_id=?"
);
check.setInt(1, user_id);
check.setInt(2, product_id);

ResultSet rs = check.executeQuery();

if(rs.next()){
    // Product already exists → increase quantity
    PreparedStatement update = con.prepareStatement(
        "UPDATE cart SET quantity = quantity + 1 WHERE user_id=? AND product_id=?"
    );
    update.setInt(1, user_id);
    update.setInt(2, product_id);
    update.executeUpdate();
} else {
    // Product not exists → insert new
    PreparedStatement insert = con.prepareStatement(
        "INSERT INTO cart(user_id, product_id, quantity) VALUES(?,?,?)"
    );
    insert.setInt(1, user_id);
    insert.setInt(2, product_id);
    insert.setInt(3, 1);
    insert.executeUpdate();
}
        rp.sendRedirect("cart.jsp");

    } catch(Exception e){
        e.printStackTrace();
    }
}
}