-- Verify Booking
DELIMITER //

CREATE PROCEDURE VerifyBooking(IN bookingIDParam INT, IN customerNameParam VARCHAR(255))
BEGIN
    DECLARE isTableBooked BOOLEAN;
    
    -- Start a transaction to ensure data consistency
    START TRANSACTION;

    -- Check if the table is already booked
    CALL CheckBooking(bookingIDParam, @isTableBooked);

    -- If the table is not booked, update the customer name for the reservation
    IF NOT isTableBooked THEN
        UPDATE LittleLemonDB.CustomerDetails
        SET Names = customerNameParam
        WHERE CustomerID = (
            SELECT CustomerID
            FROM LittleLemonDB.Bookings
            WHERE BookingID = bookingIDParam
        );

        SELECT CONCAT('Booking ID ', bookingIDParam, ' verified and customer name updated.') AS Result;
    ELSE
        -- Table is already booked, decline the reservation
        SELECT CONCAT('Booking ID ', bookingIDParam, ' declined. Table already booked under another name.') AS Result;
    END IF;

    -- Commit or rollback the transaction based on success or failure
    IF NOT isTableBooked THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END //

DELIMITER ;