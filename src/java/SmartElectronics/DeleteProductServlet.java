package SmartElectronics;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if(session == null || !"admin".equals(session.getAttribute("role"))){
            response.sendRedirect("login.html");
            return;
        }

        int product_id = Integer.parseInt(request.getParameter("product_id"));

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM products WHERE id=?");
            ps.setInt(1, product_id);
            ps.executeUpdate();

            response.sendRedirect("admin-products.jsp");

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}