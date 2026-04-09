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
<section class="admin-section">
    <h2 class="section-title">Admin - Products Management</h2>

    <a href="add_products.jsp" class="btn-add-new">+ Add New Product</a>

    <div class="admin-table-container">
        <%
        Connection con = SmartElectronics.DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM products");
        ResultSet rs = ps.executeQuery();
        %>

        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price (ETB)</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                while(rs.next()){
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getDouble("price") %></td>
                    <td><img src="<%= rs.getString("image") %>" class="admin-product-img"></td>
                    <td>
                        <form action="DeleteProductServlet" method="post" class="inline-form">
                            <input type="hidden" name="product_id" value="<%= rs.getInt("id") %>">
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
