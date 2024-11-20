SELECT * FROM Hall;

SELECT name, cost FROM Exhibition;

SELECT SUM(cost) FROM Exhibition;

SELECT SUM(cost) FROM Exhibition GROUP BY id;

SELECT AVG(cost) FROM Exhibition;

SELECT name, cost FROM Exhibition ORDER BY cost DESC;

SELECT name, cost FROM Exhibition ORDER BY cost DESC LIMIT 2;

SELECT name, cost FROM Exhibition ORDER BY cost DESC OFFSET 2;

SELECT * FROM Exhibition WHERE name = 'Modern Future';

ALTER TABLE Exhibition ADD COLUMN test DATE; 

UPDATE Exhibition SET test = current_date;

ALTER TABLE Exhibition DROP COLUMN test;

SELECT last_name, first_name FROM Person WHERE last_name LIKE '%e%';

SELECT last_name, first_name FROM Person WHERE first_name LIKE 'K%';

SELECT DISTINCT name FROM Exhibit;

SELECT MIN(cost) FROM Exhibition;

SELECT MAX(cost) FROM Exhibition;

SELECT * FROM Exhibit WHERE exhibition_id IN (1, 2);

SELECT * FROM Exhibit WHERE date BETWEEN'2021-01-01' AND '2023-01-01';

SELECT last_name, first_name FROM Person WHERE first_name iLIKE 'k%';

SELECT exhibition_id, COUNT(*) FROM Exhibit GROUP BY exhibition_id;

SELECT exhibition_id, COUNT(*) FROM Exhibit GROUP BY exhibition_id HAVING COUNT(*) > 2;

SELECT exhibition_id, COUNT(*) FROM Exhibit GROUP BY exhibition_id HAVING COUNT(*) > 2 ORDER BY exhibition_id DESC;

SELECT id, first_name AS name, last_name AS surname FROM Person;

DELETE FROM Exhibit WHERE name = 'Flag';
