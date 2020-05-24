
-- Section 15. Working with Lots of Instagram Data

-- 1. Find the 5 oldest users.
-- Reward users who have been around the longest.
SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;


-- 2. Most Polular Registration Date
SELECT 
     DAYNAME(created_at) AS day,
     COUNT(*) AS total
FROM users
GROUP BY day 
ORDER BY total DESC
LIMIT 1;


-- 3. Identify Inactive Users (users with no photos)
SELECT 
    username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;


-- 4. Identify most popular photo (and user who created it)
SELECT 
    username,
    photos.id, 
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;


-- 5. How many times does the average user post?
-- Calculate avg number of photos per user
SELECT 
    (SELECT COUNT(*) FROM photos)/(SELECT COUNT(*) FROM users) AS avg;


-- 6. What are the top 5 most commonly used hashtags?
SELECT 
    tags.tag_name,
    COUNT(*) AS total
FROM photo_tags
JOIN tags
    ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5;


-- 7. Find users who have liked every single photo on the site.

# 错误写法
# what you want to select from the data
SELECT 
    username,
    COUNT(*) AS num_likes
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY likes.user_id
WHERE number_likes = 257;

# 正确写法: WHERE 在 GROUP BY 之前
# what the selected data you want to group
SELECT 
    username,
    COUNT(*) AS num_likes
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
WHERE number_likes = (SELECT COUNT(*) FROM photos)
GROUP BY likes.user_id;

# 正确写法
SELECT 
    username,
    COUNT(*) AS num_likes
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING number_likes = (SELECT COUNT(*) FROM photos);