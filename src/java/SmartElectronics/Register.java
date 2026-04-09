
package SmartElectronics;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

public class Register extends HttpServlet {

    protected void processRequest(HttpServletRequest rq, HttpServletResponse rp)
            throws ServletException, IOException {
    
   
    }



    @Override
    protected void doPost(HttpServletRequest rq, HttpServletResponse rp)
            throws ServletException, IOException {
        
        rp.setContentType("text/html");
        PrintWriter out = rp.getWriter();
        
        String name = rq.getParameter("name");
        String email = rq.getParameter("email");
        String password = rq.getParameter("password");
        
        try{
        Connection con = DBConnection.getConnection();
        PreparedStatement stmt = con.prepareStatement("insert into users(name,email,password) values(?,?,?)");
        stmt.setString(1,name);
        stmt.setString(2, email);
        stmt.setString(3, password);
        
        int row = stmt.executeUpdate();
        if(row>=0){
         // ✅ After successful registration, redirect to home page
            rp.sendRedirect("index.jsp?register=success");
        }else{
        out.println("You are not Registered. please try again!");
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
