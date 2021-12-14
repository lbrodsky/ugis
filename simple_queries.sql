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

/* 
Measutements in PostGIS 
*/ 

-- Calculate the length of the Vltava River from  the Natural Earth database using SQL. 
--  Present the result in kilometers. 
-- Be aware that Natural Earth database has a  typo mistake, the name of Vltava river is  ‘Vitava’!

-- first chech attributes in ne_10m_rivers_lake_centerlines
SELECT * 
FROM ne_10m_rivers_lake_centerlines
LIMIT 1; 

-- use attribute name 
SELECT ST_Length(
    ST_Transform(the_geom, 3035)
  ) / 1000 AS length_km 
FROM ne_10m_rivers_lake_centerlines
WHERE name = 'Vitava'; 

-- Calculate the area of the city with gid = 7614  in the database Natural Earth2 (urban areas table) using SQL query. 
-- Present the result in square kilometers as city name and area.

SELECT ST_Area(
    ST_Transform(the_geom, 3035)
  ) / 1000000 AS areas_sqkm  
FROM ne_10m_urban_areas
WHERE gid = 7614;

-- Calculate the distance between Prague and Berlin using the Natural Earth database (populated places table) using SQL query. 
-- e.g. using populated places with name = ‘Berlin’ and urban areas gid = 7614; 

-- not a nice solution 
SELECT ST_Distance(
  ST_Transform(p.the_geom, 3035), 
  ST_Transform(u.the_geom, 3035)) 
  / 1000 AS dist_km
FROM ne_10m_populated_places AS p, ne_10m_urban_areas AS u 
WHERE p.name = 'Berlin' AND u.gid='7614'; 

-- better

SELECT ST_Distance(
                ST_Transform(A.the_geom, 3035), 
                B.geom
                ) AS dist_km 
FROM ne_10m_populated_places AS A, 
    -- nested SELECT asliased as B, while geometry is aliased as geom 
    (SELECT ST_TRansform(the_geom, 3035) AS geom 
    FROM ne_10m_populated_places
    WHERE name = 'Prague') AS B 
WHERE name = 'Berlin';

