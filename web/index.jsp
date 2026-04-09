<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    String user = (String) session.getAttribute("user");
    Boolean isAdmin = (Boolean) session.getAttribute("admin");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Smart Electronics - Home</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>

<!-- Header -->
<jsp:include page="header.jsp" />

<!-- Hero Section -->
<section class="hero">
    <div class="hero-content">
        <h1>Welcome to Smart Electronics</h1>
        <p>Your one-stop electronics store for phones, PCs, headphones, and more!</p>
        <a href="products.jsp" class="btn-hero">Shop Now</a>
    </div>
</section>

<!-- Features Section -->
<section class="features">
    <div class="feature-card">
        <h3>Fast Delivery</h3>
        <p>Get your products delivered on time.</p>
    </div>
    <div class="feature-card">
        <h3>Quality Products</h3>
        <p>All electronics are tested and reliable.</p>
    </div>
    <div class="feature-card">
        <h3>Secure Payment</h3>
        <p>100% safe and secure payment options.</p>
    </div>
</section>

<!-- Footer -->
<jsp:include page="footer.jsp" />

</body>
</html>