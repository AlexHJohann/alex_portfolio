
--Create Scripts:
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) UNIQUE NOT NULL
);


CREATE TABLE Shoe (
    ShoeID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Brand VARCHAR(50) NOT NULL,
    Size DECIMAL(3,1) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL CHECK (StockQuantity >= 0)
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ShoeID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ShoeID) REFERENCES Shoe(ShoeID)
);


CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL CHECK (PaymentMethod IN ('Credit Card', 'Debit Card', 'Cash', 'Online')),
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount > 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- Insert Data:
INSERT INTO Customer (Name, Email, Phone) VALUES
('Eva Longoria', 'eva@elongoria.com', '1234567890'),
('Justin Trudeau', 'justin@jt.com', '9876543210'),
('Michal Jordan', 'michael@ejordan.com', '5556667777');


INSERT INTO Shoe (Name, Brand, Size, Price, StockQuantity) VALUES
('Air Max', 'Nike', 10.5, 120.00, 50),
('Superstar', 'Adidas', 9.0, 90.00, 30),
('Classic Leather', 'Reebok', 8.5, 85.00, 20);


INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-03-15', 240.00),
(2, '2024-03-16', 90.00),
(3, '2024-03-17', 120.00);


INSERT INTO OrderDetails (OrderID, ShoeID, Quantity, Subtotal) VALUES
(1, 1, 2, 240.00),
(2, 2, 1, 90.00),
(3, 3, 1, 120.00);


INSERT INTO Payment (OrderID, PaymentMethod, PaymentDate, Amount) VALUES
(1, 'Credit Card', '2024-03-15', 240.00),
(2, 'Cash', '2024-03-16', 90.00),
(3, 'Debit Card', '2024-03-17', 120.00);


--Reports:
--Total Sales Per Day:
SELECT OrderDate, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY OrderDate
ORDER BY OrderDate;

--Total Sales Per Month:
SELECT YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Year, Month;

--Most Ordered Product:
SELECT S.Name, S.Brand, SUM(OD.Quantity) AS TotalSold
FROM OrderDetails OD
JOIN Shoe S ON OD.ShoeID = S.ShoeID
GROUP BY S.Name, S.Brand
ORDER BY TotalSold DESC;