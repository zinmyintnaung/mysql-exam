--ANSWER ALL USING social DATABASE
--Q1: get the first five oldest user
SELECT * FROM social.users ORDER BY created_at LIMIT 5;

--Q2: get the most popular day of the week user used to register
SELECT DAYNAME(created_at) as day, COUNT(*) AS total FROM social.users 
GROUP BY day ORDER BY total DESC LIMIT 1;

--Q3: find the users who never posted a photo
SELECT username FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.user_id IS NULL;

--Q4: find the user whose photo get most likes or the most like photo 
SELECT username, photos.id AS photoId, image_url, COUNT(*) AS total FROM photos
INNER JOIN likes ON photos.id = likes.photo_id
JOIN users ON users.id = photos.user_id
GROUP BY photoId ORDER BY total DESC LIMIT 1;

--Q5: how many times does the average user created post
SELECT
	(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users)
AS average_photos_per_user;

--Q6: find top five most commonly used hashtag
SELECT tag_id, tag_name, COUNT(tag_id) AS total FROM photo_tags
JOIN tags ON tags.id = photo_tags.tag_id
GROUP BY tag_id ORDER BY total DESC LIMIT 5;

--Q7: get user who likes all the photos
SELECT username, COUNT(likes.photo_id) AS most_no_likes FROM likes
INNER JOIN users ON users.id =likes.user_id
GROUP BY likes.user_id HAVING most_no_likes = (SELECT COUNT(*) FROM photos);
