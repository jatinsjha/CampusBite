CREATE DATABASE college_canteen;

USE college_canteen;

-- Users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'student'
);

-- Food items table
CREATE TABLE foods (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50),
    available BOOLEAN DEFAULT TRUE
);

-- Orders table
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(30) DEFAULT 'Pending',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Sample food items
INSERT INTO foods (name, description, price, category, available)
VALUES
('Veg Sandwich', 'Fresh vegetable sandwich', 40.00, 'Snacks', TRUE),
('Veg Burger', 'Classic vegetable burger', 60.00, 'Fast Food', TRUE),
('Masala Maggi', 'Hot and spicy masala Maggi', 50.00, 'Snacks', TRUE),
('Samosa', 'Crispy potato samosa', 20.00, 'Snacks', TRUE),
('Cold Coffee', 'Chilled creamy cold coffee', 50.00, 'Drinks', TRUE),
('Tea', 'Hot Indian tea', 15.00, 'Drinks', TRUE);

-- Admin account
INSERT INTO users (name, email, password, role)
VALUES
('Admin', 'admin@canteen.com', 'admin123', 'admin');