-- Cancel Booking
DELIMITER //
-- Create Procedure
CREATE PROCEDURE CancelBooking(IN bookingIDParam INT)
BEGIN
    DECLARE bookingExists INT;

    -- Check if the booking exists
    SELECT COUNT(*) INTO bookingExists
    FROM LittleLemonDB.Bookings
    WHERE BookingID = bookingIDParam;

    -- Start a transaction
    START TRANSACTION;

    IF bookingExists > 0 THEN
        -- The booking exists, delete the booking
        DELETE FROM LittleLemonDB.Bookings
        WHERE BookingID = bookingIDParam;

        -- Commit the transaction
        COMMIT;

        SELECT CONCAT('Booking ID ', bookingIDParam, ' canceled successfully.') AS Result;
    ELSE
        -- The booking does not exist, rollback the transaction
        ROLLBACK;

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Booking ID does not exist. Cancellation failed.';
    END IF;
END //

DELIMITER ;

-- Call Procedure
CALL CancelBooking(405);