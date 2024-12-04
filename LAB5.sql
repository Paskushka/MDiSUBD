CREATE OR REPLACE FUNCTION public.update_users_name()
RETURNS trigger AS $$
BEGIN
NEW.name = CONCAT(NEW.first_name,' ', NEW.last_name);
RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER "update_users_name_on_update_trigger"
	BEFORE UPDATE OF first_name, last_name ON person
	FOR EACH ROW WHEN ((new.first_name != old.first_name) or (new.last_name != new.last_name))
	EXECUTE PROCEDURE "update_users_name"();

CREATE TRIGGER "update_users_name_on_insert_trigger"
	BEFORE INSERT ON person
	FOR EACH ROW
	EXECUTE PROCEDURE "update_users_name"();


CREATE OR REPLACE FUNCTION public.update_bonus_times()
RETURNS trigger AS $$
BEGIN
	UPDATE bonus SET times = + 1 WHERE id = NEW.bonus_id;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER "update_bonus_times_on_insert_trigger"
	AFTER INSERT ON orders
	FOR EACH ROW 
	EXECUTE PROCEDURE "update_bonus_times"();


CREATE OR REPLACE FUNCTION create_vacancy_on_employee_delete()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO vacancy (employeeposition_id, number, description)
    VALUES (OLD.position_id, 1, "This vacancy is available");

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER add_vacancy_on_employee_delete
AFTER DELETE ON employee
FOR EACH ROW
EXECUTE FUNCTION create_vacancy_on_employee_delete();


CREATE OR REPLACE FUNCTION create_vacancy_on_position_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO vacancy (employee_position_id, number, description)
    VALUES (NEW.id, 1, 'Our new position');

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER add_vacancy_on_position_insert
AFTER INSERT ON employeeposition
FOR EACH ROW
EXECUTE FUNCTION create_vacancy_on_position_insert();


CREATE OR REPLACE FUNCTION create_client_on_person_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO client (user_id)
    VALUES (NEW.id);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER add_client_on_person_insert
AFTER INSERT ON person
FOR EACH ROW WHEN (NEW.is_stuff)
EXECUTE FUNCTION create_client_on_person_insert();


CREATE OR REPLACE FUNCTION update_last_order_date()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Client
    SET last_order_date = CURRENT_DATE
    WHERE id = NEW.client_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_last_order_date
AFTER INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION update_last_order_date();


CREATE OR REPLACE FUNCTION prevent_position_deletion()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS(SELECT 1 FROM Employee WHERE position_id = OLD.id) THEN
        RAISE EXCEPTION 'Cannot delete position because there are employees assigned to it.';
    END IF;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_prevent_position_deletion
BEFORE DELETE ON EmployeePosition
FOR EACH ROW
EXECUTE FUNCTION prevent_position_deletion();