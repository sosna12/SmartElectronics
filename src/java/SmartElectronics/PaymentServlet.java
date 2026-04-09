package SmartElectronics;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class PaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        if(session == null || session.getAttribute("user_id") == null){
            response.sendRedirect("login.html");
            return;
        }

        int user_id = (int) session.getAttribute("user_id");
        String paymentMethod = request.getParameter("payment");

        // ✅ TELEBIRR VALIDATION
        if("TELEBIRR".equals(paymentMethod)){
            String phone = request.getParameter("phone");

            if(phone == null || !phone.matches("09\\d{8}")){
                response.getWriter().println("<h3 style='color:red;'>Invalid Phone Number!</h3>");
                return;
            }
        }

        // ✅ CARD VALIDATION
        if("CARD".equals(paymentMethod)){
            String card = request.getParameter("card");
            String expiry = request.getParameter("expiry");
            String cvv = request.getParameter("cvv");

            if(card == null || card.length() < 8 ||
               expiry == null || expiry.isEmpty() ||
               cvv == null || cvv.length() < 3){

               // response.getWriter().println("<h3 style='color:red;'>Invalid Card Details!</h3>");
                response.sendRedirect("checkout.jsp?error=invalid");
                return;
            }
        }

        try {
            Connection con = DBConnection.getConnection();

            // ✅ CHECK CART
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM cart WHERE user_id=?"
            );
            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();

            boolean hasItems = false;

            while(rs.next()){
                hasItems = true;

                int product_id = rs.getInt("product_id");
                int qty = rs.getInt("quantity");

                PreparedStatement ps2 = con.prepareStatement(
                    "SELECT price FROM products WHERE id=?"
                );
                ps2.setInt(1, product_id);
                ResultSet rs2 = ps2.executeQuery();

                double price = 0;
                if(rs2.next()){
                    price = rs2.getDouble("price");
                }

                double total = price * qty;

                PreparedStatement insert = con.prepareStatement(
                    "INSERT INTO orders(user_id, product_id, quantity, total_price, payment_method) VALUES(?,?,?,?,?)"
                );

                insert.setInt(1, user_id);
                insert.setInt(2, product_id);
                insert.setInt(3, qty);
                insert.setDouble(4, total);
                insert.setString(5, paymentMethod);

                insert.executeUpdate();
            }

            // ❌ If cart empty
            if(!hasItems){
                response.getWriter().println("<h3>Your cart is empty!</h3>");
                return;
            }

            // ✅ CLEAR CART
            PreparedStatement clear = con.prepareStatement(
                "DELETE FROM cart WHERE user_id=?"
            );
            clear.setInt(1, user_id);
            clear.executeUpdate();

            // ✅ SUCCESS REDIRECT
            response.sendRedirect("orders.jsp");

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}