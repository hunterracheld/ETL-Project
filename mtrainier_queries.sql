-- Create climbing statistics table
DROP TABLE climbing_statistics
CREATE TABLE climbing_statistics (
id SERIAL PRIMARY KEY,
date VARCHAR,	
route VARCHAR, 	
attempted INT,
succeeded INT, 
success_percentage INT
);

-- Create weather statistics table
CREATE TABLE weather (
date VARCHAR PRIMARY KEY, 	
temp_avg INT,	
relative_humidity_avg INT, 	
wind_speed_daily_avg INT
);

--Create route info table
DROP TABLE routes
CREATE TABLE routes(
id SERIAL PRIMARY KEY,
route_name VARCHAR,
difficulty_rating TEXT,	
elevation_gain VARCHAR,
max_grade VARCHAR,	
season_approach VARCHAR
);
			
--Preview tables
SELECT * FROM climbing_statistics
SELECT * FROM weather
SELECT * FROM routes

-- Join tables to view weather data with climbing statistics
CREATE VIEW climbing_stats_w_weather AS
SELECT climbing_statistics.id, climbing_statistics.date, climbing_statistics.route, climbing_statistics.attempted, 
	climbing_statistics.succeeded, climbing_statistics.success_percentage, weather.temp_avg, 
		weather.relative_humidity_avg, weather.wind_speed_daily_avg
FROM climbing_statistics
LEFT JOIN weather
ON climbing_statistics.date = weather.date;

--Query for all results in November and December
SELECT * FROM climbing_stats_w_weather
WHERE date LIKE '11%' OR date LIKE '12%';

--Join climbing stats w/ route info and sort by success rate vs. difficulty rating
CREATE VIEW success_difficulty_rating AS
SELECT climbing_statistics.route, climbing_statistics.success_percentage, routes.difficulty_rating
FROM climbing_statistics
LEFT JOIN routes
ON climbing_statistics.route = routes.route_name;

SELECT * FROM success_difficulty_rating

SELECT route, AVG(success_percentage) AS "avg_success_rating"
FROM success_difficulty_rating
WHERE route LIKE 'Disappointment Cleaver' 
	OR route like 'Little Tahoma' OR route like 'Kautz Glacier Direct' OR route LIKE 'Fuhrer Finger'
GROUP BY route
ORDER BY "avg_success_rating" DESC;