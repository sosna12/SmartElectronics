<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String user = (String) session.getAttribute("user");
    Boolean isAdmin = (Boolean) session.getAttribute("admin");
%>

<header class="site-header">
    <div class="logo">Smart Electronics E-Commerce Website</div>
    <!-- 🔍 Search Bar -->
    <form action="SearchServlet" method="get" class="search-form">
        <input type="text" name="query" placeholder="Search products..." required>
        <button type="submit">🔍</button>
    </form>


    <nav class="nav-links">
        <a href="index.jsp" class="nav-btn">Home</a>
        <a href="products.jsp" class="nav-btn">Products</a>
        <a href="cart.jsp" class="nav-btn">Cart</a>

        <% if(user == null){ %>
            <a href="login.html" class="nav-btn">Login</a>
            <a href="register.html" class="nav-btn">Register</a>
        <% } else { %>
            <a href="orders.jsp" class="nav-btn">My Orders</a>
            <% String role = (String) session.getAttribute("role");
               if(role != null && role.equals("admin")){ %>
               <a href="admin_products.jsp" class="nav-btn">Admin Panel</a>
            <% } %>
            <span class="welcome-msg">Welcome, <%= user %></span>
            <a href="LogoutServlet" class="nav-btn">Logout</a>
        <% } %>

        <% if(isAdmin != null && isAdmin){ %>
            <a href="admin.jsp" class="nav-btn">Admin</a>
        <% } %>
    </nav>
    
</header>
