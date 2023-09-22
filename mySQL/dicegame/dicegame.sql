-- Drop the schema if it exists
DROP DATABASE IF EXISTS `dicegame`;

-- Create the schema/database
CREATE DATABASE `dicegame`;

-- Switch to the newly created schema
USE `dicegame`;

-- Create the `players` table
CREATE TABLE IF NOT EXISTS `players` (
  `player_id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NULL,
  `successPercentage` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE = InnoDB;

-- Create the `game_id` table
CREATE TABLE `game_id` (
  `game_id` INT AUTO_INCREMENT PRIMARY KEY,
  `dice1` INT NOT NULL,
  `dice2` INT NOT NULL,
  `gameWon` INT NULL,
  `player_id` INT NOT NULL,
  INDEX `player_id_idx` (`player_id` ASC),
  CONSTRAINT `fk_player_id`
    FOREIGN KEY (`player_id`)
    REFERENCES `players` (`player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Create the ranking table
CREATE TABLE IF NOT EXISTS `ranking` (
  `player_id` INT NOT NULL,
  `successPercentage` DECIMAL(10, 0) NOT NULL,
  PRIMARY KEY (`player_id`),
  FOREIGN KEY (`player_id`)
    REFERENCES `players` (`player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;


-- Insert a sample player into the players table
INSERT INTO `players` (`player_id`, `name`, `email`, `password`, `successPercentage`)
VALUES (1, 'Sample Player', 'sample@email.com', 'samplepassword', 75);

-- Insert a sample game into the game_id table
INSERT INTO `game_id` (`dice1`, `dice2`, `gameWon`, `player_id`)
VALUES (4, 6, 1, 1);

-- Insert player rankings ordered by successPercentage
INSERT INTO `ranking` (`player_id`, `successPercentage`)
SELECT `player_id`, `successPercentage`
FROM `players`
ORDER BY `successPercentage` DESC;


