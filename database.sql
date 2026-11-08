-- Black Hole - database
-- version 1 (work in progress)
-- import this in phpMyAdmin

DROP DATABASE IF EXISTS black_hole;
CREATE DATABASE black_hole;
USE black_hole;

-- users
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- planets
CREATE TABLE planets (
    planet_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    diameter_km DECIMAL(12,2),
    distance_from_sun_km DECIMAL(16,2),
    orbital_period_days DECIMAL(10,2),
    moons_count INT DEFAULT 0,
    image_url VARCHAR(255),
    scroll_order INT NOT NULL
);

-- facts about planets
CREATE TABLE planet_facts (
    fact_id INT AUTO_INCREMENT PRIMARY KEY,
    planet_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    fact_text TEXT NOT NULL,
    FOREIGN KEY (planet_id) REFERENCES planets(planet_id)
);

-- categories
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255)
);

-- products
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    planet_id INT NOT NULL,
    category_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    is_active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (planet_id) REFERENCES planets(planet_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- carts
CREATE TABLE carts (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    status ENUM('active','checked_out','abandoned') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- cart items
CREATE TABLE cart_items (
    cart_item_id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES carts(cart_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- orders
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    cart_id INT,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending','paid','shipped','delivered','cancelled') DEFAULT 'pending',
    shipping_address VARCHAR(255) NOT NULL,
    ordered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (cart_id) REFERENCES carts(cart_id)
);

-- order items
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


--tests

INSERT INTO planets (name, description, diameter_km, distance_from_sun_km, orbital_period_days, moons_count, image_url, scroll_order) VALUES
('Mercury', 'The smallest planet and the closest to the Sun.', 4879, 57900000, 87.97, 0, NULL, 1),
('Venus', 'The hottest planet, covered in thick clouds.', 12104, 108200000, 224.70, 0, NULL, 2),
('Earth', 'Our home planet.', 12756, 149600000, 365.25, 1, NULL, 3),
('Mars', 'The Red Planet.', 6792, 227900000, 686.98, 2, NULL, 4),
('Jupiter', 'The biggest planet, made of gas.', 142984, 778500000, 4332.59, 97, NULL, 5),
('Saturn', 'The planet with the rings.', 120536, 1432000000, 10759.22, 274, NULL, 6);

-- (later add more facts)
INSERT INTO planet_facts (planet_id, title, fact_text) VALUES
(1, 'Short year', 'A year on Mercury is only 88 days.'),
(3, 'Mostly water', 'About 71% of Earth is covered by water.'),
(4, 'Giant volcano', 'Olympus Mons is nearly 2.5 times taller than Everest.'),
(6, 'Floating planet', 'Saturn would float in water.');

INSERT INTO categories (name, description) VALUES
('Replica', 'Replicas of rocks from other planets'),
('Model', 'Planet models'),
('Poster', 'Space posters');

-- (later add products for the other planets)
INSERT INTO products (planet_id, category_id, name, description, price, stock_quantity) VALUES
(4, 1, 'Mars Rock Replica', 'Red rock replica', 29.99, 35),
(3, 2, 'Earth Desk Globe', 'Small globe', 39.99, 20),
(5, 3, 'Jupiter Poster', 'A2 poster', 12.99, 50);

-- users will be added from the register page (not made yet)
