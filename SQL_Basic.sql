CREATE DATABASE Crm;

CREATE OR REPLACE FUNCTION create_full_name()
RETURNS TRIGGER AS $$
BEGIN
    NEW.full_name = concat(NEW.first_name, ' ', NEW.last_name);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER insert_full_name
BEFORE INSERT OR UPDATE ON Customers
FOR EACH ROW
EXECUTE FUNCTION create_full_name();