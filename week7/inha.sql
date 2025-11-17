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


-- -----------------------------------------------------
-- Table `Inha`.`Class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inha`.`Class` (
  `Id` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Professor` VARCHAR(45) NOT NULL,
  `Number_of_participants` INT NOT NULL,
  `Room_Id` INT NOT NULL,
  `Room_Building_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Class_Room1_idx` (`Room_Id` ASC, `Room_Building_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Class_Room1`
    FOREIGN KEY (`Room_Id` , `Room_Building_Id`)
    REFERENCES `Inha`.`Room` (`Id` , `Building_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inha`.`Club`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inha`.`Club` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Room_Id` INT NULL,
  `Room_Building_Id` INT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Club_Room1_idx` (`Room_Id` ASC, `Room_Building_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Club_Room1`
    FOREIGN KEY (`Room_Id` , `Room_Building_Id`)
    REFERENCES `Inha`.`Room` (`Id` , `Building_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inha`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inha`.`Employee` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Position` VARCHAR(45) NOT NULL,
  `Department_Id` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Employee_Department1_idx` (`Department_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Department1`
    FOREIGN KEY (`Department_Id`)
    REFERENCES `Inha`.`Department` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inha`.`Enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inha`.`Enrollment` (
  `Student_Id` INT NOT NULL,
  `Class_Id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Student_Id`, `Class_Id`),
  INDEX `fk_Student_has_Class_Class1_idx` (`Class_Id` ASC) VISIBLE,
  INDEX `fk_Student_has_Class_Student1_idx` (`Student_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Student_has_Class_Student1`
    FOREIGN KEY (`Student_Id`)
    REFERENCES `Inha`.`Student` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_has_Class_Class1`
    FOREIGN KEY (`Class_Id`)
    REFERENCES `Inha`.`Class` (`Id`)
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

/* class */
INSERT INTO class VALUES ("EEC4408", "Database Structure", "Choi", 30, 6, 1);
INSERT INTO class VALUES ("EEC3204", "JAVA Programming", "Huh", 20, 6, 1);
INSERT INTO class VALUES ("ICE4408", "Database", "Lee", 30, 5, 5);
INSERT INTO class VALUES ("MTH1204", "Mathmatics", "Kim", 40, 4, 5);
INSERT INTO class VALUES ("CSE4403", "Computer Structure", "Yoon", 50, 3, 4);

/* club */
INSERT INTO club VALUES (1, "Dong 1", 1, 5);
INSERT INTO club VALUES (2, "Dong 2", 5, 5);
INSERT INTO club VALUES (3, "Dong 3", NULL, NULL);
INSERT INTO club VALUES (4, "Dong 4", NULL, NULL);
INSERT INTO club VALUES (5, "Dong 5", NULL, NULL);

/* employee */
INSERT INTO employee VALUES (1, "Yoon", "President", NULL);
INSERT INTO employee VALUES (2, "Kim", "Librarian", NULL);
INSERT INTO employee VALUES (3, "Choi", "Officer", "ICE");
INSERT INTO employee VALUES (4, "Lee", "Security Guard", NULL);
INSERT INTO employee VALUES (5, "Seo", "Officer", "EEC");

/* enrollment */
INSERT INTO enrollment VALUES(12111111, "EEC4408");
INSERT INTO enrollment VALUES(12111111, "EEC3204");
INSERT INTO enrollment VALUES(12111111, "ICE4408");
INSERT INTO enrollment VALUES(12111111, "MTH1204");
INSERT INTO enrollment VALUES(12111111, "CSE4403");