SELECT country_id, country_name
FROM countries JOIN locations USING(country_id)
WHERE location_id IN(SELECT DISTINCT location_id
                     FROM departments)
INTERSECT
SELECT country_id, country_name
FROM countries;
----------------------------------------
SELECT country_id, country_name
FROM locations JOIN countries USING(country_id)
INTERSECT
SELECT country_id, country_name
FROM locations JOIN countries USING(country_id)
               JOIN departments USING(location_id);
