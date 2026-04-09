
package SmartElectronics;

import java.io.IOException;
//import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;


public class UpdateCartServlet extends HttpServlet {

  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
    }

   
    
    @Override
    protected void doPost(HttpServletRequest rq, HttpServletResponse rp)
            throws ServletException, IOException {
        System.out.println("Servlet called");

String pid = rq.getParameter("product_id");
String act = rq.getParameter("action");

System.out.println("Product ID: " + pid);
System.out.println("Action: " + act);
        System.out.println("UpdateCartServlet called");
        int product_id = Integer.parseInt(rq.getParameter("product_id"));
        String action = rq.getParameter("action");

        HttpSession session = rq.getSession(false);
        if(session == null || session.getAttribute("user_id") == null){
           rp.sendRedirect("login.html");
           return;
}
        int user_id = (int) session.getAttribute("user_id");
        
        try {
            Connection con = DBConnection.getConnection();

            if(action.equals("inc")){
                PreparedStatement ps = con.prepareStatement(
                    "UPDATE cart SET quantity = quantity + 1 WHERE user_id=? AND product_id=? LIMIT 1"
                );
                ps.setInt(1, user_id);
                ps.setInt(2, product_id);
                //ps.executeUpdate();
                int rows = ps.executeUpdate();
                System.out.println("INC Rows affected: " + rows);
                
                System.out.println("User ID: " + user_id);
                System.out.println("Product ID: " + product_id);
                System.out.println("Action: " + action);
            }

            if(action.equals("dec")){
                PreparedStatement ps = con.prepareStatement(
                    "UPDATE cart SET quantity = quantity - 1 WHERE user_id=? AND product_id=? AND quantity > 1"
                );
                ps.setInt(1, user_id);
                ps.setInt(2, product_id);
                //ps.executeUpdate();
                int rows = ps.executeUpdate();
                System.out.println("Rows affected: " + rows);
            }
            
            if(action.equals("remove")){
    PreparedStatement ps = con.prepareStatement(
        "DELETE FROM cart WHERE user_id=? AND product_id=?"
    );
    ps.setInt(1, user_id);
    ps.setInt(2, product_id);
    ps.executeUpdate();
}
            if(action.equals("clear")){
    PreparedStatement ps = con.prepareStatement(
        "DELETE FROM cart WHERE user_id=?"
    );
    ps.setInt(1, user_id);
    ps.executeUpdate();
}

            rp.sendRedirect("cart.jsp");

        } catch(Exception e){
            e.printStackTrace();
        }
        System.out.println("Session user_id: " + session.getAttribute("user_id"));
    }
    }

    


