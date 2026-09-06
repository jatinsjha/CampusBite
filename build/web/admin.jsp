<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String role = (String) session.getAttribute("userRole");
    String userName = (String) session.getAttribute("userName");

    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Admin Dashboard - Campus Bites</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        .admin-page {
            min-height: calc(100vh - 70px);
            padding: 50px 8%;
            background: #f8f9fa;
        }

        .admin-header {
            text-align: center;
            margin-bottom: 45px;
        }

        .admin-header h1 {
            font-size: 40px;
            color: #111827;
            margin-bottom: 10px;
        }

        .admin-header p {
            color: #666;
        }

        .admin-grid {
            max-width: 1000px;
            margin: auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
        }

        .admin-card {
            background: white;
            padding: 35px 25px;
            text-align: center;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: 0.3s;
        }

        .admin-card:hover {
            transform: translateY(-5px);
        }

        .admin-icon {
            font-size: 50px;
            margin-bottom: 15px;
        }

        .admin-card h2 {
            color: #111827;
            margin-bottom: 10px;
        }

        .admin-card p {
            color: #666;
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .admin-btn {
            display: inline-block;
            padding: 11px 20px;
            background: #f59e0b;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .admin-btn:hover {
            background: #d97706;
        }

        .logout-btn {
            display: block;
            width: 150px;
            margin: 40px auto 0;
            text-align: center;
            padding: 12px;
            background: #111827;
            color: white;
            text-decoration: none;
            border-radius: 7px;
        }

    </style>

</head>


<body>


<nav class="navbar">

    <div class="logo">
        🍔 Campus Bites
    </div>

    <div class="nav-links">

        <a href="index.jsp">Home</a>

        <a href="menu.jsp">Menu</a>

        <a href="admin.jsp">Dashboard</a>

    </div>

</nav>


<section class="admin-page">


    <div class="admin-header">

        <h1>
            Admin Dashboard ⚙️
        </h1>

        <p>
            Welcome, <%= userName %>!
            Manage your canteen from here.
        </p>

    </div>


    <div class="admin-grid">


        <div class="admin-card">

            <div class="admin-icon">
                🍔
            </div>

            <h2>
                Manage Food
            </h2>

            <p>
                Add, view and manage food
                items available in the canteen.
            </p>

            <a href="menu.jsp" class="admin-btn">
                View Menu
            </a>

        </div>


        <div class="admin-card">

            <div class="admin-icon">
                📦
            </div>

            <h2>
                Orders
            </h2>

            <p>
                View customer orders and
                manage their status.
            </p>

            <a href="orders.jsp" class="admin-btn">
                View Orders
            </a>

        </div>


        <div class="admin-card">

            <div class="admin-icon">
                👨‍🎓
            </div>

            <h2>
                Students
            </h2>

            <p>
                Students can register and
                place food orders through the system.
            </p>

            <a href="register.jsp" class="admin-btn">
                Registration
            </a>

        </div>


    </div>


    <a href="login.jsp"
       class="logout-btn">

        Logout

    </a>


</section>


</body>

</html>