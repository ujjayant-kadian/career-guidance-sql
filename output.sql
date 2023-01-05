set @id := 2;

-- Stream Chosen:
SELECT a.stream
FROM choice_stream as a
INNER JOIN users as b ON a.choice_id=b.choice_id
WHERE b.user_id = @id;

-- Courses that you have to take:
SELECT c.course_name
FROM users as a
INNER JOIN choice_course as b ON a.choice_id=b.choice_id
INNER JOIN courses as c ON b.course_id=c.course_id
WHERE a.user_id = @id;

-- Course details:
SELECT e.course_name, c.course_duration, c.course_fee, d.institution
FROM users as a
INNER JOIN choice_course as b ON a.choice_id=b.choice_id
INNER JOIN course_details as c ON b.course_id=c.course_id
INNER JOIN course_institution as d ON b.course_id = d.course_id
INNER JOIN courses as e ON b.course_id = e.course_id
WHERE a.user_id = @id;

-- Career Options:
SELECT e.career_name
FROM users as a
INNER JOIN choice_career as d ON a.choice_id = d.choice_id
INNER JOIN careers as e ON d.career_id = e.career_id
WHERE a.user_id = @id;

-- Career Details
SELECT c.career_name, d.company, d.average_pay
FROM users as a
INNER JOIN choice_career as b ON a.choice_id = b.choice_id
INNER JOIN careers as c ON b.career_id = c.career_id
INNER JOIN career_details as d ON b.career_id = d.career_id
WHERE a.user_id = @id
