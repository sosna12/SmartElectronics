package SmartElectronics;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class SearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM products WHERE name LIKE ? OR category LIKE ?"
            );

            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");

            ResultSet rs = ps.executeQuery();

            request.setAttribute("results", rs);
            request.getRequestDispatcher("search.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}