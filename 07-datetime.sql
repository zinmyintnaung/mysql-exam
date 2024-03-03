-- CREATE TABLES & IMPORT DATA FIRST
CREATE TABLE people (
	name VARCHAR(100),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME
);
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00');
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Lulu', '1985-04-11', '9:45:10', '1985-04-11 9:45:10');
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Hazel', CURDATE(), CURTIME(), NOW());

--Date functions
SELECT CURTIME();
SELECT CURDATE();
SELECT NOW();
--get day, day of the week, day of the year
SELECT 
    birthdate,
    DAY(birthdate),
    DAYOFWEEK(birthdate),
    DAYOFYEAR(birthdate)
FROM people;
--get full month name
SELECT 
    birthdate,
    MONTHNAME(birthdate),
    YEAR(birthdate)
FROM people;
--get month, day, hour, minute from datetime 
SELECT 
    birthdt,
    MONTH(birthdt),
    DAY(birthdt),
    HOUR(birthdt),
    MINUTE(birthdt)
FROM people;

--Date formatting using DATE_FORMAT
--MySQL Docs: https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, '%H:%i') FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, 'BORN ON: %r') FROM people;
--Date Math
SELECT birthdate, DATEDIFF(CURDATE(), birthdate) FROM people;
SELECT birthdate, birthdate + INTERVAL 18 YEAR FROM people;
SELECT birthdate, YEAR(CURDATE()) - YEAR(birthdate)  FROM people;

--Defining default TIMESTAMP for create & update
CREATE TABLE captions (
  text VARCHAR(150),
  created_at TIMESTAMP default CURRENT_TIMESTAMP,
  updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);