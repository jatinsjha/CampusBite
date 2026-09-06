<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                session.setAttribute("userId", rs.getInt("id"));
                session.setAttribute("userName", rs.getString("name"));
                session.setAttribute("userEmail", rs.getString("email"));
                session.setAttribute("userRole", rs.getString("role"));

                if ("admin".equals(rs.getString("role"))) {
                    response.sendRedirect("admin.jsp");
                } else {
                    response.sendRedirect("menu.jsp");
                }

                rs.close();
                ps.close();
                con.close();
                return;

            } else {

                message = "Invalid email or password.";

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            message = "Something went wrong. Please try again.";
            e.printStackTrace();

        }
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Login - Campus Bites</title>

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


<div class="form-page">

    <div class="form-box">

        <h1>Welcome Back 👋</h1>

        <p class="form-subtitle">
            Login to order your favourite food.
        </p>


        <% if (!message.isEmpty()) { %>

            <p style="color: #dc2626; text-align: center; margin-bottom: 20px;">
                <%= message %>
            </p>

        <% } %>


        <form action="login.jsp" method="post">

            <label>Email</label>

            <input type="email"
                   name="email"
                   placeholder="Enter your email"
                   required>


            <label>Password</label>

            <input type="password"
                   name="password"
                   placeholder="Enter your password"
                   required>


            <button type="submit" class="btn form-btn">
                Login
            </button>

        </form>


        <p class="form-footer">

            Don't have an account?

            <a href="register.jsp">
                Create Account
            </a>

        </p>

    </div>

</div>

</body>
</html>