-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Inha
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Inha
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Inha` DEFAULT CHARACTER SET utf8 ;
USE `Inha` ;

-- -----------------------------------------------------
-- Table `Inha`.`Building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inha`.`Building` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inha`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inha`.`Department` (
  `Id` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Phone_number` VARCHAR(45) NULL,
  `Building_Id` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Department_Building1_idx` (`Building_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Department_Building1`
    FOREIGN KEY (`Building_Id`)
    REFERENCES `Inha`.`Building` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inha`.`Room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inha`.`Room` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Capacity` INT NOT NULL,
  `Department_Id` VARCHAR(45) NULL,
  `Building_Id` INT NOT NULL,
  PRIMARY KEY (`Id`, `Building_Id`),
  INDEX `fk_Room_Department1_idx` (`Department_Id` ASC) VISIBLE,
  INDEX `fk_Room_Building1_idx` (`Building_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Room_Department1`
    FOREIGN KEY (`Department_Id`)
    REFERENCES `Inha`.`Department` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Room_Building1`
    FOREIGN KEY (`Building_Id`)
    REFERENCES `Inha`.`Building` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inha`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inha`.`Student` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Phone_number` VARCHAR(45) NULL,
  `Major` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `Major_idx` (`Major` ASC) VISIBLE,
  CONSTRAINT `Major`
    FOREIGN KEY (`Major`)
    REFERENCES `Inha`.`Department` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/* building */
INSERT INTO building VALUES (1, 'Building 1');
INSERT INTO building VALUES (2, 'Building 2');
INSERT INTO building VALUES (3, 'Building 3');
INSERT INTO building VALUES (4, 'Building 4');
INSERT INTO building VALUES (5, 'Building 5');
INSERT INTO building VALUES (6, 'Inha HI-Tech Center');

/* department */
INSERT INTO department VALUES ('ICE', 'Information Communication', 'ice@inha.ac.kr', '032-100-1001', 6);
INSERT INTO department VALUES ('CSE', 'Computer Science', 'cse@inha.ac.kr', '032-100-1002', 6);
INSERT INTO department VALUES ('EEC', 'Electrical and Electronic', 'eec@inha.ac.kr', '032-100-1003', 2);
INSERT INTO department VALUES ('MTH', 'Mathematics', 'mth@inha.ac.kr', '032-100-1004', 5);
INSERT INTO department VALUES ('BUS', 'Business', 'bus@inha.ac.kr', '032-100-1005', 2);

/* room */
INSERT INTO room VALUES (1, '5E-141', 60, 'MTH', 5);
INSERT INTO room VALUES (2, 'HI-002', 30, 'ICE', 6);
INSERT INTO room VALUES (3, '4E-115', 70, null, 4);
INSERT INTO room VALUES (4, '5E-108', 70, 'EEC', 5);
INSERT INTO room VALUES (5, '5N-134', 20, null, 5);
INSERT INTO room VALUES (6, '1S-108', 50, 'BUS', 1);

/* student */ 
INSERT INTO student VALUES (12201919, 'Jongkeun Yoon', '12201919@inha.ac.kr', '010-1234-5678', 'ICE');
INSERT INTO student VALUES (12111111, 'Inha Kim', '12111111@inha.ac.kr', '010-5567-4533', 'ICE');
INSERT INTO student VALUES (12222222, 'Induck Park', '12222222@inha.ac.kr', '010-5342-2345', 'EEC');
INSERT INTO student VALUES (12333333, 'Inha Doe', '12333333@inha.ac.kr', null, 'MTH');
INSERT INTO student VALUES (12444444, 'Inha Dae', '12444444@inha.ac.kr', '010-9624-4532', 'CSE');