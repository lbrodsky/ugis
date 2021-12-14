/* 
Here you find set of simple SQL querries. 

PostgreSQL/PostGIS server running on OSGeo live 9/14 
db=natural_earth2
host=localhost
port=5432
user / pwd -> OSGeolive readme

*/ 

-- Count number of records in DB table ne_10m_populated_places 
SELECT COUNT(*) 
FROM ne_10m_populated_places; 

-- Select and print the first record of the table 
SELECT * 
FROM ne_10m_populated_places 
LIMIT 1; 

-- Question: what is the name of the table geometry column? 

-- Compare geometry types in the tbales  ne_10m_populated_place and  ne_10m_land
SELECT ST_GeometryType(the_geom)  
FROM ne_10m_populated_places 
LIMIT 1; 

SELECT ST_GemetryType(the_geom)  
FROM ne_10m_land
LIMIT 1; 


-- Print the spatial coordinates of the first element in the table ne_10m_populated_places
SELECT ST_AsText(the_geom) 
FROM ne_10m_populated_places
LIMIT 1;

-- Can you firnd Prague (your city) in the table ne_10m_populated_places 
-- use filter (condition) on attribute "name" 
SELECT *
FROM ne_10m_populated_places
WHERE name = 'Prague';
-- be carful about the character used as quotes!!! 

-- What are the lat/long coordinates of Prague? 
-- What is the population of Prague according to this database? 
-- use attribute pop_max 

SELECT pop_max
FROM ne_10m_populated_places
WHERE name = 'Prague';

-- Sort the population figures in the database in descending order 
-- print also the name of the city
SELECT name, pop_max
FROM ne_10m_populated_places
ORDER BY pop_max DESC; 

-- Print 10 biggest (population) cities in the word 
SELECT name, pop_max
FROM ne_10m_populated_places
ORDER BY pop_max DESC
LIMIT 10; 


-- Print 5 biggest (population) cities in Europe
-- a tricky task!
-- use: WHERE timezone LIKE 'Europe/%'
SELECT name, pop_max, timezone
FROM ne_10m_populated_places
WHERE timezone LIKE 'Europe/%' 
ORDER BY pop_max DESC 
LIMIT 5; 


