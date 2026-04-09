<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Cart - Smart Electronics</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>

<jsp:include page="header.jsp" />
<%
if(session.getAttribute("role") == null || !session.getAttribute("role").equals("admin")){
    out.println("<h3 style='color:red; text-align:center;'>Access Denied!</h3>");
    return;
}

Connection con = SmartElectronics.DBConnection.getConnection();

// JOIN orders + products + users
PreparedStatement ps = con.prepareStatement(
    "SELECT o.*, p.name AS product_name, u.name AS user_name " +
    "FROM orders o " +
    "JOIN products p ON o.product_id = p.id " +
    "JOIN users u ON o.user_id = u.id " +
    "ORDER BY o.order_date DESC"
);
ResultSet rs = ps.executeQuery();
%>

<section class="admin-section">
    <h2 class="section-title">Admin - All Orders</h2>

    <div class="admin-table-container">
        <table class="admin-table">
            <thead>
                <tr>
                    <th>User</th>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Total Price (ETB)</th>
                    <th>Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                while(rs.next()){
                %>
                <tr>
                    <td><%= rs.getString("user_name") %></td>
                    <td><%= rs.getString("product_name") %></td>
                    <td><%= rs.getInt("quantity") %></td>
                    <td><%= rs.getDouble("total_price") %></td>
                    <td><%= rs.getString("order_date") %></td>
                    <td>
                        <form action="DeleteOrderServlet" method="post" class="inline-form">
                            <input type="hidden" name="order_id" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="btn-delete" onclick="return confirm('Are you sure?');">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
</section>

<jsp:include page="footer.jsp" />
</body>
</html>