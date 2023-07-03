DROP SCHEMA IF EXISTS bubonikaYoutube;

CREATE DATABASE IF NOT EXISTS bubonikaYoutube;
USE bubonikaYoutube;

CREATE TABLE IF NOT EXISTS `bubonikaYoutube`.`tag` (
  `tag_id` INT NOT NULL,
  `tag_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE INDEX `tag_id_UNIQUE` (`tag_id` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `bubonikaYoutube`.`user` (
  `us_id` INT NOT NULL,
  `us_email` VARCHAR(45) NOT NULL,
  `us_password` VARCHAR(45) NOT NULL,
  `us_username` VARCHAR(45) NOT NULL,
  `us_birthdate` DATE NOT NULL,
  `us_genre` ENUM('male', 'female', 'other') NOT NULL,
  `us_country` VARCHAR(45) NULL,
  `us_postalcode` VARCHAR(45) NULL,
  PRIMARY KEY (`us_id`),
  UNIQUE INDEX `us_id_UNIQUE` (`us_id` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `bubonikaYoutube`.`playlist` (
  `pl_id` INT NOT NULL,
  `pl_name` VARCHAR(45) NOT NULL,
  `pl_creationDate` DATETIME NOT NULL,
  `pl_status` ENUM('public', 'private') NOT NULL,
  `pl_pLCreatedBy` INT NOT NULL,
  PRIMARY KEY (`pl_id`),
  UNIQUE INDEX `pl_id_UNIQUE` (`pl_id` ASC) VISIBLE,
  INDEX `fk_playListCreatedBy_idx` (`pl_pLCreatedBy` ASC) VISIBLE,
  CONSTRAINT `fk_playListCreatedBy`
    FOREIGN KEY (`pl_pLCreatedBy`)
    REFERENCES `bubonikaYoutube`.`user` (`us_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `bubonikaYoutube`.`channel` (
  `ch_id` INT NOT NULL,
  `ch_description` VARCHAR(45) NULL,
  `ch_creationDate` DATETIME NOT NULL,
  `ch_createdByUser` INT NOT NULL,
  PRIMARY KEY (`ch_id`),
  UNIQUE INDEX `ch_id_UNIQUE` (`ch_id` ASC) VISIBLE,
  INDEX `fk_createdByUser_idx` (`ch_createdByUser` ASC) VISIBLE,
  CONSTRAINT `fk_createdByUser`
    FOREIGN KEY (`ch_createdByUser`)
    REFERENCES `bubonikaYoutube`.`user` (`us_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `bubonikaYoutube`.`video` (
  `vi_id` INT NOT NULL,
  `vi_description` VARCHAR(45) NULL,
  `vi_filename` VARCHAR(45) NOT NULL,
  `vi_duration` INT NOT NULL,
  `vi_thumbnail` VARCHAR(45) NOT NULL,
  `vi_numberOfReproductions` INT NOT NULL,
  `vi_likes` INT NOT NULL,
  `vi_dislikes` INT NOT NULL,
  `vi_state` ENUM('public', 'hidden', 'private') NOT NULL,
  `vi_publishedBy` INT NOT NULL,
  `vi_publishedDateTime` DATETIME NOT NULL,
  PRIMARY KEY (`vi_id`),
  UNIQUE INDEX `vi_id_UNIQUE` (`vi_id` ASC) VISIBLE,
  INDEX `fk_video_user_idx` (`vi_publishedBy` ASC) VISIBLE,
  CONSTRAINT `fk_video_user`
    FOREIGN KEY (`vi_publishedBy`)
    REFERENCES `bubonikaYoutube`.`user` (`us_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `bubonikaYoutube`.`comments` (
  `co_id` INT NOT NULL,
  `co_text` VARCHAR(100) NOT NULL,
  `co_dateTime` DATETIME NOT NULL,
  `co_fromVideo` INT NOT NULL,
  `co_madeByUser` INT NOT NULL,
  PRIMARY KEY (`co_id`),
  UNIQUE INDEX `co_id_UNIQUE` (`co_id` ASC) VISIBLE,
  INDEX `'fk_commentfromVideo_idx` (`co_fromVideo` ASC) VISIBLE,
  INDEX `'fk_cpommentMadeByUser'_idx` (`co_madeByUser` ASC) VISIBLE,
  CONSTRAINT `'fk_commentfromVideo`
    FOREIGN KEY (`co_fromVideo`)
    REFERENCES `bubonikaYoutube`.`video` (`vi_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `'fk_cpommentMadeByUser'`
    FOREIGN KEY (`co_madeByUser`)
    REFERENCES `bubonikaYoutube`.`user` (`us_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `bubonikaYoutube`.`user_subscription` (
  `subscription_id` INT NOT NULL AUTO_INCREMENT,
  `subscriber_id` INT NOT NULL,
  `channel_id` INT NOT NULL,
  `subscription_date` DATE NOT NULL,
  PRIMARY KEY (`subscription_id`),
  UNIQUE INDEX `subscription_id_UNIQUE` (`subscription_id` ASC) INVISIBLE,
  INDEX `fk_user_subscription_subscriber_idx` (`subscriber_id` ASC) INVISIBLE,
  INDEX `fk_user_subscription_channel_idx` (`channel_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_subscription_subscriber`
    FOREIGN KEY (`subscriber_id`)
    REFERENCES `bubonikaYoutube`.`user` (`us_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_subscription_channel`
    FOREIGN KEY (`channel_id`)
    REFERENCES `bubonikaYoutube`.`channel` (`ch_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `bubonikaYoutube`.`user_comment_interaction` (
  `interaction_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `comment_id` INT NOT NULL,
  `interaction_type` ENUM('like', 'dislike') NOT NULL,
  `interaction_datetime` DATETIME NOT NULL,
  PRIMARY KEY (`interaction_id`),
  UNIQUE INDEX `interaction_id_UNIQUE` (`interaction_id` ASC) INVISIBLE,
  INDEX `fk_user_comment_idx` (`user_id` ASC) INVISIBLE,
  INDEX `fk_comment_interaction_idx` (`comment_id` ASC) INVISIBLE,
  CONSTRAINT `fk_user_comment_interaction_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `bubonikaYoutube`.`user` (`us_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_comment_interaction_comment`
    FOREIGN KEY (`comment_id`)
    REFERENCES `bubonikaYoutube`.`comments` (`co_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `bubonikaYoutube`.`user_video_interaction` (
  `uvi_id` INT NOT NULL AUTO_INCREMENT,
  `uvi_userId` INT NOT NULL,
  `uvi_videoId` INT NOT NULL,
  `uvi_likeOrDislike` ENUM('like', 'dislike') NOT NULL,
  `uvi_actionDatetime` DATETIME NOT NULL,
  PRIMARY KEY (`uvi_id`),
  UNIQUE INDEX `interaction_id_UNIQUE` (`uvi_id` ASC) INVISIBLE,
  INDEX `fk_user_video_idx` (`uvi_userId` ASC) INVISIBLE,
  INDEX `fk_video_interaction_idx` (`uvi_videoId` ASC) INVISIBLE,
  CONSTRAINT `fk_user_video_interaction_user`
    FOREIGN KEY (`uvi_userId`)
    REFERENCES `bubonikaYoutube`.`user` (`us_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_video_interaction_video`
    FOREIGN KEY (`uvi_videoId`)
    REFERENCES `bubonikaYoutube`.`video` (`vi_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `bubonikaYoutube`.`video-tag` (
  `vt_video_id` INT NOT NULL,
  `vt_tag_id` INT NOT NULL,
  PRIMARY KEY (`vt_video_id`, `vt_tag_id`),
  INDEX `fk_video_tag_tag_idx` (`vt_video_id` ASC) VISIBLE,
  INDEX `fk_video_tag_tag_idx1` (`vt_tag_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_tag_video`
    FOREIGN KEY (`vt_video_id`)
    REFERENCES `bubonikaYoutube`.`video` (`vi_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_tag_tag`
    FOREIGN KEY (`vt_tag_id`)
    REFERENCES `bubonikaYoutube`.`tag` (`tag_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO `bubonikaYoutube`.`tag` (`tag_id`, `tag_name`) VALUES
(1, 'Music'),
(2, 'Tutorial'),
(3, 'Funny'),
(4, 'Sports'),
(5, 'Food');

INSERT INTO `bubonikaYoutube`.`user` (`us_id`, `us_email`, `us_password`, `us_username`, `us_birthdate`, `us_genre`, `us_country`, `us_postalcode`) VALUES
(1, 'ade@example.com', 'password123', 'AdeOkafor', '1990-05-15', 'male', 'Nigeria', '23401'),
(2, 'lucia@example.com', 'pass123', 'LuciaKamau', '1988-09-22', 'female', 'Kenya', '00505'),
(3, 'suleiman@example.com', 'mikepass', 'SuleimanMusa', '1995-02-10', 'male', 'Nigeria', '900001'),
(4, 'adenike@example.com', 'password456', 'AdenikeAdeleke', '1992-07-08', 'female', 'Nigeria', '23401'),
(5, 'kofi@example.com', 'alexpass', 'KofiAddo', '1993-11-30', 'male', 'Ghana', '00233'),
(6, 'abdul@example.com', 'passabdul', 'AbdulMohammed', '1987-03-20', 'male', 'Kenya', '00100'),
(7, 'lucy@example.com', 'lucypass', 'LucyKamau', '1991-09-12', 'female', 'Kenya', '00505'),
(8, 'kwame@example.com', 'kwamepass', 'KwameAsante', '1994-06-18', 'male', 'Ghana', '00233'),
(9, 'aminata@example.com', 'aminatapass', 'AminataSow', '1993-12-05', 'female', 'Senegal', '10000'),
(10, 'oliver@example.com', 'oliverpass', 'OliverMukasa', '1992-02-25', 'male', 'Uganda', '256'),
(11, 'adeola@example.com', 'adeolapass', 'AdeolaOkafor', '1990-08-03', 'female', 'Nigeria', '23401'),
(12, 'itumeleng@example.com', 'itumelengpass', 'ItumelengModise', '1996-04-15', 'male', 'South Africa', '2000'),
(13, 'ayesha@example.com', 'ayeshapass', 'AyeshaIbrahim', '1989-11-27', 'female', 'Egypt', '11511'),
(14, 'ibrahim@example.com', 'ibrahimpass', 'IbrahimDiop', '1992-07-20', 'male', 'Senegal', '22000'),
(15, 'ruth@example.com', 'ruthpass', 'RuthKoroma', '1994-03-12', 'female', 'Sierra Leone', '232'),
(16, 'thabo@example.com', 'thabopass', 'ThaboMolefe', '1991-09-04', 'male', 'South Africa', '1609'),
(17, 'chiamaka@example.com', 'chiamakapass', 'ChiamakaEze', '1993-06-28', 'female', 'Nigeria', '500102'),
(18, 'musoke@example.com', 'musokepass', 'MusokeKamau', '1990-12-15', 'male', 'Uganda', '256'),
(19, 'zainab@example.com', 'zainabpass', 'ZainabBello', '1988-04-03', 'female', 'Nigeria', '900001'),
(20, 'keita@example.com', 'keitapass', 'KeitaTraoré', '1992-11-10', 'male', 'Mali', '22301');

INSERT INTO `bubonikaYoutube`.`playlist` (`pl_id`, `pl_name`, `pl_creationDate`, `pl_status`, `pl_pLCreatedBy`) VALUES
(1, 'Awesome Mix', '2023-01-01 09:30:00', 'public', 1),
(2, 'Relaxing Vibes', '2023-02-05 15:45:00', 'private', 3),
(3, 'Workout Jams', '2023-03-10 18:20:00', 'public', 2),
(4, 'Chill Out', '2023-04-15 12:10:00', 'private', 4),
(5, 'Throwback Hits', '2023-05-20 16:55:00', 'public', 5),
(6, 'Party Playlist', '2023-06-25 20:40:00', 'public', 1),
(7, 'Road Trip Tunes', '2023-07-30 14:35:00', 'private', 3),
(8, 'Country Favorites', '2023-08-05 11:25:00', 'public', 2),
(9, 'R&B Soul', '2023-09-10 17:15:00', 'private', 4),
(10, 'Hip Hop Hype', '2023-10-15 13:05:00', 'public', 5),
(11, 'Acoustic Sessions', '2023-11-20 19:50:00', 'public', 1),
(12, 'Pop Extravaganza', '2023-12-25 08:15:00', 'private', 3),
(13, 'Indie Gems', '2024-01-01 14:30:00', 'public', 2),
(14, 'Rock Anthems', '2024-02-05 10:45:00', 'private', 4),
(15, 'EDM Party Mix', '2024-03-10 16:20:00', 'public', 5),
(16, 'Latin Heat', '2024-04-15 12:10:00', 'public', 1),
(17, 'Jazz Lounge', '2024-05-20 15:55:00', 'private', 3),
(18, 'Classical Masterpieces', '2024-06-25 19:40:00', 'public', 2),
(19, 'Reggae Vibes', '2024-07-30 13:35:00', 'private', 4),
(20, 'Metal Mayhem', '2024-08-05 10:25:00', 'public', 5);

INSERT INTO `bubonikaYoutube`.`channel` (`ch_id`, `ch_description`, `ch_creationDate`, `ch_createdByUser`) VALUES
(1, 'Technology Channel', '2023-06-13 09:20:00', 3),
(2, 'Cooking Channel', '2023-06-13 10:45:00', 7),
(3, 'Fitness Channel', '2023-06-13 12:15:00', 5),
(4, 'Travel Channel', '2023-06-13 14:30:00', 9),
(5, 'Music Channel', '2023-06-13 16:40:00', 2),
(6, 'Fashion Channel', '2023-06-13 18:55:00', 8),
(7, 'Gaming Channel', '2023-06-13 20:10:00', 6),
(8, 'Art Channel', '2023-06-13 22:25:00', 4),
(9, 'Science Channel', '2023-06-14 08:30:00', 1),
(10, 'Fitness Channel', '2023-06-14 10:40:00', 7),
(11, 'Travel Channel', '2023-06-14 12:55:00', 3),
(12, 'Music Channel', '2023-06-14 15:10:00', 5),
(13, 'Fashion Channel', '2023-06-14 17:25:00', 9),
(14, 'Gaming Channel', '2023-06-14 19:40:00', 2),
(15, 'Art Channel', '2023-06-14 21:55:00', 8);

INSERT INTO `bubonikaYoutube`.`video` (`vi_id`, `vi_description`, `vi_filename`, `vi_duration`, `vi_thumbnail`, `vi_numberOfReproductions`, `vi_likes`, `vi_dislikes`, `vi_state`, `vi_publishedBy`, `vi_publishedDateTime`) VALUES
(1, 'Funny Cat Compilation', 'funny_cats.mp4', 180, 'cat_thumbnail.jpg', 5000, 250, 10, 'public', 4, '2023-06-13 09:00:00'),
(2, 'Travel Vlog: Exploring Bali', 'bali_travel_vlog.mp4', 540, 'bali_thumbnail.jpg', 10000, 800, 20, 'public', 9, '2023-06-13 10:30:00'),
(3, 'Cooking Tutorial: Chocolate Cake', 'chocolate_cake_tutorial.mp4', 360, 'cake_thumbnail.jpg', 7500, 400, 15, 'public', 6, '2023-06-13 12:15:00'),
(4, 'Guitar Lesson: Beginner Basics', 'guitar_lesson_beginner.mp4', 480, 'guitar_thumbnail.jpg', 3000, 150, 5, 'public', 2, '2023-06-13 14:00:00'),
(5, 'Fitness Workout: HIIT Training', 'hiit_workout.mp4', 300, 'fitness_thumbnail.jpg', 6000, 300, 10, 'public', 7, '2023-06-13 16:30:00'),
(6, 'Art Tutorial: Watercolor Techniques', 'watercolor_tutorial.mp4', 420, 'art_thumbnail.jpg', 4000, 250, 8, 'public', 5, '2023-06-13 18:45:00'),
(7, 'Funny Dog Compilation', 'funny_dogs.mp4', 240, 'dog_thumbnail.jpg', 8000, 500, 12, 'public', 8, '2023-06-13 20:20:00'),
(8, 'Science Documentary: The Universe', 'universe_documentary.mp4', 720, 'science_thumbnail.jpg', 9000, 700, 18, 'public', 3, '2023-06-13 22:00:00'),
(9, 'Music Performance: Jazz Trio', 'jazz_trio_performance.mp4', 600, 'jazz_thumbnail.jpg', 4500, 200, 6, 'public', 1, '2023-06-14 08:10:00'),
(10, 'Travel Vlog: Exploring Paris', 'paris_travel_vlog.mp4', 480, 'paris_thumbnail.jpg', 7000, 600, 15, 'public', 9, '2023-06-14 10:00:00'),
(11, 'Cooking Tutorial: Pizza Recipe', 'pizza_recipe_tutorial.mp4', 360, 'pizza_thumbnail.jpg', 5500, 350, 10, 'public', 6, '2023-06-14 12:30:00'),
(12, 'Guitar Lesson: Advanced Techniques', 'guitar_lesson_advanced.mp4', 600, 'guitar_thumbnail.jpg', 2500, 120, 4, 'public', 2, '2023-06-14 14:45:00'),
(13, 'Fitness Workout: Yoga Flow', 'yoga_flow_workout.mp4', 420, 'fitness_thumbnail.jpg', 5500, 280, 8, 'public', 7, '2023-06-14 16:20:00'),
(14, 'Art Tutorial: Acrylic Painting', 'acrylic_painting_tutorial.mp4', 480, 'art_thumbnail.jpg', 3500, 200, 6, 'public', 5, '2023-06-14 18:00:00'),
(15, 'Funny Animal Compilation', 'funny_animals.mp4', 300, 'animal_thumbnail.jpg', 7000, 450, 10, 'public', 8, '2023-06-14 20:15:00'),
(16, 'Science Documentary: The Human Brain', 'brain_documentary.mp4', 660, 'science_thumbnail.jpg', 8000, 600, 16, 'public', 3, '2023-06-14 22:30:00'),
(17, 'Music Performance: Classical Concert', 'classical_concert_performance.mp4', 780, 'classical_thumbnail.jpg', 5000, 300, 10, 'public', 1, '2023-06-15 08:40:00'),
(18, 'Travel Vlog: Exploring Tokyo', 'tokyo_travel_vlog.mp4', 600, 'tokyo_thumbnail.jpg', 9000, 750, 20, 'public', 9, '2023-06-15 10:55:00'),
(19, 'Cooking Tutorial: Sushi Making', 'sushi_making_tutorial.mp4', 420, 'sushi_thumbnail.jpg', 6500, 400, 12, 'public', 6, '2023-06-15 12:20:00'),
(20, 'Guitar Lesson: Fingerstyle Techniques', 'guitar_lesson_fingerstyle.mp4', 540, 'guitar_thumbnail.jpg', 3500, 180, 6, 'public', 2, '2023-06-15 14:35:00'),
(21, 'Fitness Workout: Strength Training', 'strength_training_workout.mp4', 360, 'fitness_thumbnail.jpg', 6000, 350, 10, 'public', 7, '2023-06-15 16:50:00'),
(22, 'Art Tutorial: Oil Painting Techniques', 'oil_painting_tutorial.mp4', 480, 'art_thumbnail.jpg', 4000, 250, 8, 'public', 5, '2023-06-15 18:55:00'),
(23, 'Funny Bird Compilation', 'funny_birds.mp4', 240, 'bird_thumbnail.jpg', 8000, 500, 12, 'public', 8, '2023-06-15 20:10:00'),
(24, 'Science Documentary: Space Exploration', 'space_documentary.mp4', 720, 'science_thumbnail.jpg', 9000, 700, 18, 'public', 3, '2023-06-15 22:25:00'),
(25, 'Music Performance: Rock Band Live', 'rock_band_performance.mp4', 600, 'rock_thumbnail.jpg', 4500, 200, 6, 'public', 1, '2023-06-16 08:30:00'),
(26, 'Travel Vlog: Exploring New York City', 'nyc_travel_vlog.mp4', 480, 'nyc_thumbnail.jpg', 7000, 600, 15, 'public', 9, '2023-06-16 10:45:00'),
(27, 'Cooking Tutorial: Pasta Carbonara Recipe', 'carbonara_tutorial.mp4', 360, 'pasta_thumbnail.jpg', 5500, 350, 10, 'public', 6, '2023-06-16 12:55:00'),
(28, 'Guitar Lesson: Jazz Improvisation', 'guitar_lesson_jazz.mp4', 600, 'guitar_thumbnail.jpg', 2500, 120, 4, 'public', 2, '2023-06-16 14:58:00'),
(29, 'Fitness Workout: Pilates Routine', 'pilates_workout.mp4', 420, 'fitness_thumbnail.jpg', 5500, 280, 8, 'public', 7, '2023-06-16 16:59:00'),
(30, 'Art Tutorial: Drawing Portraits', 'portrait_drawing_tutorial.mp4', 480, 'art_thumbnail.jpg', 3500, 200, 6, 'public', 5, '2023-06-16 18:57:00');

INSERT INTO `bubonikaYoutube`.`comments` (`co_id`, `co_text`, `co_dateTime`, `co_fromVideo`, `co_madeByUser`) VALUES
(1, 'Great video!', '2023-06-01 10:23:45', 11, 1),
(2, 'Awesome content!', '2023-06-02 15:47:22', 12, 2),
(3, 'I learned so much from this video.', '2023-06-03 09:15:10', 13, 3),
(4, 'Nice work!', '2023-06-04 17:30:12', 14, 4),
(5, 'This video is inspiring.', '2023-06-05 12:08:33', 15, 5),
(6, 'Very informative!', '2023-06-06 14:55:19', 16, 6),
(7, 'Loved the visuals!', '2023-06-07 11:10:50', 17, 7),
(8, 'Great job explaining.', '2023-06-08 09:27:57', 18, 8),
(9, 'Impressive video production.', '2023-06-09 16:40:25', 19, 9),
(10, 'This is exactly what I needed.', '2023-06-10 13:55:38', 20, 10),
(11, 'Well done!', '2023-06-11 08:20:14', 21, 11),
(12, 'Thank you for sharing.', '2023-06-12 17:09:03', 22, 12),
(13, 'I enjoyed watching this.', '2023-06-13 10:35:49', 23, 13),
(14, 'Very insightful.', '2023-06-14 15:15:02', 24, 14),
(15, 'Keep up the good work!', '2023-06-15 09:45:27', 25, 15);

INSERT INTO `bubonikaYoutube`.`user_subscription` (`subscription_id`, `subscriber_id`, `channel_id`, `subscription_date`) VALUES
(1, 1, 1, '2023-06-13'),
(2, 2, 2, '2023-06-13'),
(3, 3, 3, '2023-06-13'),
(4, 4, 4, '2023-06-13'),
(5, 5, 5, '2023-06-13'),
(6, 6, 6, '2023-06-13'),
(7, 7, 7, '2023-06-13'),
(8, 8, 8, '2023-06-13'),
(9, 9, 9, '2023-06-14'),
(10, 10, 10, '2023-06-14'),
(11, 11, 11, '2023-06-14'),
(12, 12, 12, '2023-06-14'),
(13, 13, 13, '2023-06-14'),
(14, 14, 14, '2023-06-14'),
(15, 15, 15, '2023-06-14'),
(16, 16, 1, '2023-06-14'),
(17, 17, 2, '2023-06-14');

INSERT INTO `bubonikaYoutube`.`user_comment_interaction` (`interaction_id`, `user_id`, `comment_id`, `interaction_type`, `interaction_datetime`) VALUES
(1, 1, 1, 'like', '2023-06-01 10:25:15'),
(2, 2, 2, 'like', '2023-06-02 15:50:27'),
(3, 3, 3, 'like', '2023-06-03 09:18:55'),
(4, 4, 4, 'like', '2023-06-04 17:32:49'),
(5, 5, 5, 'like', '2023-06-05 12:10:57'),
(6, 6, 6, 'like', '2023-06-06 15:00:42'),
(7, 7, 7, 'like', '2023-06-07 11:12:36'),
(8, 8, 8, 'like', '2023-06-08 09:30:14'),
(9, 9, 9, 'like', '2023-06-09 16:42:59'),
(10, 10, 10, 'like', '2023-06-10 14:00:23'),
(11, 11, 11, 'like', '2023-06-11 08:25:10'),
(12, 12, 12, 'like', '2023-06-12 17:12:48'),
(13, 13, 13, 'like', '2023-06-13 10:40:35'),
(14, 14, 14, 'like', '2023-06-14 15:18:19'),
(15, 15, 15, 'like', '2023-06-15 09:50:03'),
(16, 16, 1, 'dislike', '2023-06-01 10:30:12'),
(17, 17, 2, 'dislike', '2023-06-02 16:00:45'),
(18, 18, 3, 'dislike', '2023-06-03 09:45:22'),
(19, 19, 4, 'dislike', '2023-06-04 18:10:08'),
(20, 20, 5, 'dislike', '2023-06-05 12:45:36');

INSERT INTO `bubonikaYoutube`.`user_video_interaction` (`uvi_id`, `uvi_userId`, `uvi_videoId`, `uvi_likeOrDislike`, `uvi_actionDatetime`) VALUES
(1, 1, 1, 'like', '2023-06-13 09:05:32'),
(2, 2, 1, 'like', '2023-06-13 09:08:41'),
(3, 3, 1, 'dislike', '2023-06-13 09:12:19'),
(4, 4, 2, 'like', '2023-06-13 10:35:16'),
(5, 5, 2, 'dislike', '2023-06-13 10:40:55'),
(6, 6, 3, 'like', '2023-06-13 12:25:09'),
(7, 7, 3, 'like', '2023-06-13 12:27:58'),
(8, 8, 3, 'like', '2023-06-13 12:30:41'),
(9, 9, 4, 'dislike', '2023-06-13 14:10:27'),
(10, 10, 4, 'dislike', '2023-06-13 14:15:39'),
(11, 11, 5, 'like', '2023-06-13 16:40:55'),
(12, 12, 5, 'dislike', '2023-06-13 16:45:22'),
(13, 13, 6, 'like', '2023-06-13 19:05:12'),
(14, 14, 6, 'like', '2023-06-13 19:07:51'),
(15, 15, 7, 'dislike', '2023-06-13 21:30:19'),
(16, 16, 7, 'dislike', '2023-06-13 21:35:47'),
(17, 17, 8, 'like', '2023-06-13 23:50:10'),
(18, 18, 8, 'like', '2023-06-13 23:52:49');

INSERT INTO `bubonikaYoutube`.`video-tag` (`vt_video_id`, `vt_tag_id`) VALUES
(1, 3),
(1, 5),
(2, 1),
(2, 4),
(3, 2),
(3, 5),
(4, 1),
(5, 4),
(6, 2),
(7, 3),
(8, 5);