<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, 'student')";

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);

            int result = ps.executeUpdate();

            ps.close();
            con.close();

            if (result > 0) {
                response.sendRedirect("login.jsp?registered=true");
                return;
            }

        } catch (SQLException e) {

            if (e.getMessage().contains("Duplicate")) {
                message = "Email already registered.";
            } else {
                message = "Registration failed. Please try again.";
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - Campus Bites</title>

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

        <h1>Create Account ✨</h1>

        <p class="form-subtitle">
            Join Campus Bites and start ordering.
        </p>

        <% if (!message.isEmpty()) { %>

            <p style="color: #dc2626; text-align: center; margin-bottom: 20px;">
                <%= message %>
            </p>

        <% } %>


        <form action="register.jsp" method="post">

            <label>Name</label>

            <input type="text"
                   name="name"
                   placeholder="Enter your name"
                   required>


            <label>Email</label>

            <input type="email"
                   name="email"
                   placeholder="Enter your email"
                   required>


            <label>Password</label>

            <input type="password"
                   name="password"
                   placeholder="Create a password"
                   required>


            <button type="submit" class="btn form-btn">
                Create Account
            </button>

        </form>


        <p class="form-footer">

            Already have an account?

            <a href="login.jsp">
                Login
            </a>

        </p>

    </div>

</div>

</body>
</html>