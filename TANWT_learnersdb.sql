-- ANALYSE THE DATA
SELECT u.user_id, u.email_domain, p.learn_cpp,                  -- Select all the fields in the users and progress tables
p.learn_html, p.learn_java, p.learn_javascript, p.learn_sql     
FROM users u                                                    
JOIN progress p                                                 -- join users and progress tables and giving them aliases of u and p respectively
ON u.user_id = p.user_id                                        -- common key of user_id for both tables
ORDER BY u.email_domain;                                        -- sort results by email in ASC order

-- WHAT ARE THE TOP 25 SCHOOLS(.edu domains)?
SELECT email_domain, COUNT(*) AS count	-- count the email accounts
FROM users 							                -- from the user table
WHERE email_domain LIKE "%.edu" 		    -- where the email contains .edu
GROUP BY email_domain 					        -- group the results by the email address
ORDER BY count DESC 					          -- order the results in descending order
LIMIT 25; 								              -- list the top 25 schools.

-- HOW MANY .edu LEARNERS ARE LOCATED IN NEW YORK?
SELECT COUNT(*) AS total 					-- count the total number of learners
FROM users									      -- from the users table
WHERE email_domain LIKE "%.edu"		-- where the user email contains .edu
AND city = "New York";						-- and the user's city is New York

-- HOW MANY CODECADEMY LEARNERS ARE MOBILE APPS USERS?
SELECT COUNT(*) AS total						-- count the total number of learners
FROM users										      -- from the users table
WHERE mobile_app = "mobile-user";		-- where user's mobile app field is "mobile-user"

-- WHAT ARE THE NUMBER OF SIGN-UPS, SORTED BY TIME?
SELECT HOUR(sign_up_at) AS hour, COUNT(*) AS count	-- Count the sign ups by time (using hour stored in "sign_up_at")
FROM users											                    -- from users table
GROUP BY hour										                    -- group results by time
ORDER BY hour;									                  	-- order results by ascending order(default)

-- WHAT COURSES DO DIFFERENT SCHOOLS PREFER?
SELECT users.email_domain,																	                      -- sorting by email_domain from users table
SUM(CASE WHEN progress.learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "CPP",					-- count CPP learners who started or completed;
SUM(CASE WHEN progress.learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "SQL",					-- count SQL learners who started or completed;
SUM(CASE WHEN progress.learn_html NOT IN('') THEN 1 ELSE 0 END) AS "HTML",				-- count HTML learners who started or completed;
SUM(CASE WHEN progress.learn_javascript NOT IN('') THEN 1 ELSE 0 END) as "JS",		-- count JS learners who started or completed;
SUM(CASE WHEN progress.learn_java NOT IN('') THEN 1 ELSE 0 END) as "JAVA",				-- count JAVA learners who started or completed;
COUNT(email_domain) AS "Number of learners"													              -- count number of learners from each .edu
FROM users JOIN progress																	                        -- joining users and progress table
ON users.user_id = progress.user_id															                  -- using user_id as common key shared by both users and progress tables
WHERE users.email_domain LIKE "%.edu"														                  -- counting only users with .edu in their emails
GROUP BY users.email_domain															                          -- grouping results by email
ORDER BY users.email_domain ASC;                                                  -- sort results by email alphabetically

-- WHAT COURSES ARE NEW YORKER STUDENTS TAKING?
SELECT users.city,																	                              -- sorting by email_domain from users table
SUM(CASE WHEN progress.learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "CPP",					-- count CPP learners who started or completed;
SUM(CASE WHEN progress.learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "SQL",					-- count SQL learners who started or completed;
SUM(CASE WHEN progress.learn_html NOT IN('') THEN 1 ELSE 0 END) AS "HTML",				-- count HTML learners who started or completed;
SUM(CASE WHEN progress.learn_javascript NOT IN('') THEN 1 ELSE 0 END) as "JS",		-- count JS learners who started or completed;
SUM(CASE WHEN progress.learn_java NOT IN('') THEN 1 ELSE 0 END) as "JAVA",				-- count JAVA learners who started or completed;
COUNT(city) AS "Number of learners"															                  -- count total number of learners in New York
FROM users JOIN progress																	                        -- joining users and progress table
ON users.user_id = progress.user_id															                  -- using user_id as common key shared by both users and progress tables
WHERE users.city = "New York";																                    -- where user's city is New York

-- WHAT COURSES ARE CHICAGO STUDENTS TAKING?
SELECT users.city,																	                              -- sorting by email_domain from users table
SUM(CASE WHEN progress.learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "CPP",					-- count CPP learners who started or completed;
SUM(CASE WHEN progress.learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "SQL",					-- count SQL learners who started or completed;
SUM(CASE WHEN progress.learn_html NOT IN('') THEN 1 ELSE 0 END) AS "HTML",				-- count HTML learners who started or completed;
SUM(CASE WHEN progress.learn_javascript NOT IN('') THEN 1 ELSE 0 END) as "JS",		-- count JS learners who started or completed;
SUM(CASE WHEN progress.learn_java NOT IN('') THEN 1 ELSE 0 END) as "JAVA",				-- count JAVA learners who started or completed;
COUNT(city) AS "Number of learners"															                  -- count total number of learners in Chicago
FROM users JOIN progress																	                        -- joining users and progress table
ON users.user_id = progress.user_id															                  -- using user_id as common key shared by both users and progress tables
WHERE users.city = "Chicago";																                      -- where user's city is Chicago
