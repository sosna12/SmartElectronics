package SmartElectronics;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class OrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        if(session == null || session.getAttribute("user_id") == null){
            response.sendRedirect("login.html");
            return;
        }

        int user_id = (int) session.getAttribute("user_id");

        try {
            Connection con = DBConnection.getConnection();

            // Get cart items
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM cart WHERE user_id=?"
            );
            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                int product_id = rs.getInt("product_id");
                int qty = rs.getInt("quantity");

                // Get price
                PreparedStatement ps2 = con.prepareStatement(
                    "SELECT price FROM products WHERE id=?"
                );
                ps2.setInt(1, product_id);
                ResultSet rs2 = ps2.executeQuery();

                double price = 0;
                if(rs2.next()){
                    price = rs2.getDouble("price");
                }

                double total_price = price * qty;

                // Insert into orders table (YOUR STRUCTURE)
                PreparedStatement insert = con.prepareStatement(
                    "INSERT INTO orders(user_id, product_id, quantity, total_price) VALUES(?,?,?,?)"
                );

                insert.setInt(1, user_id);
                insert.setInt(2, product_id);
                insert.setInt(3, qty);
                insert.setDouble(4, total_price);

                insert.executeUpdate();
            }

            // Clear cart
            PreparedStatement clear = con.prepareStatement(
                "DELETE FROM cart WHERE user_id=?"
            );
            clear.setInt(1, user_id);
            clear.executeUpdate();

            // Redirect to success page
            response.sendRedirect("orders.jsp");

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}