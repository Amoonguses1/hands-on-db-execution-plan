-- Customers table: Stores customer information
CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(255) NOT NULL,
email VARCHAR(255) UNIQUE NOT NULL
);

-- Products table: Stores product information
CREATE TABLE Products (
product_id INT PRIMARY KEY,
product_name VARCHAR(255) NOT NULL,
price DECIMAL(10, 2) NOT NULL
);

-- Shippers table: Stores shipping carrier information
CREATE TABLE Shippers (
shipping_id INT PRIMARY KEY,
shipper_name VARCHAR(255) NOT NULL
);

-- Orders table: Stores order information
-- Foreign keys reference customers.customer_id and shippers.shipping_id
CREATE TABLE Orders (
order_id INT PRIMARY KEY,
customer_id INT NOT NULL,
order_date DATE NOT NULL,
shipping_id INT NOT NULL,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
FOREIGN KEY (shipping_id) REFERENCES Shippers(shipping_id)
);

-- Order_Items table: Stores information on individual items in an order
-- Foreign keys reference orders.order_id and products.product_id
CREATE TABLE Order_Items (
order_item_id INT PRIMARY KEY,
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Reviews table: Stores product review information
-- Foreign keys reference products.product_id and customers.customer_id
CREATE TABLE Reviews (
review_id INT PRIMARY KEY,
product_id INT NOT NULL,
customer_id INT NOT NULL,
rating INT CHECK (rating >= 1 AND rating <= 5) NOT NULL,
review_text TEXT,
FOREIGN KEY (product_id) REFERENCES Products(product_id),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
