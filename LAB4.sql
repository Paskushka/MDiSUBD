SELECT * FROM Exhibit WHERE name iLIKE '%a%' AND date BETWEEN '2022-01-01' AND '2024-12-12';

SELECT * FROM Employee AS E WHERE (SELECT COUNT(*) FROM EmployeePosition AS EP WHERE EP.id = e.position_id AND EP.name iLIkE '%M%') BETWEEN 1 AND 4;

SELECT exhibition.name FROM exhibition WHERE cost > (SELECT AVG(cost) FROM exhibition);

-- JOINS

SELECT * FROM Exhibit JOIN Exhibition ON Exhibit.exhibition_id = Exhibition.id;

SELECT exhibit.name, exhibition.name FROM exhibit JOIN exhibition ON exhibit.exhibition_id = exhibition.id;

SELECT person.first_name, person.last_name, employee.date_of_beginning FROM person LEFT JOIN employee ON employee.user_id = person.id;

SELECT person.first_name, person.last_name, employee.date_of_beginning FROM person LEFT JOIN employee ON employee.user_id = person.id WHERE employee.id IS NOT NULL;

SELECT person.first_name, person.last_name, employee.date_of_beginning FROM person RIGHT JOIN employee ON employee.user_id = person.id;

SELECT * FROM person FULL JOIN employee ON employee.user_id = person.id;

SELECT * FROM person CROSS JOIN exhibit;

SELECT * FROM exhibit CROSS JOIN exhibition;

SELECT * FROM exhibit AS E, exhibit AS P;

SELECT * FROM person CROSS JOIN exhibit CROSS JOIN exhibition;

-- GROUPS

SELECT exhibition_id, COUNT(*) FROM exhibit GROUP BY exhibition_id;

SELECT name FROM exhibition GROUP BY name HAVING AVG(cost) > 200;

SELECT 	exhibition.id exhibition.name RANK() OVER (ORDER BY cost DESC) AS cost_rank FROM Exhibition;

SELECT * FROM client UNION ALL SELECT * FROM client;

SELECT * FROM client UNION SELECT * FROM client;

-- HARD

SELECT name FROM exhibition WHERE EXISTS (SELECT 1 FROM exhibit WHERE exhibit.exhibition_id = exhibition.id);

EXPLAIN ANALYZE SELECT name, cost FROM exhibition;

EXPLAIN SELECT name, cost FROM exhibition;

SELECT name, cost, CASE
WHEN COST < 150 THEN 'LOW'
WHEN cost BETWEEN 150 AND 250 THEN 'Medium'
ELSE 'HIGH'
END AS category
FROM exhibition;
