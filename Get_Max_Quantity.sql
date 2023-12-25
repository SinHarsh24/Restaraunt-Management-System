-- Max Quantity from Menu Items
DELIMITER //
-- Create Procedure
CREATE PROCEDURE GetMaxQuantity(IN menuIDParam INT)
BEGIN
    DECLARE maxQuantity INT;

    -- Get the maximum quantity for the specified menu item
    SELECT MAX(Quantity) INTO maxQuantity
    FROM LittleLemonDB.Orders
    WHERE OrderID IN (
        SELECT OrderID
        FROM LittleLemonDB.Menu
        WHERE MenuID = menuIDParam
    );

    -- Display the result
    SELECT CONCAT('Maximum Quantity for MenuID ', menuIDParam, ': ', COALESCE(maxQuantity, 'No orders found')) AS Result;

END //

DELIMITER ;

-- Call Procedure
CALL GetMaxQuantity(406);