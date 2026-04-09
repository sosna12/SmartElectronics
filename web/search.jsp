<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>

<jsp:include page="header.jsp" />

<h2 class="section-title">Search Results</h2>

<div class="products-container">
<%
ResultSet rs = (ResultSet) request.getAttribute("results");

if(rs != null){
    boolean found = false;

    while(rs.next()){
        found = true;
%>

<div class="product-card">
    <img src="<%= rs.getString("image") %>" width="150">
    <h3><%= rs.getString("name") %></h3>
    <p><%= rs.getString("category") %></p>
    <p class="price"><%= rs.getDouble("price") %> ETB</p>
</div>

<%
    }

    if(!found){
%>
<p>No products found.</p>
<%
    }
}
%>
</div>

<jsp:include page="footer.jsp" />

</body>
</html>