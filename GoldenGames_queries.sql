-- 1. Identify the ten top-selling video games.
-- Select all information for the top ten best-selling games
-- Order the results from best-selling game down to tenth best-selling
SELECT * FROM game_sales
ORDER BY games_sold DESC
LIMIT 10

-- 2. Highlight games with missing review scores.
-- Join games_sales and reviews
-- Select a count of the number of games where both critic_score and user_score are null
SELECT COUNT(g.game)
FROM game_sales g
LEFT JOIN reviews r
ON g.game = r.game
WHERE critic_score IS NULL AND user_score IS NULL;

-- 3. Pinpoint the years celebrated by video game critics.
-- Select release year and average critic score for each year, rounded and aliased
-- Join the game_sales and reviews tables
-- Group by release year
-- Order the data from highest to lowest avg_critic_score and limit to 10 results
SELECT g.year, ROUND(AVG(r.critic_score),2) AS avg_critic_score
FROM game_sales g
INNER JOIN reviews r
ON g.game = r.game
GROUP BY g.year
ORDER BY avg_critic_score DESC
LIMIT 10;

-- 4. Investigate the hype around 1982: Was it truly a standout year?
-- Updated query so that it only returns years that have more than four reviewed games
SELECT g.year, COUNT(g.game) AS num_games, ROUND(AVG(r.critic_score), 2) AS avg_critic_score
FROM game_sales g
INNER JOIN reviews r
ON g.game = r.game
GROUP BY g.year
HAVING COUNT(g.game) > 4
ORDER BY avg_critic_score DESC
LIMIT 10;

-- 5. Identify the years that no longer made the cut in critics' favorites.
-- Select the year and avg_critic_score for those years that dropped off the list of critic favorites 
-- Order the results from highest to lowest avg_critic_score
SELECT year, avg_critic_score 
FROM top_critic_years
EXCEPT 
SELECT year, avg_critic_score
FROM top_critic_years_more_than_four_games
ORDER BY avg_critic_score DESC;

-- 6. Discover the years that captivated the hearts of players.
-- Select year, an average of user_score, and a count of games released in a given year, aliased and rounded
-- Include only years with more than four reviewed games; group data by year
-- Order data by avg_user_score, and limit to ten results
SELECT g.year, COUNT(g.game) AS num_games, ROUND(AVG(r.user_score), 2) AS avg_user_score
FROM game_sales g
INNER JOIN reviews r
ON g.game = r.game
GROUP BY g.year
HAVING COUNT(g.game) > 4
ORDER BY avg_user_score DESC
LIMIT 10;

-- 7. Highlight years that won accolades from both players and critics.
-- Select the year results that appear on both tables
SELECT year 
FROM top_user_years_more_than_four_games
INTERSECT
SELECT year
FROM top_critic_years_more_than_four_games;

-- 8. Analyze sales trends during the golden years of gaming.
-- Select year and sum of games_sold, aliased as total_games_sold; order results by total_games_sold descending
-- Filter game_sales based on whether each year is in the list returned in the previous task
SELECT g.year, SUM(g.games_sold) AS total_games_sold
FROM game_sales g
WHERE g.year IN (SELECT year FROM top_user_years_more_than_four_games
INTERSECT
SELECT year FROM top_critic_years_more_than_four_games)
GROUP BY g.year
ORDER BY total_games_sold DESC;