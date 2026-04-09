package SmartElectronics;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class AdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Boolean isAdmin = (Boolean) session.getAttribute("admin");
        if(isAdmin == null || !isAdmin){
            response.sendRedirect("login.html");
            return;
        }

        String action = request.getParameter("action");

        try {
            Connection con = DBConnection.getConnection();

            if("Add Product".equals(action)){
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                String image = request.getParameter("image");

                PreparedStatement ps = con.prepareStatement("INSERT INTO products(name, price, image) VALUES(?,?,?)");
                ps.setString(1, name);
                ps.setDouble(2, price);
                ps.setString(3, image);
                ps.executeUpdate();
            }

            if("Remove Product".equals(action)){
                int product_id = Integer.parseInt(request.getParameter("product_id"));
                PreparedStatement ps = con.prepareStatement("DELETE FROM products WHERE id=?");
                ps.setInt(1, product_id);
                ps.executeUpdate();
            }

            response.sendRedirect("admin.jsp");

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}