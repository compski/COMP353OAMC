-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema OAMC_2.2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OAMC_2.2
-- -----------------------------------------------------
Drop schema if exists `oamc_2.2`;
CREATE SCHEMA IF NOT EXISTS `OAMC_2.2` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `OAMC_2.2` ;

-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Unit` (
  `Unit_ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Unit_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Employee_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Employee_Type` (
  `Employee_Type_ID` INT NOT NULL,
  `Employee_Type` VARCHAR(45) NOT NULL,
  `Rate` DECIMAL(3,2) NULL,
  `Seniority_Multiplier` DECIMAL(2,2) NULL,
  `Overtime_Rate` VARCHAR(45) NULL,
  `Level` VARCHAR(45) NULL,
  PRIMARY KEY (`Employee_Type_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Employee` (
  `Employee_ID` INT NOT NULL,
  `Last_Name` VARCHAR(45) NULL,
  `First_Name` VARCHAR(45) NULL,
  `Salary_Type` VARCHAR(45) NULL,
  `Specialization` VARCHAR(45) NULL,
  `Unit` INT NOT NULL,
  `Employee_Type_ID` INT NOT NULL,
  `Hire_Date` DATE NULL,
  `Years_Experience` INT NULL,
  PRIMARY KEY (`Employee_ID`),
  INDEX `fk_Employee_Unit_idx` (`Unit` ASC),
  INDEX `fk_Employee_Employee_Type1_idx` (`Employee_Type_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Service_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Service_Type` (
  `Service_ID` INT NOT NULL,
  `Service_Name` TINYTEXT NULL,
  `Description` MEDIUMTEXT NULL,
  `Cost` DECIMAL(6,2) NULL,
  PRIMARY KEY (`Service_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Employee_Services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Employee_Services` (
  `Service_ID` INT NOT NULL,
  `Employee_ID` INT NOT NULL,
  PRIMARY KEY (`Service_ID`, `Employee_ID`),
  INDEX `fk_Employee_Services_Employee1_idx` (`Employee_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Patient` (
  `Patient_ID` INT NOT NULL,
  `Last_Name` VARCHAR(45) NULL,
  `First_Name` VARCHAR(45) NULL,
  `Phone_Number` INT NULL,
  `Address` MEDIUMTEXT NULL,
  `Medicare_Number` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`Patient_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Location` (
  `Unit_ID` INT NOT NULL,
  `Floor` INT NOT NULL,
  `Room` INT NOT NULL,
  `Bedcount` VARCHAR(45) NULL,
  `Location_ID` INT NOT NULL,
  PRIMARY KEY (`Location_ID`)/*,
  UNIQUE INDEX `Room_UNIQUE` (`Room` ASC),
  UNIQUE INDEX `Floor_UNIQUE` (`Floor` ASC),
  UNIQUE INDEX `Unit_ID_UNIQUE` (`Unit_ID` ASC)*/)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Beds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Beds` (
  `Bed_ID` INT NOT NULL,
  `Patient_ID` INT NOT NULL,
  `Location_Location_ID` INT NOT NULL,
  PRIMARY KEY (`Bed_ID`, `Location_Location_ID`),
  INDEX `fk_Beds_Location1_idx` (`Location_Location_ID` ASC),
  INDEX `fk_Beds_Patient1_idx` (`Patient_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Treatment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Treatment` (
  `Treatment_ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Cost` DECIMAL(7,2) NULL,
  PRIMARY KEY (`Treatment_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Patient_Treatment_Instances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Patient_Treatment_Instances` (
  `Instance_ID` INT NOT NULL,
  `Patient_ID` INT NOT NULL,
  `Employee_ID` INT NOT NULL,
  `Treatment_Date` DATE NOT NULL,
  `Treatment_ID` INT NOT NULL,
  `Location_Location_ID` INT NOT NULL,
  PRIMARY KEY (`Instance_ID`, `Location_Location_ID`),
  INDEX `fk_Patient_Treatment_Instances_Patient1_idx` (`Patient_ID` ASC),
  INDEX `fk_Patient_Treatment_Instances_Treatment1_idx` (`Treatment_ID` ASC),
  INDEX `fk_Patient_Treatment_Instances_Employee1_idx` (`Employee_ID` ASC),
  INDEX `fk_Patient_Treatment_Instances_Location1_idx` (`Location_Location_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Medication`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Medication` (
  `Medication_Id` INT NOT NULL,
  `Medication_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Medication_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Patient_Treatment_Instances_has_Medication`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Patient_Treatment_Instances_has_Medication` (
  `Patient_Treatment_Instances_Instance_ID` INT NOT NULL,
  `Medication_Id` INT NOT NULL,
  PRIMARY KEY (`Patient_Treatment_Instances_Instance_ID`, `Medication_Id`),
  INDEX `fk_Patient_Treatment_Instances_has_Medication_Medication1_idx` (`Medication_Id` ASC),
  INDEX `fk_Patient_Treatment_Instances_has_Medication_Patient_Treat_idx` (`Patient_Treatment_Instances_Instance_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Supplies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Supplies` (
  `Internal_Supply_ID` INT NOT NULL,
  `Name` TINYTEXT NULL,
  `Description` LONGTEXT NULL,
  `Price_Per_Unit` DECIMAL(6,2) NULL,
  `Expiration_Date` DATE NULL,
  `Main_Category` VARCHAR(45) NULL,
  `Sub_Category` VARCHAR(45) NULL,
  PRIMARY KEY (`Internal_Supply_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Carrier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Carrier` (
  `Carrier_ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_Number` INT NULL,
  `Fax_Number` INT NULL,
  `Can_Rush?` TINYINT(1) NULL,
  PRIMARY KEY (`Carrier_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Vendors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Vendors` (
  `Vendor_ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_Number` INT NULL,
  `Fax_Number` INT NULL,
  PRIMARY KEY (`Vendor_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Order` (
  `Order_ID` INT NOT NULL,
  `Date` DATE NULL,
  `Carrier_Carrier_ID` INT NOT NULL,
  `Vendors_Vendor_ID` INT NOT NULL,
  `Rush?` TINYINT(1) NULL,
  PRIMARY KEY (`Order_ID`, `Carrier_Carrier_ID`, `Vendors_Vendor_ID`),
  INDEX `fk_Order_Carrier1_idx` (`Carrier_Carrier_ID` ASC),
  INDEX `fk_Order_Vendors1_idx` (`Vendors_Vendor_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Order_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Order_Details` (
  `Quantity` INT NOT NULL,
  `Received_Quantity` INT NULL,
  `Order_ID` INT NOT NULL,
  `Supply_ID` INT NOT NULL,
  PRIMARY KEY (`Order_ID`, `Supply_ID`),
  INDEX `fk_Order_Details_Supplies1_idx` (`Order_ID` ASC, `Supply_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Room_Supply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Room_Supply` (
  `Quantity` INT NOT NULL,
  `Alotment` INT NULL,
  `Supplies_Internal_Supply_ID` INT NOT NULL,
  `Location_ID` INT NOT NULL,
  PRIMARY KEY (`Supplies_Internal_Supply_ID`, `Location_ID`),
  INDEX `fk_Room_Supply_Location1_idx` (`Location_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Staff_Schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Staff_Schedule` (
  `idStaff_Schedule` INT NOT NULL,
  PRIMARY KEY (`idStaff_Schedule`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Employee_has_Staff_Schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Employee_has_Staff_Schedule` (
  `Employee_Employee_ID` INT NOT NULL,
  `Staff_Schedule_idStaff_Schedule` INT NOT NULL,
  PRIMARY KEY (`Employee_Employee_ID`, `Staff_Schedule_idStaff_Schedule`),
  INDEX `fk_Employee_has_Staff_Schedule_Staff_Schedule1_idx` (`Staff_Schedule_idStaff_Schedule` ASC),
  INDEX `fk_Employee_has_Staff_Schedule_Employee1_idx` (`Employee_Employee_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Employee_Scheduled_For_Patient_Treatment_Instances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Employee_Scheduled_For_Patient_Treatment_Instances` (
  `Employee_Employee_ID` INT NOT NULL,
  `Patient_Treatment_Instances_Instance_ID` INT NOT NULL,
  PRIMARY KEY (`Employee_Employee_ID`, `Patient_Treatment_Instances_Instance_ID`),
  INDEX `fk_Employee_has_Patient_Treatment_Instances_Patient_Treatme_idx` (`Patient_Treatment_Instances_Instance_ID` ASC),
  INDEX `fk_Employee_has_Patient_Treatment_Instances_Employee1_idx` (`Employee_Employee_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Required_Staff_for_Treatment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Required_Staff_for_Treatment` (
  `Employee_Type_Employee_Type_ID` INT NOT NULL,
  `Treatment_Treatment_ID` INT NOT NULL,
  PRIMARY KEY (`Employee_Type_Employee_Type_ID`, `Treatment_Treatment_ID`),
  INDEX `fk_Employee_Type_has_Treatment_Treatment1_idx` (`Treatment_Treatment_ID` ASC),
  INDEX `fk_Employee_Type_has_Treatment_Employee_Type1_idx` (`Employee_Type_Employee_Type_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Non medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Non medical` (
  `Non_Medical_ID` INT NOT NULL,
  PRIMARY KEY (`Non_Medical_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Nutritional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Nutritional` (
  `Nutritional_ID` INT NOT NULL,
  PRIMARY KEY (`Nutritional_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Medical` (
  `Medical_ID` INT NOT NULL,
  PRIMARY KEY (`Medical_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Administrative_Supply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Administrative_Supply` (
  `idtable2` INT NOT NULL,
  PRIMARY KEY (`idtable2`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Medication`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Medication` (
  `Medication_Id` INT NOT NULL,
  `Medication_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Medication_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`basic_patient_material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`basic_patient_material` (
  `idtable4` INT NOT NULL,
  PRIMARY KEY (`idtable4`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Food`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Food` (
  `idFood` INT NOT NULL,
  PRIMARY KEY (`idFood`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Supporting_Devices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Supporting_Devices` (
  `idSupporting_Devices` INT NOT NULL,
  PRIMARY KEY (`idSupporting_Devices`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Surgical_Equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Surgical_Equipment` (
  `idSurgical_Equipment` INT NOT NULL,
  PRIMARY KEY (`idSurgical_Equipment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Patient_Treatment_Instances_has_Supplies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Patient_Treatment_Instances_has_Supplies` (
  `Patient_Treatment_Instances_Instance_ID` INT NOT NULL,
  `Patient_Treatment_Instances_Location_Location_ID` INT NOT NULL,
  `Supplies_Internal_Supply_ID` INT NOT NULL,
  PRIMARY KEY (`Patient_Treatment_Instances_Instance_ID`, `Patient_Treatment_Instances_Location_Location_ID`, `Supplies_Internal_Supply_ID`),
  INDEX `fk_Patient_Treatment_Instances_has_Supplies_Supplies1_idx` (`Supplies_Internal_Supply_ID` ASC),
  INDEX `fk_Patient_Treatment_Instances_has_Supplies_Patient_Treatme_idx` (`Patient_Treatment_Instances_Instance_ID` ASC, `Patient_Treatment_Instances_Location_Location_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Shift_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Shift_Type` (
  `Shift_Type_ID` INT NOT NULL,
  `Start_Time` TIME(0) NULL,
  `Duration` INT NULL,
  `Unit_ID` INT NULL,
  PRIMARY KEY (`Shift_Type_ID`),
  INDEX `fk_Shift_Type_Unit1_idx` (`Unit_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Assigned_Shift`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Assigned_Shift` (
  `Shift_Shift_ID` INT NOT NULL,
  `Employee_Employee_ID` INT NOT NULL,
  `Date` DATE NULL,
  `Override_Start` TIME(0) NULL,
  `Override_Duration` INT NULL,
  `Assigned_Shiftcol` VARCHAR(45) NULL,
  `Supervisor` TINYINT(1) NULL,
  PRIMARY KEY (`Shift_Shift_ID`, `Employee_Employee_ID`),
  INDEX `fk_Shift_has_Employee_Employee1_idx` (`Employee_Employee_ID` ASC),
  INDEX `fk_Shift_has_Employee_Shift1_idx` (`Shift_Shift_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Beds_assigned_to_Shift`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Beds_assigned_to_Shift` (
  `Beds_Bed_ID` INT NOT NULL,
  `Beds_Location_ID` INT NOT NULL,
  `Shift_ID` INT NOT NULL,
  `Assigned_Shift_Employee_ID` INT NOT NULL,
  PRIMARY KEY (`Beds_Bed_ID`, `Beds_Location_ID`, `Shift_ID`, `Assigned_Shift_Employee_ID`),
  INDEX `fk_Beds_has_Assigned_Shift_Assigned_Shift1_idx` (`Shift_ID` ASC, `Assigned_Shift_Employee_ID` ASC),
  INDEX `fk_Beds_has_Assigned_Shift_Beds1_idx` (`Beds_Bed_ID` ASC, `Beds_Location_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Doctor Rotation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Doctor Rotation` (
  `Rotation_ID` INT NOT NULL,
  `Start_Date` DATE NULL,
  `End_Date` DATE NULL,
  `Doctor_ID` INT NULL,
  `Unit_ID` INT NULL,
  PRIMARY KEY (`Rotation_ID`),
  INDEX `fk_Doctor Rotation_Employee1_idx` (`Doctor_ID` ASC),
  INDEX `fk_Doctor Rotation_Unit1_idx` (`Unit_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Visits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Visits` (
  `Visit_ID` INT NOT NULL,
  `Unit_ID` INT NULL,
  `Patient_ID` INT NULL,
  `Date_Admitted` DATE NULL,
  `Date_Discharged` DATE NULL,
  `Stated Reason` MEDIUMTEXT NULL,
  `Treatments_Received` INT NULL,
  PRIMARY KEY (`Visit_ID`),
  INDEX `fk_Visits_Unit1_idx` (`Unit_ID` ASC),
  INDEX `fk_Visits_Patient1_idx` (`Patient_ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OAMC_2.2`.`Treatment_History_for_Visit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`Treatment_History_for_Visit` (
  `Patient_Treatment_Instances_Instance_ID` INT NOT NULL,
  `Visits_Visit_ID` INT NOT NULL,
  PRIMARY KEY (`Patient_Treatment_Instances_Instance_ID`, `Visits_Visit_ID`),
  INDEX `fk_Patient_Treatment_Instances_has_Visits (or Patient Histo_idx` (`Visits_Visit_ID` ASC),
  INDEX `fk_Patient_Treatment_Instances_has_Visits (or Patient Histo_idx1` (`Patient_Treatment_Instances_Instance_ID` ASC))
ENGINE = InnoDB;

USE `OAMC_2.2` ;

-- -----------------------------------------------------
-- Placeholder table for view `OAMC_2.2`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OAMC_2.2`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `OAMC_2.2`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OAMC_2.2`.`view1`;
USE `OAMC_2.2`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
