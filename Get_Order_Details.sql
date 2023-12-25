-- Get Order Detail to help reduce the parsing time of queries
DELIMITER //
-- Create Procedure
CREATE PROCEDURE GetOrderDetails(IN orderIDParam INT)
BEGIN
    -- Declare variables to store order details
    DECLARE orderDateResult INT;
    DECLARE quantityResult INT;
    DECLARE totalCostResult INT;
    DECLARE customerIDResult INT;

    -- Retrieve order details
    SELECT OrderDate, Quantity, TotalCost, CustomerID
    INTO orderDateResult, quantityResult, totalCostResult, customerIDResult
    FROM LittleLemonDB.Orders
    WHERE OrderID = orderIDParam;

    -- Display the result
    IF orderDateResult IS NOT NULL THEN
        SELECT
            CONCAT('Order ID: ', orderIDParam) AS OrderID,
            CONCAT('Order Date: ', orderDateResult) AS OrderDate,
            CONCAT('Quantity: ', quantityResult) AS Quantity,
            CONCAT('Total Cost: ', totalCostResult) AS TotalCost,
            CONCAT('Customer ID: ', customerIDResult) AS CustomerID;
    ELSE
        SELECT 'Order not found';
    END IF;

END //

DELIMITER ;

-- Call Procedure
CALL GetOrderDetails(406);