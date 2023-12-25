-- Procedure-Check Booking
DELIMITER //
-- Create Procedure
CREATE PROCEDURE CheckBooking(IN tableNumberParam INT, OUT isBooked BOOLEAN)
BEGIN
    -- Declare a variable to store the count of rows affected
    DECLARE rowCount INT;

    -- Check if the table is already booked by counting rows with the specified TableNumber
    SELECT COUNT(*) INTO rowCount
    FROM LittleLemonDB.Bookings
    WHERE TableNumber = tableNumberParam;

    -- If the count is greater than 0, set isBooked to TRUE; otherwise, set it to FALSE
    IF rowCount > 0 THEN
        SET isBooked := TRUE;
    ELSE
        SET isBooked := FALSE;
    END IF;
END //

DELIMITER ;

-- Create a temporary table to store the result
CREATE TEMPORARY TABLE IF NOT EXISTS TempResult (IsTableBooked BOOLEAN);

-- Call the stored procedure and insert the result into the temporary table
CALL CheckBooking(105, @isTableBooked);
INSERT INTO TempResult SELECT @isTableBooked;

-- Display the result from the temporary table
SELECT * FROM TempResult;