<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="container mt-5">

<div class="row">

<!-- 🛒 LEFT: PRODUCT SUMMARY -->
<div class="col-md-6">
    <div class="card shadow p-3">
        <h4><i class="fas fa-shopping-cart"></i> Order Summary</h4>
        <hr>

<%
int user_id = (int) session.getAttribute("user_id");
Connection con = SmartElectronics.DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
    "SELECT c.quantity, p.name, p.price FROM cart c JOIN products p ON c.product_id=p.id WHERE c.user_id=?"
);
ps.setInt(1, user_id);

ResultSet rs = ps.executeQuery();

double total = 0;

while(rs.next()){
    String name = rs.getString("name");
    int qty = rs.getInt("quantity");
    double price = rs.getDouble("price");
    double sub = qty * price;
    total += sub;
%>

<div class="d-flex justify-content-between">
    <span><%= name %> (x<%= qty %>)</span>
    <span>$<%= sub %></span>
</div>

<%
}
%>

<hr>
<h5>Total: $<%= total %></h5>

    </div>
</div>

<!-- 💳 RIGHT: PAYMENT -->
<div class="col-md-6">
    <div class="card shadow p-4 checkout-box">

        <h4 class="text-center mb-3">Checkout</h4>

        <form action="PaymentServlet" method="post">

        <!-- Payment Options -->
        <div class="form-check">
            <input class="form-check-input" type="radio" name="payment" value="COD" checked onclick="showPaymentFields()">
            <label class="form-check-label">
                🚚 Cash on Delivery
            </label>
        </div>

        <div class="form-check">
            <input class="form-check-input" type="radio" name="payment" value="CARD" onclick="showPaymentFields()">
            <label class="form-check-label">
                💳 Card Payment
            </label>
        </div>

        <div class="form-check">
            <input class="form-check-input" type="radio" name="payment" value="TELEBIRR" onclick="showPaymentFields()">
            <label class="form-check-label">
                📱 Telebirr
            </label>
        </div>

        <!-- CARD -->
        <div id="cardDiv" class="mt-3 hidden">
            <input type="text" name="card" class="form-control mb-2" placeholder="Card Number">
            <input type="text" name="expiry" class="form-control mb-2" placeholder="MM/YY">
            <input type="text" name="cvv" class="form-control" placeholder="CVV">
        </div>

        <!-- TELEBIRR -->
        <div id="telebirrDiv" class="mt-3 hidden">
            <input type="text" name="phone" class="form-control" placeholder="09XXXXXXXX">
        </div>

        <button type="submit" class="btn btn-success mt-4 w-100">
            Pay & Place Order
        </button>

        </form>

    </div>
</div>

</div>
</div>

<script>
function showPaymentFields(){
    let method = document.querySelector('input[name="payment"]:checked').value;

    document.getElementById("cardDiv").classList.toggle("hidden", method !== "CARD");
    document.getElementById("telebirrDiv").classList.toggle("hidden", method !== "TELEBIRR");
}
</script>

</body>
</html>

<jsp:include page="footer.jsp" />