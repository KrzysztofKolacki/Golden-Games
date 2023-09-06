-- Database: Golden_Games

-- DROP DATABASE IF EXISTS "Golden_Games";

CREATE DATABASE "Golden_Games"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Polish_Poland.1250'
    LC_CTYPE = 'Polish_Poland.1250'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
	
-- DROP TABLE IF EXISTS game_sales;

CREATE TABLE game_sales (
  game VARCHAR(100) PRIMARY KEY,
  platform VARCHAR(64),
  publisher VARCHAR(64),
  developer VARCHAR(64),
  games_sold NUMERIC(5, 2),
  year INT
);

-- DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
    game VARCHAR(100) PRIMARY KEY,
    critic_score NUMERIC(4, 2),   
    user_score NUMERIC(4, 2)
);

-- DROP TABLE IF EXISTS top_critic_years;

CREATE TABLE top_critic_years (
    year INT PRIMARY KEY,
    avg_critic_score NUMERIC(4, 2)  
);

-- DROP TABLE IF EXISTS top_critic_years_more_than_four_games;

CREATE TABLE top_critic_years_more_than_four_games (
    year INT PRIMARY KEY,
    num_games INT,
    avg_critic_score NUMERIC(4, 2)  
);

-- DROP TABLE IF EXISTS top_user_years_more_than_four_games;

CREATE TABLE top_user_years_more_than_four_games (
    year INT PRIMARY KEY,
    num_games INT,
    avg_user_score NUMERIC(4, 2)  
);

copy game_sales FROM 'your_path\datasets\game_sales.csv' DELIMITER ',' CSV HEADER;
copy reviews FROM 'your_path\datasets\game_reviews.csv' DELIMITER ',' CSV HEADER;
copy top_critic_years FROM 'your_path\datasets\top_critic_scores.csv' DELIMITER ',' CSV HEADER;
copy top_critic_years_more_than_four_games FROM 'your_path\datasets\top_critic_scores_more_than_four_games.csv' DELIMITER ',' CSV HEADER;
copy top_user_years_more_than_four_games FROM 'your_path\datasets\top_user_scores_more_than_four_games.csv' DELIMITER ',' CSV HEADER;