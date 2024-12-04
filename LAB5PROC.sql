CREATE OR REPLACE PROCEDURE AddPerson(
    p_first_name VARCHAR,
    p_last_name VARCHAR,
    p_email VARCHAR,
	p_password VARCHAR,
	p_is_stuff BOOLEAN,
	p_is_admin BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO person (first_name, last_name, email, password, is_stuff, is_admin)
    VALUES (p_first_name, p_last_name, p_email, p_password, p_is_stuff, p_is_admin);
END;
$$;


CREATE OR REPLACE PROCEDURE AddOrder(
    p_client_id INT,
    p_bonus_id INT,
    p_exhibition_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO orders (client_id, bonus_id, exhibition_id)
    VALUES (p_client_id, p_bonus_id, p_exhibition_id);
END;
$$;


CREATE OR REPLACE PROCEDURE AddEmployee(
    p_user_id INT,
    p_position_id INT,
    p_hall_id INT,
	p_date_of_beginning DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employee (user_id, position_id, hall_id, date_of_beginning)
    VALUES (p_user_id, p_position_id, p_hall_id, p_date_of_beginning);
END;
$$;


CREATE OR REPLACE PROCEDURE AddExhibit(
    p_name VARCHAR,
	p_date DATE,
	p_exhibition_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO exhibit (name, exhibition_id, date)
    VALUES (p_name, p_exhibition_id, p_date);
END;
$$;


CREATE OR REPLACE PROCEDURE GetExhibitionInfo(
    p_exhibition_id INT,
    OUT p_name VARCHAR,
    OUT p_date DATE,
    OUT p_cost INT,
    OUT p_code INT,
    OUT p_people INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT name, date, cost, code, people INTO p_name, p_date, p_cost, p_code, p_people
    FROM Client
    WHERE id = p_exhibition_id;
END;
$$;