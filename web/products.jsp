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
%>

<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<section class="products-section">
    <h2 class="section-title">Our Products</h2>
    <div class="products-grid">
    <%
        Connection con = SmartElectronics.DBConnection.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM products");

        while(rs.next()){
    %>
        <div class="product-card">
            <img src="<%= rs.getString("image") %>" alt="<%= rs.getString("name") %>">
            <h3><%= rs.getString("name") %></h3>
            <p class="category"><%= rs.getString("category") %></p>
            <p class="price"><%= rs.getDouble("price") %> ETB</p>
            <p class="desc"><%= rs.getString("description") %></p>
            <form action="AddToCartServlet" method="post">
                <input type="hidden" name="product_id" value="<%= rs.getInt("id") %>">
                <div class="quantity">
                    <label>Qty:</label>
                    <input type="number" name="quantity" value="1" min="1">
                </div>
                <button type="submit" class="btn-add">Add to Cart</button>
            </form>
        </div>
    <%
        }
    %>
    </div>
</section>

<jsp:include page="footer.jsp" />
</body>
</html>