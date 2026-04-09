<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Product - Smart Electronics</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>

<jsp:include page="header.jsp" />

<section class="admin-section">
    <h2 class="section-title">Add New Product</h2>

    <form action="AddProductServlet" method="post" enctype="multipart/form-data" class="product-form">

        <div class="form-group">
            <label for="name">Product Name:</label>
            <input type="text" name="name" id="name" placeholder="Enter product name" required>
        </div>

        <div class="form-group">
            <label for="category">Category:</label>
            <input type="text" name="category" id="category" placeholder="e.g., Laptops, Headphones" required>
        </div>

        <div class="form-group">
            <label for="price">Price (ETB):</label>
            <input type="number" name="price" id="price" placeholder="Enter price" min="0" step="0.01" required>
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <textarea name="description" id="description" rows="4" placeholder="Write a short description" required></textarea>
        </div>

        <div class="form-group">
            <label for="image">Product Image:</label>
            <input type="file" name="image" id="image" accept="image/*" required>
            <img id="preview" src="#" alt="Image Preview" style="display:none; margin-top:10px; max-width:200px; border-radius:8px;">
        </div>

        <button type="submit" class="btn-add-new">Add Product</button>
    </form>
</section>

<script>
// Image preview
document.getElementById("image").addEventListener("change", function(event){
    const preview = document.getElementById("preview");
    const file = event.target.files[0];
    if(file){
        preview.src = URL.createObjectURL(file);
        preview.style.display = "block";
    } else {
        preview.style.display = "none";
    }
});
</script>

<jsp:include page="footer.jsp" />
</body>
</html>