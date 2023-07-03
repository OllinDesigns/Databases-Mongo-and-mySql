DROP SCHEMA IF EXISTS `spotifyEd`;

CREATE SCHEMA IF NOT EXISTS `spotifyEd`;
USE `spotifyEd`;

-- Create the artist table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`artist` (
  `art_id` INT NOT NULL,
  `art_name` VARCHAR(45) NOT NULL,
  `art_image` VARCHAR(45) NULL,
  PRIMARY KEY (`art_id`),
  UNIQUE INDEX `art_id_UNIQUE` (`art_id` ASC) VISIBLE
) ENGINE = InnoDB;

-- Create the album table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`album` (
  `alb_id` INT NOT NULL,
  `alb_title` VARCHAR(45) NOT NULL,
  `alb_publicationyear` INT NOT NULL,
  `alb_coverimg` VARCHAR(45) NULL,
  `art_id` INT NOT NULL,
  PRIMARY KEY (`alb_id`),
  UNIQUE INDEX `alb_id_UNIQUE` (`alb_id` ASC) VISIBLE,
  FOREIGN KEY (`art_id`) REFERENCES `artist` (`art_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Create the songs table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`songs` (
  `so_id` INT NOT NULL,
  `so_title` VARCHAR(45) NOT NULL,
  `so_duration` DECIMAL(7,2) NOT NULL,
  `so_nr_of_times_played` INT NOT NULL,
  `alb_id` INT NOT NULL,
  PRIMARY KEY (`so_id`),
  UNIQUE INDEX `so_id_UNIQUE` (`so_id` ASC) VISIBLE,
  FOREIGN KEY (`alb_id`) REFERENCES `album` (`alb_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Create the subscription table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`subscription` (
  `sub_id` INT NOT NULL,
  `sub_start_date` DATE NOT NULL,
  `sub_renewal_date` VARCHAR(45) NOT NULL,
  `sub_payment_method` ENUM('paypal', 'credit card') NOT NULL,
  PRIMARY KEY (`sub_id`)
) ENGINE = InnoDB;

-- Create the premium_users table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`premium_users` (
  `pu_id` INT NOT NULL,
  `pu_email` VARCHAR(45) NOT NULL,
  `pu_password` VARCHAR(45) NOT NULL,
  `pu_username` VARCHAR(45) NOT NULL,
  `pu_birthdate` DATE NOT NULL,
  `pu_genre` ENUM('male', 'female', 'other') NULL,
  `pu_country` VARCHAR(45) NOT NULL,
  `pu_postcode` VARCHAR(45) NULL,
  `sub_id` INT NOT NULL,
  PRIMARY KEY (`pu_id`, `pu_email`),
  UNIQUE INDEX `pu_id_UNIQUE` (`pu_id` ASC) VISIBLE,
  FOREIGN KEY (`sub_id`) REFERENCES `subscription` (`sub_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Create the payments table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`payments` (
  `py_order_number` INT NOT NULL,
  `py_date` DATE NOT NULL,
  `py_total` DECIMAL(7,3) NOT NULL,
  `py_madewith` ENUM('paypal', 'credit card') NOT NULL,
  `cc_card_number` VARCHAR(16) NULL,
  `cc_expiry_month` INT NULL,
  `cc_expiry_year` INT NULL,
  `cc_security_code` VARCHAR(4) NULL,
  `paypal_username` VARCHAR(45) NULL,
  `pu_id` INT NOT NULL,
  PRIMARY KEY (`py_order_number`),
  UNIQUE INDEX `py_order_number_UNIQUE` (`py_order_number` ASC) VISIBLE,
  FOREIGN KEY (`pu_id`) REFERENCES `premium_users` (`pu_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Create the user_follows table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`user_follows` (
  `user_id` INT NOT NULL,
  `art_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `art_id`),
  FOREIGN KEY (`user_id`) REFERENCES `premium_users` (`pu_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`art_id`) REFERENCES `artist` (`art_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Create the related_artists table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`related_artists` (
  `artist_id` INT NOT NULL,
  `related_artist_id` INT NOT NULL,
  PRIMARY KEY (`artist_id`, `related_artist_id`),
  FOREIGN KEY (`artist_id`) REFERENCES `artist` (`art_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`related_artist_id`) REFERENCES `artist` (`art_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Create the user_favorite_albums table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`user_favorite_albums` (
  `user_id` INT NOT NULL,
  `alb_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `alb_id`),
  FOREIGN KEY (`user_id`) REFERENCES `premium_users` (`pu_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`alb_id`) REFERENCES `album` (`alb_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Create the user_favorite_songs table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`user_favorite_songs` (
  `user_id` INT NOT NULL,
  `so_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `so_id`),
  FOREIGN KEY (`user_id`) REFERENCES `premium_users` (`pu_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`so_id`) REFERENCES `songs` (`so_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Create the free_users table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`free_users` (
  `fu_id` INT NOT NULL,
  `fu_email` VARCHAR(45) NOT NULL,
  `fu_password` VARCHAR(45) NOT NULL,
  `fu_username` VARCHAR(45) NOT NULL,
  `fu_birthdate` DATE NOT NULL,
  `fu_genre` ENUM('male', 'female', 'other') NULL,
  `fu_country` VARCHAR(45) NOT NULL,
  `fu_postcode` VARCHAR(45) NULL,
  PRIMARY KEY (`fu_id`, `fu_email`),
  UNIQUE INDEX `fu_id_UNIQUE` (`fu_id` ASC) VISIBLE
) ENGINE = InnoDB;

-- Create the playlist table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`playlist` (
  `pyl_id` INT UNSIGNED NOT NULL,
  `pyl_title` VARCHAR(45) NOT NULL,
  `pyl_nrOfSongs` INT NOT NULL,
  `pyl_create_date` DATE NOT NULL,
  `pyl_delete_date` DATE NULL,
  `pyl_is_active` TINYINT(1) NOT NULL,
  PRIMARY KEY (`pyl_id`)
) ENGINE = InnoDB;

-- Create the playlist_songs table
CREATE TABLE IF NOT EXISTS `spotifyEd`.`playlist_songs` (
  `pyl_id` INT UNSIGNED NOT NULL,
  `so_id` INT NOT NULL,
  `pu_id` INT NOT NULL,
  `ps_add_date` DATE NOT NULL,
  FOREIGN KEY (`pyl_id`) REFERENCES `playlist` (`pyl_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`so_id`) REFERENCES `songs` (`so_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`pu_id`) REFERENCES `premium_users` (`pu_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

INSERT INTO `spotifyEd`.`artist` (`art_id`, `art_name`, `art_image`) VALUES
(1, 'Iron Maiden', 'iron_maiden.jpg'),
(2, 'Black Sabbath', 'black_sabbath.jpg'),
(3, 'Deep Purple', 'deep_purple.jpg'),
(4, 'English Dogs', 'english_dogs.jpg'),
(5, 'Metallica', 'metallica.jpg'),
(6, 'Led Zeppelin', 'led_zeppelin.jpg'),
(7, 'AC/DC', 'ac_dc.jpg'),
(8, 'Judas Priest', 'judas_priest.jpg'),
(9, 'Megadeth', 'megadeth.jpg'),
(10, 'Slayer', 'slayer.jpg'),
(11, 'Pantera', 'pantera.jpg'),
(12, 'Motorhead', 'motorhead.jpg'),
(13, 'Black Label Society', 'black_label_society.jpg'),
(14, 'Ozzy Osbourne', 'ozzy_osbourne.jpg'),
(15, 'Alice Cooper', 'alice_cooper.jpg'),
(16, 'Anthrax', 'anthrax.jpg'),
(17, 'Kiss', 'kiss.jpg'),
(18, 'Scorpions', 'scorpions.jpg'),
(19, 'Rainbow', 'rainbow.jpg'),
(20, 'The Rolling Stones', 'rolling_stones.jpg');

INSERT INTO `spotifyEd`.`album` (`alb_id`, `alb_title`, `alb_publicationyear`, `alb_coverimg`, `art_id`) VALUES
(1, 'The Number of the Beast', 1982, 'number_of_the_beast.jpg', 1),
(2, 'Powerslave', 1984, 'powerslave.jpg', 1),
(3, 'Paranoid', 1970, 'paranoid.jpg', 2),
(4, 'Master of Reality', 1971, 'master_of_reality.jpg', 2),
(5, 'Machine Head', 1972, 'machine_head.jpg', 3),
(6, 'Burn', 1974, 'burn.jpg', 3),
(7, 'Forward Into Battle', 1985, 'forward_into_battle.jpg', 4),
(8, 'Where Legend Began', 1986, 'where_legend_began.jpg', 4),
(9, 'Master of Puppets', 1986, 'master_of_puppets.jpg', 5),
(10, 'Ride the Lightning', 1984, 'ride_the_lightning.jpg', 5),
(11, 'Led Zeppelin IV', 1971, 'led_zeppelin_iv.jpg', 6),
(12, 'Physical Graffiti', 1975, 'physical_graffiti.jpg', 6),
(13, 'Back in Black', 1980, 'back_in_black.jpg', 7),
(14, 'Highway to Hell', 1979, 'highway_to_hell.jpg', 7),
(15, 'British Steel', 1980, 'british_steel.jpg', 8),
(16, 'Screaming for Vengeance', 1982, 'screaming_for_vengeance.jpg', 8),
(17, 'Rust in Peace', 1990, 'rust_in_peace.jpg', 9),
(18, 'Peace Sells... but Who s Buying?', 1986, 'peace_sells.jpg', 9),
(19, 'Reign in Blood', 1986, 'reign_in_blood.jpg', 10),
(20, 'Seasons in the Abyss', 1990, 'seasons_in_the_abyss.jpg', 10),
(21, 'Cowboys from Hell', 1990, 'cowboys_from_hell.jpg', 11),
(22, 'Vulgar Display of Power', 1992, 'vulgar_display_of_power.jpg', 11),
(23, 'Ace of Spades', 1980, 'ace_of_spades.jpg', 12),
(24, 'Overkill', 1979, 'overkill.jpg', 12),
(25, 'Sonic Brew', 1999, 'sonic_brew.jpg', 13),
(26, '1919 Eternal', 2002, '1919_eternal.jpg', 13),
(27, 'Blizzard of Ozz', 1980, 'blizzard_of_ozz.jpg', 14),
(28, 'Diary of a Madman', 1981, 'diary_of_a_madman.jpg', 14),
(29, 'Billion Dollar Babies', 1973, 'billion_dollar_babies.jpg', 15),
(31, 'Among the Living', 1987, 'among_the_living.jpg', 16),
(32, 'Persistence of Time', 1990, 'persistence_of_time.jpg', 16);

INSERT INTO `spotifyEd`.`songs` (`so_id`, `so_title`, `so_duration`, `so_nr_of_times_played`, `alb_id`) VALUES
(1, 'The Number of the Beast', 4.32, 100, 1),
(2, 'Powerslave', 6.49, 75, 1),
(3, 'War Pigs', 7.55, 120, 2),
(4, 'Iron Man', 5.55, 90, 2),
(5, 'Highway Star', 6.08, 150, 3),
(6, 'Smoke on the Water', 5.40, 110, 3),
(7, 'Holy Wars... The Punishment Due', 6.32, 80, 4),
(8, 'Hangar 18', 5.13, 95, 4),
(9, 'Angel of Death', 4.51, 130, 5),
(10, 'Raining Blood', 4.18, 105, 5),
(11, 'Burn', 4.49, 85, 6),
(12, 'Mistreated', 7.28, 70, 6),
(13, 'Forward Into Battle', 5.07, 95, 7),
(14, 'The Final Conquest', 4.56, 110, 7),
(15, 'Where Legend Began', 5.32, 80, 8),
(16, 'Day of Judgment', 6.18, 65, 8),
(17, 'Battery', 5.12, 120, 9),
(18, 'Welcome Home (Sanitarium)', 6.27, 90, 9),
(19, 'Fight Fire with Fire', 4.45, 105, 10),
(20, 'For Whom the Bell Tolls', 5.10, 130, 10),
(21, 'Stairway to Heaven', 8.02, 150, 11),
(22, 'Black Dog', 4.55, 120, 11),
(23, 'Hells Bells', 5.12, 130, 12),
(24, 'Back in Black', 4.15, 140, 12),
(25, 'Breaking the Law', 2.36, 100, 13),
(26, 'Living After Midnight', 3.31, 110, 13),
(27, 'Rock and Roll', 3.40, 90, 14),
(28, 'Whole Lotta Love', 5.34, 80, 14),
(29, 'You Shook Me All Night Long', 3.30, 120, 15),
(30, 'Highway to Hell', 3.29, 130, 15),
(31, 'You ve Got Another Thing Comin', 5.09, 140, 16),
(32, 'Electric Eye', 3.39, 120, 16),
(33, 'Holy Wars... The Punishment Due', 6.32, 150, 17),
(34, 'Hangar 18', 5.13, 130, 17),
(35, 'Peace Sells', 4.04, 100, 18),
(36, 'Wake Up Dead', 3.40, 110, 18),
(37, 'Angel of Death', 4.51, 120, 19),
(38, 'Raining Blood', 4.18, 130, 19),
(39, 'Seasons in the Abyss', 6.36, 140, 20),
(40, 'War Ensemble', 4.51, 150, 20),
(41, 'Cowboys from Hell', 4.07, 120, 21),
(42, 'Cemetery Gates', 7.03, 130, 21),
(43, 'Walk', 5.15, 140, 22),
(44, 'Fucking Hostile', 2.48, 150, 22),
(45, 'Ace of Spades', 2.49, 100, 23),
(46, 'Love Me Like a Reptile', 3.23, 110, 23),
(47, 'Overkill', 5.14, 120, 24),
(48, 'Damage Case', 3.03, 130, 24),
(49, 'Bored to Tears', 4.28, 140, 25),
(50, 'Stillborn', 3.14, 150, 25),
(51, 'Bored to Tears', 4.58, 160, 26),
(52, 'Stillborn', 3.39, 170, 26),
(53, 'Crazy Train', 4.49, 180, 27),
(54, 'Mr. Crowley', 4.56, 190, 27),
(55, 'Over the Mountain', 4.31, 200, 28),
(56, 'Flying High Again', 4.44, 210, 28),
(57, 'Hello Hooray', 4.16, 220, 29),
(58, 'Billion Dollar Babies', 3.43, 230, 29),
(59, 'Among the Living', 5.16, 240, 31),
(60, 'Caught in a Mosh', 4.59, 250, 31),
(61, 'Got the Time', 2.44, 260, 32),
(62, 'In My World', 6.25, 270, 32);

INSERT INTO `spotifyEd`.`subscription` (`sub_id`, `sub_start_date`, `sub_renewal_date`, `sub_payment_method`) VALUES
(1, '2023-01-01', '2023-02-01', 'paypal'),
(2, '2023-02-05', '2023-03-05', 'credit card'),
(3, '2023-03-10', '2023-04-10', 'paypal'),
(4, '2023-04-15', '2023-05-15', 'credit card'),
(5, '2023-05-20', '2023-06-20', 'paypal'),
(6, '2023-06-25', '2023-07-25', 'credit card'),
(7, '2023-07-30', '2023-08-30', 'paypal'),
(8, '2023-08-31', '2023-09-30', 'credit card'),
(9, '2023-01-01', '2023-02-01', 'paypal'),
(10, '2023-02-05', '2023-03-05', 'credit card'),
(11, '2023-03-10', '2023-04-10', 'paypal'),
(12, '2023-04-15', '2023-05-15', 'credit card'),
(13, '2023-05-20', '2023-06-20', 'paypal'),
(14, '2023-06-25', '2023-07-25', 'credit card'),
(15, '2023-07-30', '2023-08-30', 'paypal'),
(16, '2023-08-31', '2023-09-30', 'credit card'),
(17, '2023-09-01', '2023-10-01', 'paypal'),
(18, '2023-10-05', '2023-11-05', 'credit card');

INSERT INTO `spotifyEd`.`premium_users` (`pu_id`, `pu_email`, `pu_password`, `pu_username`, `pu_birthdate`, `pu_genre`, `pu_country`, `pu_postcode`, `sub_id`) VALUES
(1, 'user1@example.com', 'password1', 'user1', '1990-05-15', 'male', 'Pakistan', '12345', 1),
(2, 'user2@example.com', 'password2', 'user2', '1985-10-20', 'female', 'Bangladesh', 'V1M 3N8', 2),
(3, 'user3@example.com', 'password3', 'user3', '1992-07-02', 'other', 'Nigeria', 'AB12 3CD', 3),
(4, 'user4@example.com', 'password4', 'user4', '1998-02-28', 'male', 'Ethiopia', '2000', 4),
(5, 'user5@example.com', 'password5', 'user5', '1994-12-10', 'female', 'Uganda', '12345', 5),
(6, 'user6@example.com', 'password6', 'user6', '1991-09-05', 'other', 'Honduras', '75000', 6),
(7, 'user7@example.com', 'password7', 'user7', '1996-03-22', 'male', 'Cambodia', '28001', 7),
(8, 'user8@example.com', 'password8', 'user8', '1988-11-18', 'female', 'Myanmar', '00100', 8),
(9, 'user9@example.com', 'password9', 'user9', '1993-06-25', 'other', 'Madagascar', '20000-000', 9),
(10, 'user10@example.com', 'password10', 'user10', '1997-04-14', 'male', 'Afghanistan', '12345', 10),
(11, 'user11@example.com', 'password11', 'user11', '1999-08-08', 'female', 'Yemen', '100-0001', 11),
(12, 'user12@example.com', 'password12', 'user12', '1990-01-03', 'other', 'Malawi', '12345', 12),
(13, 'user13@example.com', 'password13', 'user13', '1987-12-28', 'male', 'Sierra Leone', '110001', 13),
(14, 'user14@example.com', 'password14', 'user14', '1995-09-17', 'female', 'Bolivia', '123456', 14),
(15, 'user15@example.com', 'password15', 'user15', '1992-11-12', 'other', 'Tajikistan', '123456', 15),
(16, 'user16@example.com', 'password16', 'user16', '1998-07-07', 'male', 'Senegal', '1234', 16),
(17, 'user17@example.com', 'password17', 'user17', '1989-04-24', 'female', 'Benin', '1234 AB', 17),
(18, 'user18@example.com', 'password18', 'user18', '1993-03-19', 'other', 'Mali', '123 45', 18);

INSERT INTO `spotifyEd`.`payments` (`py_order_number`, `py_date`, `py_total`, `py_madewith`, `cc_card_number`, `cc_expiry_month`, `cc_expiry_year`, `cc_security_code`, `paypal_username`, `pu_id`) VALUES
(1, '2023-01-01', 10.50, 'paypal', NULL, NULL, NULL, NULL, 'user1', 1),
(2, '2023-02-05', 15.20, 'credit card', '4916816767362461', 11, 2025, '789', NULL, 2),
(3, '2023-03-10', 8.75, 'paypal', NULL, NULL, NULL, NULL, 'user3', 3),
(4, '2023-04-15', 12.99, 'credit card', '4532979967915673', 9, 2024, '456', NULL, 4),
(5, '2023-05-20', 5.99, 'paypal', NULL, NULL, NULL, NULL, 'user5', 5),
(6, '2023-06-25', 11.00, 'credit card', '5469157850627891', 3, 2023, '123', NULL, 6),
(7, '2023-07-30', 9.99, 'paypal', NULL, NULL, NULL, NULL, 'user7', 7),
(8, '2023-08-31', 7.50, 'credit card', '4024007142972560', 7, 2023, '234', NULL, 8),
(9, '2023-09-01', 14.99, 'paypal', NULL, NULL, NULL, NULL, 'user9', 9),
(10, '2023-10-05', 6.25, 'credit card', '5288340286251138', 5, 2022, '567', NULL, 10),
(11, '2023-11-10', 13.80, 'paypal', NULL, NULL, NULL, NULL, 'user11', 11),
(12, '2023-12-15', 10.99, 'credit card', '4916908532579674', 12, 2024, '890', NULL, 12),
(13, '2024-01-20', 8.50, 'paypal', NULL, NULL, NULL, NULL, 'user13', 13),
(14, '2024-02-25', 12.00, 'credit card', '5322678431256979', 8, 2023, '345', NULL, 14),
(15, '2024-03-30', 7.99, 'paypal', NULL, NULL, NULL, NULL, 'user15', 15),
(16, '2024-04-30', 9.75, 'credit card', '4485551567200128', 10, 2022, '678', NULL, 16),
(17, '2024-05-31', 11.50, 'paypal', NULL, NULL, NULL, NULL, 'user17', 17),
(18, '2024-06-30', 6.99, 'credit card', '4556454864404560', 6, 2023, '901', NULL, 18);

INSERT INTO `spotifyEd`.`user_follows` (`user_id`, `art_id`) VALUES
(1, 2),
(1, 4),
(1, 5),
(1, 8),
(2, 1),
(2, 3),
(2, 5),
(2, 9),
(3, 2),
(3, 4),
(3, 6),
(3, 10),
(4, 1),
(4, 7),
(4, 11),
(4, 15),
(5, 2),
(5, 5),
(5, 6),
(5, 12),
(6, 4),
(6, 6),
(6, 9),
(6, 16),
(7, 1),
(7, 3),
(7, 7),
(7, 17),
(8, 2),
(8, 5),
(8, 11),
(8, 18),
(9, 3),
(9, 6),
(9, 10),
(9, 19),
(10, 1),
(10, 7),
(10, 12),
(10, 20),
(11, 2),
(11, 5),
(11, 6),
(11, 13),
(12, 4),
(12, 11),
(12, 16),
(12, 17),
(13, 2),
(13, 6),
(13, 9),
(13, 14),
(14, 1),
(14, 3),
(14, 7),
(14, 15),
(15, 2),
(15, 5),
(15, 10),
(15, 19),
(16, 3),
(16, 6),
(16, 9),
(16, 16),
(17, 1),
(17, 7),
(17, 11),
(17, 18),
(18, 2),
(18, 5),
(18, 6),
(18, 14);

INSERT INTO `spotifyEd`.`related_artists` (`artist_id`, `related_artist_id`) VALUES
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 1),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 1),
(3, 2),
(3, 4),
(3, 5),
(3, 6),
(4, 1),
(4, 2),
(4, 3),
(4, 5),
(4, 6);

INSERT INTO `spotifyEd`.`user_favorite_albums` (`user_id`, `alb_id`)
VALUES
(1, 1),
(2, 3),
(3, 5),
(4, 7),
(5, 9),
(6, 11),
(7, 13),
(8, 15),
(9, 17),
(10, 19),
(11, 2),
(12, 4),
(13, 6),
(14, 8),
(15, 10),
(16, 12),
(17, 14),
(18, 16);

INSERT INTO `spotifyEd`.`user_favorite_songs` (`user_id`, `so_id`)
VALUES
(1, 21),
(2, 45),
(3, 32),
(4, 10),
(5, 57),
(6, 39),
(7, 18),
(8, 50),
(9, 27),
(10, 42),
(11, 11),
(12, 36),
(13, 48),
(14, 29),
(15, 16),
(16, 23),
(17, 55),
(18, 14);

INSERT INTO `spotifyEd`.`free_users` (`fu_id`, `fu_email`, `fu_password`, `fu_username`, `fu_birthdate`, `fu_genre`, `fu_country`, `fu_postcode`)
VALUES
(1, 'EmilySmith@example.com', 'password1', 'EmilySmith', '1990-05-15', 'male', 'United States', '12345'),
(2, 'JessicaBrown@example.com', 'password2', 'JessicaBrown', '1992-09-22', 'female', 'United Kingdom', 'AB12 3CD'),
(3, 'DanielJohnson@example.com', 'password3', 'DanielJohnson', '1988-12-01', 'other', 'Canada', 'X1A 2B3'),
(4, 'MichaelDavis@example.com', 'password4', 'MichaelDavis', '1995-07-10', 'male', 'Australia', '2000'),
(5, 'SarahWilson@example.com', 'password5', 'SarahWilson', '1999-03-28', 'female', 'Germany', '12345');

INSERT INTO `spotifyEd`.`playlist` (`pyl_id`, `pyl_title`, `pyl_nrOfSongs`, `pyl_create_date`, `pyl_delete_date`, `pyl_is_active`)
VALUES
(1, 'Iron Maiden - The Number of the Beast', 10, '2022-01-01', NULL, 1),
(2, 'Black Sabbath - Paranoid', 8, '2022-01-02', NULL, 1),
(3, 'Deep Purple - Machine Head', 9, '2022-01-03', NULL, 1),
(4, 'English Dogs - Forward Into Battle', 12, '2022-01-04', NULL, 1),
(5, 'Metallica - Master of Puppets', 11, '2022-01-05', NULL, 1),
(6, 'Led Zeppelin - IV', 7, '2022-01-06', NULL, 1),
(7, 'AC/DC - Back in Black', 9, '2022-01-07', NULL, 1),
(8, 'Judas Priest - Painkiller', 8, '2022-01-08', NULL, 1),
(9, 'Megadeth - Rust in Peace', 10, '2022-01-09', NULL, 1),
(10, 'Slayer - Reign in Blood', 9, '2022-01-10', NULL, 1),
(11, 'Pantera - Cowboys from Hell', 10, '2022-01-11', NULL, 1),
(12, 'Motorhead - Ace of Spades', 8, '2022-01-12', NULL, 1),
(13, 'Black Label Society - Sonic Brew', 11, '2022-01-13', NULL, 1),
(14, 'Ozzy Osbourne - Blizzard of Ozz', 9, '2022-01-14', NULL,  0);

INSERT INTO `spotifyEd`.`playlist_songs` (`pyl_id`, `so_id`, `pu_id`, `ps_add_date`)
VALUES
-- Playlist 1
(1, 21, 1, '2023-06-01'),
(1, 45, 1, '2023-06-02'),

-- Playlist 2
(2, 32, 2, '2023-06-03'),
(2, 10, 2, '2023-06-04'),

-- Playlist 3
(3, 57, 3, '2023-06-05'),
(3, 39, 3, '2023-06-06'),

-- Playlist 4
(4, 18, 4, '2023-06-07'),
(4, 53, 4, '2023-06-08'),

-- Playlist 5
(5, 30, 5, '2023-06-09'),
(5, 41, 5, '2023-06-10'),

-- Playlist 6
(6, 47, 6, '2023-06-11'),
(6, 12, 6, '2023-06-12'),

-- Playlist 7
(7, 24, 7, '2023-06-13'),
(7, 37, 7, '2023-06-14'),

-- Playlist 8
(8, 16, 8, '2023-06-15'),
(8, 42, 8, '2023-06-16'),

-- Playlist 9
(9, 56, 9, '2023-06-17'),
(9, 20, 9, '2023-06-18'),

-- Playlist 10
(10, 33, 10, '2023-06-19'),
(10, 27, 10, '2023-06-20'),

-- Playlist 11
(11, 19, 11, '2023-06-21'),
(11, 38, 11, '2023-06-22'),

-- Playlist 12
(12, 11, 12, '2023-06-23'),
(12, 49, 12, '2023-06-24'),

-- Playlist 13
(13, 23, 13, '2023-06-25'),
(13, 50, 13, '2023-06-26'),

-- Playlist 14
(14, 36, 14, '2023-06-27'),
(14, 14, 14, '2023-06-28');










