
package SmartElectronics;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.HttpSession;


public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
  
    }


    @Override
    protected void doPost(HttpServletRequest rq, HttpServletResponse rp)
            throws ServletException, IOException {
        rp.setContentType("text/html");
        PrintWriter out = rp.getWriter();
       
        String email = rq.getParameter("email");
        String password = rq.getParameter("password");
       
        try{
            
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement("select * from users where email=? and password=? ");
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
            HttpSession session = rq.getSession();
            session.setAttribute("user", rs.getString("name"));
            session.setAttribute("user_id", rs.getInt("id"));
            session.setAttribute("role", rs.getString("role"));

            if("admin".equals(rs.getString("role"))){
                  rp.sendRedirect("admin_products.jsp"); // redirect admin directly
              } else if("user".equals(rs.getString("role"))){
              rp.sendRedirect("products.jsp"); // normal user
              }
            }
            else{
            out.println("<h2>Invalid username or password!</h2>");
            }
            
        
        }catch(Exception e){
        e.printStackTrace();
        out.println(e);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
