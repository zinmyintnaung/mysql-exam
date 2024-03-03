--TESTING DATA
INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

--DISTINCT
SELECT DISTINCT (author_lname) FROM books;
SELECT DISTINCT CONCAT(author_fname,' ', author_lname) FROM books;

--ORDER BY [DEFAULT ORDER IS ASCENDING]
SELECT * FROM books ORDER BY author_lname;
SELECT * FROM books ORDER BY author_lname DESC;
SELECT * FROM books ORDER BY released_year;
SELECT book_id, author_fname, author_lname, pages FROM books ORDER BY 2 desc; -- 2 means second column, i.e., author_fname
SELECT book_id, author_fname, author_lname, pages FROM books ORDER BY author_lname, author_fname;

--LIKE, % means any number of chars, _ means one char
SELECT title, author_fname, author_lname, pages 
FROM books
WHERE author_fname LIKE '%da%';

SELECT title, author_fname, author_lname, pages 
FROM books
WHERE title LIKE '%:%';
 
SELECT * FROM books
WHERE author_fname LIKE '____';

SELECT * FROM books
WHERE author_fname LIKE '_a_';

-- To select books with '%' in their title:
SELECT * FROM books
WHERE title LIKE '%\%%';
 
-- To select books with an underscore '_' in title:
SELECT * FROM books
WHERE title LIKE '%\_%';

