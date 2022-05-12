-- Table creation

CREATE TABLE users(
    email VARCHAR(255) PRIMARY KEY,
    created_at TIMESTAMP DEFAULT NOW()
);



-- 1. Find earliest date a user joined

SELECT
    CONCAT(DATE_FORMAT(created_at,"%b")," ",DATE_FORMAT(created_at,"%D")," ",DATE_FORMAT(created_at,"%Y")) AS earliest_date
FROM
    users
ORDER BY created_at
LIMIT 1
;


-- 2. Find the email of earliest user

SELECT
    email,
    CONCAT(DATE_FORMAT(created_at,"%b")," ",DATE_FORMAT(created_at,"%D")," ",DATE_FORMAT(created_at,"%Y")) AS earliest_date
FROM
    users
ORDER BY created_at
LIMIT 1
;



-- 3. Users according to the month they joined

SELECT
    DATE_FORMAT(created_at, "%M") as month,
    COUNT(*) AS count
FROM
    users
GROUP BY month
ORDER BY count DESC
;



-- 4. Count number of users with yahoo emails

SELECT
    COUNT(*) AS yahoo_users
FROM
    users
WHERE
    email LIKE "%@yahoo.com"
;


-- 5. Calculate the total number of users for each email host

SELECT
    CASE
        WHEN email LIKE "%@yahoo.com" THEN "yahoo"
        WHEN email LIKE "%@gmail.com" THEN "gmail"
        WHEN email LIKE "%@hotmail.com" THEN "hotmail"
        ELSE "other"
     END AS provider,
     COUNT(*) AS count
FROM
    users
GROUP BY provider
ORDER BY count DESC
;






