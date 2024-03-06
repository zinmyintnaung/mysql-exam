--TRIGGERS (Syntax)
SHOW triggers;

-- CREATE TRIGGERS trigger_name
--  trigger_time trigger_event ON table_name FOR EACH ROW
--  BEGIN
--      execution_statements
--  END;

--trigger_time can be BEFORE/AFTER
--trigger_event can be INSERT/UPDATE/DELETE
--execution_statements can be IF/ELSE check to perform some tasks

--CASE: create a trigger to allow only age is greater than 18 years before entering into database table
DELIMITER $$
CREATE TRIGGER must_be_adult_check
    BEFORE INSERT ON users FOR EACH ROW
    BEGIN
        IF NEW.age < 18 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Age must be 18 yr and above.';
        END IF;
    END;
$$
DELIMITER ; --SWITCH BACK DELIMITER TO SEMI-COLON

--CASE: prevent self-follows on social DB
DELIMITER $$
CREATE TRIGGER prevent_self_follows
    BEFORE INSERT ON follows FOR EACH ROW
    BEGIN
        IF NEW.follower_id = NEW.followee_id  THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Follower and followee cannot be same user.';
        END IF;
    END;
$$
DELIMITER ;

--CASE: Log the data for unfollow event when record delete inside follows table, create unfollow table first
CREATE TABLE unfollows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(follower_id) REFERENCES users(id),
    FOREIGN KEY(followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);
--trigger to log unfollow data
DELIMITER $$
CREATE TRIGGER log_unfollows
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        INSERT INTO unfollows (follower_id, followee_id) VALUES (OLD.follower_id, OLD.followee_id);
        --INSERT INTO unfollows SET follower_id = OLD.follower_id, followee_id =  OLD.followee_id; --alternate syntax
    END;
$$
DELIMITER ;

--REMOVE TRIGGERS
DROP trigger prevent_self_follows;