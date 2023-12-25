-- Update Booking
DELIMITER //
-- Create Procedure
CREATE PROCEDURE UpdateBooking(
    IN bookingIDParam INT,
    IN newBookingDate DATE,
    IN newTableNumber INT,
    IN newCustomerName VARCHAR(255)
)
BEGIN
    DECLARE existingBookingCount INT;

    -- Check if the booking exists
    SELECT COUNT(*) INTO existingBookingCount
    FROM LittleLemonDB.Bookings
    WHERE BookingID = bookingIDParam;

    -- Start a transaction
    START TRANSACTION;

    IF existingBookingCount > 0 THEN
        -- The booking exists, update the booking details
        UPDATE LittleLemonDB.Bookings
        SET BookingDate = newBookingDate,
            TableNumber = newTableNumber,
            CustomerName = newCustomerName
        WHERE BookingID = bookingIDParam;

        -- Commit the transaction
        COMMIT;

        SELECT CONCAT('Booking ID ', bookingIDParam, ' updated successfully.') AS Result;
    ELSE
        -- The booking does not exist, rollback the transaction
        ROLLBACK;

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Booking ID does not exist. Update failed.';
    END IF;
END //

DELIMITER ;
DELIMITER //