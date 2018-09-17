SELECT country_id, country_name
FROM countries JOIN locations USING(country_id)
WHERE location_id IN(SELECT location_id 
                     FROM locations
                     MINUS
                     SELECT location_id
                     FROM departments)
MINUS
SELECT country_id, country_name
FROM countries JOIN locations USING(country_id)
WHERE location_id IN (SELECT location_id
                      FROM departments);
-------------------------------
SELECT country_id, country_name
FROM locations JOIN countries USING(country_id)
MINUS
SELECT country_id, country_name
FROM locations JOIN countries USING(country_id)
               JOIN departments USING(location_id);
