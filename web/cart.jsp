<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Get the current cart from session
    List<Integer> cart =
            (List<Integer>) session.getAttribute("cart");

    if (cart == null) {
        cart = new ArrayList<Integer>();
        session.setAttribute("cart", cart);
    }


    // Add item to cart
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String foodId = request.getParameter("foodId");

        if (foodId != null) {

            int id = Integer.parseInt(foodId);

            String quantityText =
                    request.getParameter("quantity");

            int quantity = 1;

            if (quantityText != null) {
                quantity = Integer.parseInt(quantityText);
            }

            for (int i = 0; i < quantity; i++) {
                cart.add(id);
            }

            session.setAttribute("cart", cart);
        }

        response.sendRedirect("cart.jsp");
        return;
    }


    double total = 0;
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Cart - Campus Bites</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">


    <style>

        .cart-page {
            min-height: calc(100vh - 70px);
            padding: 50px 8%;
            background: #f8f9fa;
        }

        .cart-title {
            text-align: center;
            margin-bottom: 40px;
        }

        .cart-title h1 {
            font-size: 40px;
            color: #111827;
            margin-bottom: 10px;
        }

        .cart-title p {
            color: #666;
        }

        .cart-container {
            max-width: 900px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .cart-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 18px 0;
            border-bottom: 1px solid #eee;
        }

        .item-name {
            font-size: 18px;
            font-weight: bold;
            color: #111827;
        }

        .item-price {
            color: #666;
            margin-top: 5px;
            font-size: 14px;
        }

        .item-total {
            font-weight: bold;
            font-size: 17px;
        }

        .cart-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 2px solid #eee;
        }

        .cart-total h2 {
            color: #111827;
        }

        .total-price {
            font-size: 25px;
            font-weight: bold;
            color: #d97706;
        }

        .cart-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .continue-btn {
            padding: 12px 20px;
            border: 1px solid #f59e0b;
            color: #d97706;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .checkout-btn {
            padding: 12px 22px;
            border: none;
            background: #f59e0b;
            color: white;
            border-radius: 7px;
            font-weight: bold;
            cursor: pointer;
        }

        .checkout-btn:hover {
            background: #d97706;
        }

        .empty-cart {
            text-align: center;
            padding: 50px;
            color: #666;
        }

        .empty-cart h2 {
            margin-bottom: 15px;
            color: #111827;
        }

    </style>

</head>


<body>


<!-- NAVBAR -->

<nav class="navbar">

    <div class="logo">
        🍔 Campus Bites
    </div>

    <div class="nav-links">

        <a href="index.jsp">Home</a>

        <a href="menu.jsp">Menu</a>

        <a href="cart.jsp">Cart 🛒</a>

        <a href="orders.jsp">My Orders</a>

        <a href="login.jsp">Logout</a>

    </div>

</nav>


<!-- CART -->

<section class="cart-page">


    <div class="cart-title">

        <h1>Your Cart 🛒</h1>

        <p>
            Review your items before placing your order.
        </p>

    </div>


    <div class="cart-container">


        <%
            if (cart.isEmpty()) {
        %>


            <div class="empty-cart">

                <h2>
                    Your cart is empty 🛒
                </h2>

                <p>
                    Add some delicious food from the menu!
                </p>

                <br>

                <a href="menu.jsp" class="btn">
                    Browse Menu
                </a>

            </div>


        <%
            } else {

                Connection con =
                    DBConnection.getConnection();

                for (Integer id : cart) {

                    String sql =
                        "SELECT * FROM foods WHERE id = ?";

                    PreparedStatement ps =
                        con.prepareStatement(sql);

                    ps.setInt(1, id);

                    ResultSet rs =
                        ps.executeQuery();


                    if (rs.next()) {

                        String name =
                            rs.getString("name");

                        double price =
                            rs.getDouble("price");

                        total += price;
        %>


            <div class="cart-item">

                <div>

                    <div class="item-name">

                        <%= name %>

                    </div>

                    <div class="item-price">

                        ₹<%= String.format("%.2f", price) %>

                    </div>

                </div>


                <div class="item-total">

                    ₹<%= String.format("%.2f", price) %>

                </div>

            </div>


        <%
                    }

                    rs.close();
                    ps.close();
                }

                con.close();
        %>


            <div class="cart-total">

                <h2>
                    Total
                </h2>

                <span class="total-price">

                    ₹<%= String.format("%.2f", total) %>

                </span>

            </div>


            <div class="cart-buttons">

                <a href="menu.jsp"
                   class="continue-btn">

                    ← Continue Shopping

                </a>


                <form action="orders.jsp"
                      method="post">

                    <input type="hidden"
                           name="total"
                           value="<%= total %>">

                    <button type="submit"
                            class="checkout-btn">

                        Place Order

                    </button>

                </form>

            </div>


        <%
            }
        %>


    </div>


</section>


</body>

</html>