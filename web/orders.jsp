<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Integer userId = (Integer) session.getAttribute("userId");

    String message = "";

    /*
     * PLACE ORDER
     */
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        if (userId == null) {

            message = "Please login before placing an order.";

        } else {

            List<Integer> cart =
                (List<Integer>) session.getAttribute("cart");

            if (cart == null || cart.isEmpty()) {

                message = "Your cart is empty.";

            } else {

                Connection con = null;

                try {

                    con = DBConnection.getConnection();

                    double total = 0;

                    /*
                     * Calculate total
                     */
                    for (Integer foodId : cart) {

                        String foodSQL =
                            "SELECT price FROM foods WHERE id = ?";

                        PreparedStatement foodPS =
                            con.prepareStatement(foodSQL);

                        foodPS.setInt(1, foodId);

                        ResultSet foodRS =
                            foodPS.executeQuery();

                        if (foodRS.next()) {
                            total += foodRS.getDouble("price");
                        }

                        foodRS.close();
                        foodPS.close();
                    }


                    /*
                     * Insert order
                     */
                    String orderSQL =
                        "INSERT INTO orders " +
                        "(user_id, total_amount, status) " +
                        "VALUES (?, ?, 'Pending')";

                    PreparedStatement orderPS =
                        con.prepareStatement(orderSQL);

                    orderPS.setInt(1, userId);
                    orderPS.setDouble(2, total);

                    int result =
                        orderPS.executeUpdate();

                    orderPS.close();


                    if (result > 0) {

                        // Clear cart after successful order
                        session.removeAttribute("cart");

                        message =
                            "Order placed successfully! 🎉";

                    }

                    con.close();

                } catch (Exception e) {

                    message =
                        "Unable to place order.";

                    e.printStackTrace();

                    if (con != null) {
                        try {
                            con.close();
                        } catch (Exception ex) {
                        }
                    }
                }
            }
        }
    }
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>My Orders - Campus Bites</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">


    <style>

        .orders-page {
            min-height: calc(100vh - 70px);
            padding: 50px 8%;
            background: #f8f9fa;
        }

        .orders-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .orders-header h1 {
            font-size: 40px;
            color: #111827;
            margin-bottom: 10px;
        }

        .orders-header p {
            color: #666;
        }

        .message {
            max-width: 800px;
            margin: 0 auto 25px;
            padding: 15px;
            background: #ecfdf5;
            color: #047857;
            border-radius: 8px;
            text-align: center;
            font-weight: bold;
        }

        .orders-container {
            max-width: 900px;
            margin: auto;
        }

        .order-card {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.07);
        }

        .order-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .order-id {
            font-size: 20px;
            font-weight: bold;
            color: #111827;
        }

        .status {
            background: #fff7ed;
            color: #d97706;
            padding: 7px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .order-details {
            display: flex;
            justify-content: space-between;
            color: #666;
            border-top: 1px solid #eee;
            padding-top: 15px;
        }

        .order-total {
            font-size: 20px;
            font-weight: bold;
            color: #111827;
        }

        .no-orders {
            background: white;
            text-align: center;
            padding: 50px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.07);
        }

        .no-orders h2 {
            margin-bottom: 15px;
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


<!-- ORDERS -->

<section class="orders-page">


    <div class="orders-header">

        <h1>
            My Orders 📦
        </h1>

        <p>
            View your previous orders and their status.
        </p>

    </div>


    <% if (!message.isEmpty()) { %>

        <div class="message">

            <%= message %>

        </div>

    <% } %>


    <div class="orders-container">


        <%

        if (userId == null) {

        %>

            <div class="no-orders">

                <h2>
                    Please Login
                </h2>

                <p>
                    You need to login to view your orders.
                </p>

                <br>

                <a href="login.jsp" class="btn">
                    Login
                </a>

            </div>

        <%

        } else {

            String sql =
                "SELECT * FROM orders " +
                "WHERE user_id = ? " +
                "ORDER BY order_date DESC";

            try {

                Connection con =
                    DBConnection.getConnection();

                PreparedStatement ps =
                    con.prepareStatement(sql);

                ps.setInt(1, userId);

                ResultSet rs =
                    ps.executeQuery();


                boolean hasOrders = false;


                while (rs.next()) {

                    hasOrders = true;

        %>


        <div class="order-card">


            <div class="order-top">

                <div class="order-id">

                    Order #<%= rs.getInt("id") %>

                </div>


                <div class="status">

                    <%= rs.getString("status") %>

                </div>

            </div>


            <div class="order-details">

                <div>

                    Date:

                    <%= rs.getTimestamp("order_date") %>

                </div>


                <div class="order-total">

                    ₹<%= String.format(
                        "%.2f",
                        rs.getDouble("total_amount")
                    ) %>

                </div>

            </div>


        </div>


        <%

                }


                if (!hasOrders) {

        %>


            <div class="no-orders">

                <h2>
                    No Orders Yet 📦
                </h2>

                <p>
                    You haven't placed any orders yet.
                </p>

                <br>

                <a href="menu.jsp" class="btn">
                    Browse Menu
                </a>

            </div>


        <%

                }


                rs.close();
                ps.close();
                con.close();


            } catch (Exception e) {

        %>

            <div class="no-orders">

                <h2>
                    Unable to load orders
                </h2>

            </div>

        <%

                e.printStackTrace();

            }

        }

        %>


    </div>


</section>


</body>

</html>