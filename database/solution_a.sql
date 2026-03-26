USE `bke_center`;

SELECT * FROM users ORDER BY user_name ASC;

SELECT * FROM users ORDER BY user_name ASC LIMIT 7;

SELECT * FROM users WHERE user_name LIKE '%a%' ORDER BY user_name ASC;

SELECT * FROM users WHERE user_name LIKE 'm%';

SELECT * FROM users WHERE user_name LIKE '%i';

SELECT * FROM users WHERE user_email LIKE '%@gmail.com';

SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND user_name LIKE 'm%';

SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND user_name LIKE '%i%' AND LENGTH(user_name) > 5;

SELECT * FROM users WHERE user_name LIKE '%a%' AND LENGTH(user_name) BETWEEN 5 AND 9 AND user_email LIKE '%i%@gmail.com';

SELECT * FROM users
WHERE (user_name LIKE '%a%' AND LENGTH(user_name) BETWEEN 5 AND 9)
   OR (user_name LIKE '%i%' AND LENGTH(user_name) < 9)
   OR (user_email LIKE '%@gmail.com' AND user_email LIKE '%i%@%');
