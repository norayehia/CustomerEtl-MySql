CREATE DATABASE SalesDB;

USE SalesDB;


CREATE TABLE Customers (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    ReferredBy INT NULL
);
#First LEFT JOIN: Ensures that all invoices are included, even those without an associated customer (though rare, it’s a safeguard).
#Second LEFT JOIN: Ensures that customers and their invoices are included even if they don't have a referring customer.
CREATE TABLE Invoices (
    Id INT PRIMARY KEY,
    BillingDate DATE NOT NULL,
    CustomerId INT NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
);

INSERT INTO Customers (Id, Name, ReferredBy)
VALUES 
    (1, 'John Doe', NULL),   -- John Doe is not referred by anyone
    (2, 'Jane Smith', 1);    -- Jane Smith is referred by John Doe

INSERT INTO Invoices (Id, BillingDate, CustomerId)
VALUES 
    (1, '2024-09-01', 1),   -- Invoice 1 for John Doe
    (2, '2024-09-02', 2);   -- Invoice 2 for Jane Smith



SELECT 
    Invoices.Id AS InvoiceID,
    Invoices.BillingDate,
    Customers.Name AS CustomerName,
    Referrer.Name AS ReferredBy
FROM 
    Invoices
LEFT JOIN 
    Customers ON Invoices.CustomerId = Customers.Id
LEFT JOIN 
    Customers AS Referrer ON Customers.ReferredBy = Referrer.Id
ORDER BY 
    Invoices.BillingDate;


