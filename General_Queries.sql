-- OrdersView that focuses on OrderID, Quantity, and Cost with orders quantity of more than 2
CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost
FROM orders
WHERE Quantity > 2;

SELECT * FROM OrdersView;


-- Little Lemon needed information from four tables on all customers with orders that cost more than $110
SELECT
    CD.CustomerID,
    CD.Names AS CustomerName,
    O.OrderID,
    O.TotalCost
FROM
    LittleLemonDB.CustomerDetails CD
JOIN
    LittleLemonDB.Orders O ON CD.CustomerID = O.CustomerID
JOIN
    LittleLemonDB.Order_Delivery_Status OD ON O.StatusID = OD.StatusID
JOIN
    LittleLemonDB.Menu M ON O.OrderID = M.OrderID
WHERE
    O.TotalCost > 110;
    
    
-- Little Lemon needed to find all menu items for which more than 2 orders had been placed
SELECT
    M.Starters,
    M.Cuisines,
    M.Courses,
    M.Drinks,
    M.Desserts,
    COUNT(O.OrderID) AS OrderCount 
FROM
    LittleLemonDB.Menu M
JOIN
    LittleLemonDB.Orders O ON M.OrderID = O.OrderID
GROUP BY
    M.Starters, M.Cuisines, M.Courses, M.Drinks, M.Desserts
HAVING
    COUNT(O.OrderID) > 2;
    


