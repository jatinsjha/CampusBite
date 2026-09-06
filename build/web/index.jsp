<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Campus Bites</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

<nav class="navbar">

    <div class="logo">
        🍔 Campus Bites
    </div>

    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="menu.jsp">Menu</a>
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
    </div>

</nav>


<section class="hero">

    <div class="hero-content">

        <h1>
            Your Campus Food,
            <span>One Click Away.</span>
        </h1>

        <p>
            Skip the queue. Choose your favourite food,
            place your order online and enjoy a quick
            and convenient campus dining experience.
        </p>

        <a href="menu.jsp" class="btn">
            Browse Menu
        </a>


        <div class="features">

            <div class="feature">
                <h3>🍕 Easy Ordering</h3>
                <p>
                    Order your favourite food
                    from anywhere on campus.
                </p>
            </div>

            <div class="feature">
                <h3>⚡ Save Time</h3>
                <p>
                    Avoid long queues and
                    waiting at the counter.
                </p>
            </div>

            <div class="feature">
                <h3>📦 Track Orders</h3>
                <p>
                    Check your previous orders
                    and their status.
                </p>
            </div>

        </div>

    </div>

</section>

</body>
</html>