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

    PreparedStatement ps2 = con.prepareStatement(
        "SELECT c.product_id, c.quantity, p.name, p.price " +
        "FROM cart c JOIN products p ON c.product_id = p.id " +
        "WHERE c.user_id=?"
    );
    ps2.setInt(1, user_id);
    ResultSet rs2 = ps2.executeQuery();

    double total = 0;
%>

<section class="cart-section">
    <h2 class="section-title">My Cart</h2>
    <div class="cart-table-container">
        <table class="cart-table">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Subtotal</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                while(rs2.next()){
                    String pname = rs2.getString("name");
                    int qty = rs2.getInt("quantity");
                    double price = rs2.getDouble("price");
                    double subtotal = qty * price;
                    total += subtotal;
                %>
                <tr>
                    <td><%= pname %></td>
                    <td><%= qty %></td>
                    <td><%= price %> ETB</td>
                    <td><%= subtotal %> ETB</td>
                    <td>
                        <form action="UpdateCartServlet" method="post" class="inline-form">
                            <input type="hidden" name="product_id" value="<%= rs2.getInt("product_id") %>">
                            <input type="hidden" name="action" value="inc">
                            <button type="submit" class="btn-qty">+</button>
                        </form>
                        <form action="UpdateCartServlet" method="post" class="inline-form">
                            <input type="hidden" name="product_id" value="<%= rs2.getInt("product_id") %>">
                            <input type="hidden" name="action" value="dec">
                            <button type="submit" class="btn-qty">-</button>
                        </form>
                        <form action="UpdateCartServlet" method="post" class="inline-form">
                            <input type="hidden" name="product_id" value="<%= rs2.getInt("product_id") %>">
                            <input type="hidden" name="action" value="remove">
                            <button type="submit" class="btn-remove">Remove</button>
                        </form>
                    </td>
                </tr>
                <%
                }
                %>
                <tr class="total-row">
                    <td colspan="3"><b>Total</b></td>
                    <td colspan="2"><b><%= total %> ETB</b></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="cart-actions">
        <form action="checkout.jsp" method="post">
            <button type="submit" class="btn-place-order">Payment</button>
        </form>
        <form action="UpdateCartServlet" method="post">
            <input type="hidden" name="action" value="clear">
            <button type="submit" class="btn-clear-cart">Clear Cart</button>
        </form>
    </div>
</section>

<jsp:include page="footer.jsp" />
</body>
</html>