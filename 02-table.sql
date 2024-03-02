
--Creating Tables:
CREATE TABLE cats (
    id INT(11),
    name VARCHAR(50) NOT NULL DEFAULT 'unnamed',
    age INT
);
 
CREATE TABLE dogs (
    id INT(11) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(50),
    breed VARCHAR(50),
    age INT NOT NULL DEFAULT 99 
);

--Accessing table data
SHOW tables;

--List all columns of a table
SHOW COLUMNS FROM <table-name>;

--List table schema
DESC <table-name>;

--To drop a table:
DROP TABLE <table-name>;



