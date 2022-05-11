
SELECT * FROM users ORDER BY created_at LIMIT 5;


SELECT DATE_FORMAT(created_at,"%W") AS weekday,
       COUNT(*) AS total
FROM users 
GROUP BY weekday
ORDER BY total DESC;



SELECT 
    users.id,
    username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE
    photos.id IS NULL
;



SELECT
    users.username,
    photos.id as photo_id,
    COUNT(*) AS total_likes
FROM photos
JOIN likes
    ON likes.photo_id = photos.id
JOIN users
    ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1
;



SELECT
    AVG(
        CASE
            WHEN photos.id IS NULL THEN 0
            ELSE COUNT(*)
        END
    )AS average_post
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
GROUP BY users.id
;


SELECT
    CASE
        WHEN photos.id IS NULL THEN 0
        ELSE COUNT(*)
    END AS conteo
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
GROUP BY users.id
;



SELECT
    AVG(conteo)
FROM(
    SELECT
        CASE
            WHEN photos.id IS NULL THEN 0
            ELSE COUNT(*)
        END AS conteo
    FROM users
    LEFT JOIN photos
        ON users.id = photos.user_id
    GROUP BY users.id
);



SELECT
    tags.tag_name,
    COUNT(*) AS total_tags
FROM tags
JOIN photo_tags
    ON tags.id = tag_id
GROUP BY tags.tag_name
ORDER BY total_tags DESC
LIMIT 5
;


SELECT
    users.id, 
    username,
    COUNT(*) AS liked_photos
FROM users
JOIN likes
    ON users.id = likes.user_id
GROUP BY users.id
HAVING liked_photos = (SELECT COUNT(*) FROM photos)
;



















