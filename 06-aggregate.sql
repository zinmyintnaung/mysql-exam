--COUNT
SELECT COUNT(*) FROM books;
SELECT COUNT(author_lname) FROM books;
SELECT COUNT(DISTINCT author_lname) FROM books;
SELECT COUNT(author_lname) FROM books WHERE title LIKE '%the%';

--GROUP BY (Single column)
--CASE: get the list of total number of books by each released year
SELECT 
    released_year,
    COUNT(*) AS total
FROM
    books
GROUP BY released_year ORDER BY total DESC;

--MIN/MAX
SELECT MAX(pages) FROM books;
SELECT MIN(author_fname), MAX(author_fname) FROM books;

--SUBQUERIES
--CASE: books that have max pages
SELECT title, pages
FROM books
WHERE pages = (SELECT MAX(pages) FROM books);
--same can be achieved by limiting to only one record (BUT if two books have same pages, only one record will be return)
SELECT title, pages FROM books order by pages desc LIMIT 1;
--CASE: books that released earliest
SELECT title, released_year
FROM books
WHERE released_year = (SELECT MIN(released_year) FROM books);
--CASE: author who wrote longest book with most pages
SELECT CONCAT(author_fname, ' ', author_lname) AS author
FROM books
WHERE pages = (SELECT MAX(pages) FROM books);

--GROUP BY (Multiple columns)
--CASE: get the list of total number of books written by each author (two groups created and same last name will be considered)
SELECT author_fname, author_lname, COUNT(*) AS total
FROM books
GROUP BY author_fname, author_lname ORDER BY total;
--CASE: get the list of total number of books written by each author's full name
SELECT 
    CONCAT(author_fname, ' ', author_lname) AS author,
    COUNT(*) AS total
FROM
    books
GROUP BY author ORDER BY total DESC;

--GROUP BY WITH AGGREGATE FUNCTIONS
--CASE: get earliest, latest and longest book by each author's
SELECT author_fname, author_lname, MIN(released_year) AS earliest, MAX(released_year) AS latest, MAX(pages) AS longest_book
FROM books
GROUP BY author_fname, author_lname ORDER BY author_fname;
--CASE: get earliest, latest and total pages of book by each author's
SELECT author_fname, author_lname, MIN(released_year) AS earliest, 
COUNT(*), MAX(released_year) AS latest, SUM(pages) AS total_pages
FROM books
GROUP BY author_fname, author_lname ORDER BY author_fname;
--CASE: get earliest, latest, total number of books written and total pages by each author's
SELECT author_fname, author_lname, MIN(released_year) AS earliest, 
COUNT(*) AS total_no_books, MAX(released_year) AS latest, SUM(pages) AS total_pages
FROM books
GROUP BY author_fname, author_lname ORDER BY total_no_books DESC;
--CASE: get the average page of all the books
SELECT AVG(pages) FROM books;
--CASE: get author first name, total number of books written and average pages by each author
SELECT author_fname, COUNT(*) AS total_no_books, AVG(pages) 
FROM books 
GROUP BY author_fname ORDER BY total_no_books DESC;
