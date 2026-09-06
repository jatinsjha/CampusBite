<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String userName = (String) session.getAttribute("userName");
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Menu - Campus Bites</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        .menu-page {
            min-height: calc(100vh - 70px);
            padding: 50px 8%;
            background: #f8f9fa;
        }

        .menu-header {
            text-align: center;
            margin-bottom: 45px;
        }

        .menu-header h1 {
            font-size: 42px;
            color: #111827;
            margin-bottom: 10px;
        }

        .menu-header p {
            color: #666;
            font-size: 17px;
        }

        .welcome {
            text-align: center;
            margin-top: -25px;
            margin-bottom: 30px;
            color: #d97706;
            font-weight: bold;
        }

        .food-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 28px;
            max-width: 1150px;
            margin: auto;
        }

        .food-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: 0.3s;
        }

        .food-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.13);
        }

        .food-image {
            width: 100%;
            height: 210px;
            overflow: hidden;
            background: #fff7ed;
        }

        .food-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            transition: 0.3s;
        }

        .food-card:hover .food-image img {
            transform: scale(1.05);
        }

        .food-info {
            padding: 22px;
        }

        .category {
            display: inline-block;
            background: #fff7ed;
            color: #d97706;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .food-info h2 {
            margin: 12px 0 8px;
            color: #111827;
            font-size: 22px;
        }

        .food-info p {
            color: #666;
            font-size: 14px;
            line-height: 1.5;
            min-height: 42px;
            margin-bottom: 18px;
        }

        .food-bottom {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .price {
            font-size: 22px;
            font-weight: bold;
            color: #111827;
        }

        .cart-form {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .quantity {
            width: 55px;
            padding: 9px 5px;
            border: 1px solid #ddd;
            border-radius: 7px;
            text-align: center;
        }

        .add-btn {
            border: none;
            background: #f59e0b;
            color: white;
            padding: 10px 15px;
            border-radius: 7px;
            font-weight: bold;
            cursor: pointer;
        }

        .add-btn:hover {
            background: #d97706;
        }

        .no-food {
            text-align: center;
            color: #666;
            font-size: 18px;
            grid-column: 1 / -1;
            padding: 50px;
        }

        @media (max-width: 600px) {

            .navbar {
                padding: 0 20px;
            }

            .nav-links a {
                margin-left: 10px;
            }

            .menu-page {
                padding: 35px 20px;
            }

            .menu-header h1 {
                font-size: 32px;
            }

        }

    </style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

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


<!-- ================= MENU ================= -->

<section class="menu-page">


    <div class="menu-header">

        <h1>
            Today's Menu 🍴
        </h1>

        <p>
            Fresh food. Easy ordering. No waiting in line.
        </p>

    </div>


    <% if (userName != null) { %>

        <div class="welcome">

            Welcome, <%= userName %>! 👋

        </div>

    <% } %>


    <div class="food-grid">


        <%

            String sql =
                "SELECT * FROM foods WHERE available = TRUE";

            try {

                Connection con =
                    DBConnection.getConnection();

                PreparedStatement ps =
                    con.prepareStatement(sql);

                ResultSet rs =
                    ps.executeQuery();


                boolean hasFood = false;


                while (rs.next()) {

                    hasFood = true;

                    int foodId =
                        rs.getInt("id");

                    String foodName =
                        rs.getString("name");

                    String description =
                        rs.getString("description");

                    double price =
                        rs.getDouble("price");

                    String category =
                        rs.getString("category");


                    String imageName =
                        "default.jpg";


                    if (foodName.equalsIgnoreCase("Veg Sandwich")) {

                        imageName = "sandwich.jpg";

                    }

                    else if (foodName.equalsIgnoreCase("Veg Burger")) {

                        imageName = "burger.jpg";

                    }

                    else if (foodName.equalsIgnoreCase("Masala Maggi")) {

                        imageName = "maggi.jpg";

                    }

                    else if (foodName.equalsIgnoreCase("Samosa")) {

                        imageName = "samosa.jpg";

                    }

                    else if (foodName.equalsIgnoreCase("Cold Coffee")) {

                        imageName = "coldcoffee.jpg";

                    }

                    else if (foodName.equalsIgnoreCase("Tea")) {

                        imageName = "tea.jpg";

                    }

        %>


        <!-- ================= FOOD CARD ================= -->

        <div class="food-card">


            <div class="food-image">

                <img src="<%= request.getContextPath() %>/images/<%= imageName %>"
                     alt="<%= foodName %>">

            </div>


            <div class="food-info">


                <span class="category">

                    <%= category %>

                </span>


                <h2>

                    <%= foodName %>

                </h2>


                <p>

                    <%= description %>

                </p>


                <div class="food-bottom">


                    <span class="price">

                        ₹<%= String.format("%.2f", price) %>

                    </span>


                    <form action="cart.jsp"
                          method="post"
                          class="cart-form">


                        <input type="hidden"
                               name="foodId"
                               value="<%= foodId %>">


                        <input type="number"
                               name="quantity"
                               value="1"
                               min="1"
                               max="10"
                               class="quantity">


                        <button type="submit"
                                class="add-btn">

                            Add

                        </button>


                    </form>


                </div>


            </div>


        </div>


        <%

                }


                if (!hasFood) {

        %>

            <div class="no-food">

                🍽️ No food items available right now.

            </div>

        <%

                }


                rs.close();

                ps.close();

                con.close();


            } catch (Exception e) {

        %>

            <div class="no-food">

                Unable to load menu.

            </div>

        <%

                e.printStackTrace();

            }

        %>


    </div>


</section>


</body>
</html>