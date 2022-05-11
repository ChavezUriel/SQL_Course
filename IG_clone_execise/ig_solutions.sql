#1.

SELECT * FROM users ORDER BY created_at LIMIT 5;


#2.

SELECT DATE_FORMAT(created_at,"%W") AS weekday,
       COUNT(*) AS total
FROM users 
GROUP BY weekday
ORDER BY total DESC;


#3.

SELECT 
    users.id,
    username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE
    photos.id IS NULL
;


#4.

SELECT
    users.username,
    photos.id as pShoto_id,
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


#5.

# My solution:

SELECT
    AVG(n_photos) AS average
FROM(
    SELECT
        CASE
            WHEN photos.id IS NULL THEN 0
            ELSE COUNT(*)
        END AS n_photos
    FROM users
    LEFT JOIN photos
        ON users.id = photos.user_id
    GROUP BY users.id
) AS photos_by_users;

# Teacher's solution:

SELECT 
    (SELECT Count(*) FROM   photos) / (SELECT Count(*) FROM   users) AS avg; 


#6.

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


#7.

SELECT
    users.id, 
    username
FROM users
JOIN likes
    ON users.id = likes.user_id
GROUP BY users.id
HAVING COUNT(*) = (SELECT COUNT(*) FROM photos)
;


#8.

SELECT
    users.id, 
    username,
    CASE
        WHEN ISNULL(comments.id) THEN 0
        ELSE COUNT(*)
    END AS n_comments
FROM users
LEFT JOIN comments
    ON users.id = comments.user_id
GROUP BY users.id
HAVING n_comments = 0
;


#9.

# all commented counting

SELECT
    COUNT(*)
FROM(
    SELECT
        users.id, 
        username
    FROM users
    JOIN comments
        ON users.id = comments.user_id
    GROUP BY users.id
    HAVING COUNT(*) = (SELECT COUNT(*) FROM photos)
    ) AS all_commented
;


# 0 commented counting

SELECT
    COUNT(*)
FROM(
    SELECT
        users.id, 
        username,
        CASE
            WHEN ISNULL(comments.id) THEN 0
            ELSE COUNT(*)
        END AS n_comments
    FROM users
    LEFT JOIN comments
        ON users.id = comments.user_id
    GROUP BY users.id
    HAVING n_comments = 0
    ) AS no_comments
;


# percentage calculation

SELECT
    ((
    SELECT
        COUNT(*)
    FROM(
        SELECT
            users.id, 
            username,
            CASE
                WHEN ISNULL(comments.id) THEN 0
                ELSE COUNT(*)
            END AS n_comments
        FROM users
        LEFT JOIN comments
            ON users.id = comments.user_id
        GROUP BY users.id
        HAVING n_comments = 0
        ) AS no_comments
    ) + (
    SELECT
        COUNT(*)
    FROM(
        SELECT
            users.id, 
            username
        FROM users
        JOIN comments
            ON users.id = comments.user_id
        GROUP BY users.id
        HAVING COUNT(*) = (SELECT COUNT(*) FROM photos)
    ) AS all_commented
    )) 
    / COUNT(*) * 100 
    AS percentage
FROM
    users
;
    













