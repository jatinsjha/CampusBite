# 🍔 CampusBite – College Canteen Pre-Order System

A web-based college canteen pre-ordering system that allows students to browse food items, add items to a cart, place orders, and track their previous orders.

## 📌 Project Overview

CampusBite is designed to make the college canteen ordering process faster and more convenient for students.

Instead of waiting in a queue, students can:

- Create an account
- Log in securely
- Browse available food items
- View food images, descriptions and prices
- Add food items to their cart
- Place an order
- View their previous orders

The system uses JSP and JDBC to communicate with a MySQL database and Apache Tomcat as the web server.

---

## ✨ Features

### 👨‍🎓 Student

- Student registration
- User login and authentication
- Session management
- Dynamic food menu
- Food categories
- Food images
- Add to cart
- Cart quantity management
- Automatic order total calculation
- Place orders
- View previous orders

### 👨‍💼 Admin

- Admin login
- Admin dashboard
- Admin role-based access

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Java | Backend programming |
| JSP | Dynamic web pages |
| JDBC | Database connectivity |
| MySQL | Database |
| Apache Tomcat | Web server |
| HTML | Page structure |
| CSS | User interface and styling |
| NetBeans | Development environment |

---

## 🏗️ Project Structure

```text
CampusBite/
│
├── database/
│   └── database.sql
│
├── screenshots/
│
├── Web Pages/
│   ├── css/
│   ├── images/
│   ├── index.jsp
│   ├── login.jsp
│   ├── register.jsp
│   ├── menu.jsp
│   ├── cart.jsp
│   ├── orders.jsp
│   └── admin.jsp
│
├── Source Packages/
│   └── util/
│       └── DBConnection.java
│
├── README.md
├── LICENSE
└── .gitignore
