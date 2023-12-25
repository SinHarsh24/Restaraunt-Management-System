-- Procedure-Cancel Order
DELIMITER //
-- Create Procedure
CREATE PROCEDURE CancelOrder(IN orderIDParam INT)
BEGIN
    -- Declare a variable to store the count of rows affected
    DECLARE rowCount INT;

    -- Check if the order exists by counting rows with the specified OrderID
    SELECT COUNT(*) INTO rowCount
    FROM LittleLemonDB.Orders
    WHERE OrderID = orderIDParam;

    -- If the order exists (row count is greater than 0), proceed with deletion
    IF rowCount > 0 THEN
        -- Delete the order record with the specified OrderID
        DELETE FROM LittleLemonDB.Orders
        WHERE OrderID = orderIDParam;

        -- Display a success message
        SELECT CONCAT('Order ID ', orderIDParam, ' successfully canceled.') AS Result;
    ELSE
        -- If the order does not exist, display a message indicating that no action was taken
        SELECT CONCAT('Order ID ', orderIDParam, ' not found. No action taken.') AS Result;
    END IF;
END //

DELIMITER ;

-- Call Procedure
CALL CancelOrder(405);