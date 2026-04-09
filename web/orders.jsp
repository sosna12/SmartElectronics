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
if(session.getAttribute("user_id") == null){
    response.sendRedirect("login.html");
    return;
}

int user_id = (int) session.getAttribute("user_id");
Connection con = SmartElectronics.DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
    "SELECT o.*, p.name, p.price " +
    "FROM orders o JOIN products p ON o.product_id = p.id " +
    "WHERE o.user_id=? ORDER BY o.order_date DESC"
);
ps.setInt(1, user_id);
ResultSet rs = ps.executeQuery();
%>

<section class="orders-section">
    <h2 class="section-title">My Orders</h2>

    <div class="orders-grid">
        <%
        boolean hasOrders = false;

        while(rs.next()){
            hasOrders = true;

            String pname = rs.getString("name");
            int qty = rs.getInt("quantity");
            double price = rs.getDouble("price");
            double total = rs.getDouble("total_price");
            String date = rs.getString("order_date");
        %>
        <div class="order-card">
            <h3><%= pname %></h3>
            <p><strong>Quantity:</strong> <%= qty %></p>
            <p><strong>Price:</strong> <%= price %> ETB</p>
            <p><strong>Total:</strong> <%= total %> ETB</p>
            <p><strong>Date:</strong> <%= date %></p>
        </div>
        <%
        }

        if(!hasOrders){
        %>
        <p class="no-orders">You have no orders yet.</p>
        <%
        }
        %>
    </div>
</section>

<jsp:include page="footer.jsp" />
</body>
</html>