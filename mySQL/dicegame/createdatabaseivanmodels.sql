-- Drop the schema if it exists
DROP DATABASE IF EXISTS `dicegame`;

-- Create the schema/database
CREATE DATABASE `dicegame`;

-- Switch to the newly created schema
USE `dicegame`;

-- Create the `players` table
CREATE TABLE IF NOT EXISTS `players` (
  `id` VARCHAR(255) NOT NULL PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `wins` INT NOT NULL,
  `losses` INT NOT NULL,
  `createdAt` DATETIME NOT NULL
);

-- Create the `games` table
CREATE TABLE IF NOT EXISTS `games` (
  `id` VARCHAR(255) NOT NULL PRIMARY KEY,
  `player_id` VARCHAR(255) NOT NULL,
  `won` BOOLEAN NOT NULL,
  `result` INT NOT NULL,
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
);
