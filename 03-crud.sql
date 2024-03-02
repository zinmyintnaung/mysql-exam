--Insert a cat:
INSERT INTO cats (name, age) 
VALUES ('Blue Steele', 5);

--Insert multiple cats
INSERT INTO cats (name, age)
VALUE   ('Black King', 2), 
        ('White', 6), 
        ('Gray Hound', 3);

--Update record
UPDATE cats 
SET name='Short hair'
WHERE id=1;

--Delete record
DELETE FROM cats WHERE id=1;

-- Delete all rows in the cats table:
DELETE FROM cats;