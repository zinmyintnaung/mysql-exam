--CREATE VIEW
CREATE VIEW full_reviews AS
SELECT title, released_year, genre, rating, first_name, last_name FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;
 
-- NOW WE CAN TREAT THAT VIEW AS A VIRTUAL TABLE
SELECT * FROM full_reviews;
-- NO NEED TO JOIN THE TABLES AS ALREADY CREATED AS VIEW
SELECT 
    title, 
    AVG(rating),
    COUNT(rating) AS review_count
FROM full_reviews 
GROUP BY title HAVING COUNT(rating) > 1;

--UPDATING & DROPPING VIEW
CREATE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;
 
CREATE OR REPLACE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year DESC;
 
ALTER VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;
 
DROP VIEW ordered_series;

--ADDTIONAL SQL MODES
-- To See Current Modes:
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;
 
-- To Set Modes:
SET GLOBAL sql_mode = 'ENTER_MODES_WITH_NO_SPACES_AFTER_COMMAS';
SET SESSION sql_mode = 'ENTER_MODES_WITH_NO_SPACES_AFTER_COMMAS';


