--stream table
CREATE TABLE `careergudiance`.`choice_stream` (
`choice_id` INT NOT NULL,
`stream` VARCHAR(45) NOT NULL,
PRIMARY KEY (`choice_id`),
UNIQUE INDEX `stream_UNIQUE` (`stream` ASC) VISIBLE);

--users
CREATE TABLE `careergudiance`.`users` (
`user_id` INT NOT NULL,
`first_name` VARCHAR(45) NOT NULL,
`last_name` VARCHAR(45) NULL,
`qualification` VARCHAR(45) NULL,
`gender` VARCHAR(45) NOT NULL,
`dob` DATE NOT NULL,
`choice_id` INT NOT NULL,
PRIMARY KEY (`user_id`),
UNIQUE INDEX `choice_id_UNIQUE` (`choice_id` ASC) VISIBLE,
CONSTRAINT `choice_id`
FOREIGN KEY (`choice_id`)
REFERENCES `careergudiance`.`choice_stream` (`choice_id`)
ON DELETE RESTRICT
ON UPDATE RESTRICT);
ALTER TABLE `careergudiance`.`users`
DROP COLUMN `qualification`;

--user_qualification
CREATE TABLE `careergudiance`.`user_qualification` (
`user_id` INT NOT NULL,
`qualification` VARCHAR(45) NOT NULL,
PRIMARY KEY (`user_id`),
CONSTRAINT `user_qualification`
FOREIGN KEY (`user_id`)
REFERENCES `careergudiance`.`users` (`user_id`)
ON DELETE RESTRICT
ON UPDATE RESTRICT);

--user_phone number
CREATE TABLE `careergudiance`.`user_phone` (
`user_id` INT NOT NULL,
`phone_number` VARCHAR(45) NOT NULL,
PRIMARY KEY (`user_id`, `phone_number`),
CONSTRAINT `user_phone`
FOREIGN KEY (`user_id`)
REFERENCES `careergudiance`.`users` (`user_id`)
ON DELETE RESTRICT
ON UPDATE RESTRICT);
ALTER TABLE `careergudiance`.`user_phone`
CHANGE COLUMN `phone_number` `phone_number` INT NOT NULL ;

--courses
CREATE TABLE `careergudiance`.`courses` (
`course_id` INT NOT NULL,
`course_name` VARCHAR(45) NOT NULL,
PRIMARY KEY (`course_id`));

--choice_courses
CREATE TABLE `careergudiance`.`choice_course` (
`choice_id` INT NOT NULL,
`course_id` INT NOT NULL,
PRIMARY KEY (`course_id`, `choice_id`),
INDEX `choice_courses_idx` (`choice_id` ASC) VISIBLE,
CONSTRAINT `choice_courses`
FOREIGN KEY (`choice_id`)
REFERENCES `careergudiance`.`courses` (`course_id`)
ON DELETE RESTRICT
ON UPDATE RESTRICT);
ALTER TABLE `careergudiance`.`choice_course`
DROP FOREIGN KEY `choice_courses`;
ALTER TABLE `careergudiance`.`choice_course`
ADD INDEX `choice_courses_idx` (`choice_id` ASC) VISIBLE,
DROP INDEX `choice_courses_idx` ;
;
ALTER TABLE `careergudiance`.`choice_course`
ADD CONSTRAINT `choice_courses`
FOREIGN KEY (`choice_id`)
REFERENCES `careergudiance`.`choice_stream` (`choice_id`)
ON DELETE RESTRICT
ON UPDATE RESTRICT,
ADD CONSTRAINT `courses_name`
FOREIGN KEY (`course_id`)
REFERENCES `careergudiance`.`courses` (`course_id`)
ON DELETE RESTRICT
ON UPDATE RESTRICT;

--course institution
CREATE TABLE `careergudiance`.`course_institution` (
`course_id` INT NOT NULL,
`institution` VARCHAR(45) NOT NULL,
PRIMARY KEY (`course_id`),
CONSTRAINT `course_institution`
FOREIGN KEY (`course_id`)
REFERENCES `careergudiance`.`courses` (`course_id`)
ON DELETE RESTRICT
ON UPDATE RESTRICT);

--course details
CREATE TABLE `careergudiance`.`course_details` (
`course_id` INT NOT NULL,
`course_duration(in hours)` INT NOT NULL,
`course_fee` INT NULL,
PRIMARY KEY (`course_id`),
CONSTRAINT `course_coursedetails`
FOREIGN KEY (`course_id`)
REFERENCES `careergudiance`.`courses` (`course_id`)
ON DELETE RESTRICT
ON UPDATE RESTRICT);

--careers
CREATE TABLE `careergudiance`.`careers` (
`career_id` INT NOT NULL,
`career_name` VARCHAR(45) NOT NULL,
PRIMARY KEY (`career_id`));

--choice_career
CREATE TABLE `careergudiance`.`choice_career` (
`choice_id` INT NOT NULL,
`career_id` INT NOT NULL,
PRIMARY KEY (`choice_id`, `career_id`),
INDEX `career_careername_idx` (`career_id` ASC) VISIBLE,
CONSTRAINT `choice_choicestream`
FOREIGN KEY (`choice_id`)
REFERENCES `careergudiance`.`choice_stream` (`choice_id`)
ON DELETE RESTRICT
ON UPDATE RESTRICT,
CONSTRAINT `career_careername`
FOREIGN KEY (`career_id`)
REFERENCES `careergudiance`.`careers` (`career_id`)
ON DELETE RESTRICT
ON UPDATE RESTRICT);

--career_details
CREATE TABLE `careergudiance`.`career_details` (
`career_id` INT NOT NULL,
`career_name` VARCHAR(45) NOT NULL,
`average_pay` INT NOT NULL,
PRIMARY KEY (`career_id`, `career_name`),
CONSTRAINT `careerdetails_careername`
FOREIGN KEY (`career_id`)
REFERENCES `careergudiance`.`careers` (`career_id`)
ON DELETE RESTRICT
ON UPDATE RESTRICT);
ALTER TABLE `careergudiance`.`user_phone`
CHANGE COLUMN `phone_number` `phone_number` BIGINT(10) NOT NULL ;
ALTER TABLE `careergudiance`.`user_qualification`
DROP PRIMARY KEY,
ADD PRIMARY KEY (`user_id`, `qualification`);
;
ALTER TABLE `careergudiance`.`career_details`
CHANGE COLUMN `career_name` `company` VARCHAR(45) NOT NULL ;
ALTER TABLE `careergudiance`.`course_details`
CHANGE COLUMN `course_duration(in hours)` `course_duration` INT NOT NULL ;

