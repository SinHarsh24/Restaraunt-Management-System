-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8mb4 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `TableNumber` INT NOT NULL,
  PRIMARY KEY (`BookingID`))
ENGINE = InnoDB;

-- Insert data into Bookings table
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `TableNumber`) VALUES
(401, '2023-01-01', 101),
(402, '2023-02-01', 102),
(403, '2023-03-01', 103),
(404, '2023-04-01', 104),
(405, '2023-05-01', 105),
(406, '2023-06-01', 106),
(407, '2023-07-01', 107),
(408, '2023-08-01', 108),
(409, '2023-09-01', 109),
(410, '2023-10-01', 110);

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`CustomerDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`CustomerDetails` (
  `CustomerID` INT NOT NULL,
  `Contacts` VARCHAR(255) NOT NULL,
  `Names` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;

-- Insert data into CustomerDetails table
INSERT INTO `LittleLemonDB`.`CustomerDetails` (`CustomerID`, `Contacts`, `Names`) VALUES
(401, '1234567890', 'John Doe'),
(402, '9876543210', 'Jane Smith'),
(403, '5551234567', 'Alice Johnson'),
(404, '5559876543', 'Bob Smith'),
(405, '5553456789', 'Charlie Brown'),
(406, '5558765432', 'David Williams'),
(407, '5552345678', 'Eva Davis'),
(408, '5557654321', 'Frank Miller'),
(409, '5554567890', 'Grace Taylor'),
(410, '5556543210', 'Henry Jones');

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Order_Delivery_Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Order_Delivery_Status` (
  `StatusID` INT NOT NULL,
  `DeliveryDate` DATE NOT NULL,
  `DeliveryStatus` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`StatusID`))
ENGINE = InnoDB;

-- Insert data into Order_Delivery_Status table
INSERT INTO `LittleLemonDB`.`Order_Delivery_Status` (`StatusID`, `DeliveryDate`, `DeliveryStatus`) VALUES
(401, '2023-01-01', 'Delivered'),
(402, '2023-02-01', 'In Transit'),
(403, '2023-03-01', 'Processing'),
(404, '2023-04-01', 'Cancelled'),
(405, '2023-05-01', 'Delivered'),
(406, '2023-06-01', 'In Transit'),
(407, '2023-07-01', 'Processing'),
(408, '2023-08-01', 'Delivered'),
(409, '2023-09-01', 'In Transit'),
(410, '2023-10-01', 'Processing');

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalCost` INT NOT NULL,
  `StatusID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `Customer_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `Order_fk_idx` (`StatusID` ASC) VISIBLE,
  CONSTRAINT `Customer_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`CustomerDetails` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Order_fk`
    FOREIGN KEY (`StatusID`)
    REFERENCES `LittleLemonDB`.`Order_Delivery_Status` (`StatusID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- Insert data into Orders table
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `Quantity`, `TotalCost`, `StatusID`, `CustomerID`) VALUES
(401, 20230101, 5, 100, 401, 401),
(402, 20230201, 3, 75, 402, 402),
(403, 20230301, 2, 150, 403, 403),
(404, 20230401, 4, 60, 404, 404),
(405, 20230501, 3, 45, 405, 405),
(406, 20230601, 1, 15, 406, 406),
(407, 20230701, 5, 75, 407, 407),
(408, 20230801, 2, 30, 408, 408),
(409, 20230901, 3, 45, 409, 409),
(410, 20231001, 4, 60, 410, 410);

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff_Information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff_Information` (
  `StaffID` INT NOT NULL,
  `Role` VARCHAR(255) NOT NULL,
  `Salary` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB;

-- Insert data into Staff_Information table
INSERT INTO `LittleLemonDB`.`Staff_Information` (`StaffID`, `Role`, `Salary`) VALUES
(401, 'Waiter', '2500'),
(402, 'Chef', '3500'),
(403, 'Manager', '5000'),
(404, 'Server', '2000'),
(405, 'Bartender', '3000'),
(406, 'Hostess', '2200'),
(407, 'Kitchen Staff', '2800'),
(408, 'Busser', '1800'),
(409, 'Dishwasher', '1600'),
(410, 'Cleaner', '1500');

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuID` INT NOT NULL,
  `Starters` VARCHAR(255) NOT NULL,
  `Cuisines` VARCHAR(255) NOT NULL,
  `Courses` VARCHAR(255) NOT NULL,
  `Drinks` VARCHAR(255) NOT NULL,
  `Desserts` VARCHAR(255) NOT NULL,
  `OrderID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `StaffID` INT NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `Menu_fk_idx` (`OrderID` ASC) VISIBLE,
  INDEX `Bookings_fk_idx` (`BookingID` ASC) VISIBLE,
  INDEX `Staff_fk_idx` (`StaffID` ASC) VISIBLE,
  CONSTRAINT `Menu_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Bookings_fk`
    FOREIGN KEY (`BookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Staff_fk`
    FOREIGN KEY (`StaffID`)
    REFERENCES `LittleLemonDB`.`Staff_Information` (`StaffID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- Insert data into Menu table
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Starters`, `Cuisines`, `Courses`, `Drinks`, `Desserts`, `OrderID`, `BookingID`, `StaffID`) VALUES
(401, 'Soup', 'Italian', 'Main Course', 'Wine', 'Tiramisu', 401, 401, 401),
(402, 'Salad', 'French', 'Dessert', 'Cocktail', 'Chocolate Cake', 402, 402, 402),
(403, 'Appetizer', 'Mexican', 'Appetizer', 'Beer', 'Ice Cream', 403, 403, 403),
(404, 'Pasta', 'Chinese', 'Main Course', 'Soda', 'Cheesecake', 404, 404, 404),
(405, 'Breadsticks', 'Indian', 'Dessert', 'Mocktail', 'Fruit Salad', 405, 405, 405),
(406, 'Bruschetta', 'Japanese', 'Appetizer', 'Juice', 'Panna Cotta', 406, 406, 406),
(407, 'Cheese Platter', 'Mediterranean', 'Main Course', 'Water', 'Baklava', 407, 407, 407),
(408, 'Sushi', 'Thai', 'Dessert', 'Tea', 'Mochi', 408, 408, 408),
(409, 'Grilled Chicken', 'American', 'Main Course', 'Cola', 'Brownie', 409, 409, 409),
(410, 'Shrimp Tempura', 'Greek', 'Appetizer', 'Lemonade', 'Cheesecake', 410, 410, 410);

-- -----------------------------------------------------

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS; 