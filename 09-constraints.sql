--UNIQUE Constraints
CREATE TABLE contacts (
	name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);
 
INSERT INTO contacts (name, phone)
VALUES ('billybob', '8781213455');
-- This insert would result in an error:
INSERT INTO contacts (name, phone)
VALUES ('billybob', '8781213455');

--UNIQUE Combination of columns
CREATE TABLE companies (
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    CONSTRAINT name_address UNIQUE (name , address)
);

--CHECK, only accept if certain CHECK pass
CREATE TABLE users (
	username VARCHAR(20) NOT NULL,
    age INT CHECK (age > 0)
);

CREATE TABLE palindromes (
  word VARCHAR(100) CHECK(REVERSE(word) = word)
);
--CHECK using name constraints
CREATE TABLE users2 (
    username VARCHAR(20) NOT NULL,
    age INT,
    CONSTRAINT age_not_negative CHECK (age >= 0)
);
 
CREATE TABLE houses (
  purchase_price INT NOT NULL,
  sale_price INT NOT NULL,
  CONSTRAINT sprice_gt_pprice CHECK(sale_price >= purchase_price)
);

--ADD COLUMN
ALTER TABLE companies
ADD COLUMN employee_count INT NOT NULL DEFAULT 1;
--DROP COLUMN
ALTER TABLE companies DROP COLUMN phone;
--RENAME TABLE
RENAME TABLE companies to suppliers;
ALTER TABLE suppliers RENAME TO companies;
--RENAME COLUMN
ALTER TABLE companies
RENAME COLUMN name TO company_name;
--MODIFY COLUMN DEFINITION
ALTER TABLE companies
MODIFY company_name VARCHAR(100) DEFAULT 'unknown';
--CHANGE, this allows to rename the column and change definition by providing existing column name, new column name and data definition
ALTER TABLE suppliers
CHANGE business biz_name VARCHAR(50);

--ADD/DROP CONSTRAINT to existing table
ALTER TABLE houses 
ADD CONSTRAINT positive_pprice CHECK (purchase_price >= 0);
ALTER TABLE houses DROP CONSTRAINT positive_pprice;
