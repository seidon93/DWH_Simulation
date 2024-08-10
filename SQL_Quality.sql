CREATE SCHEMA Crm_system;

ALTER SCHEMA Crm_system OWNER TO CDO;

/* ACTIVITY TABLE */

-- kontrola správnosti datumu
ALTER TABLE Crm."Crm_system".Activity
ADD CONSTRAINT check_activity_date
CHECK (activity_date <= NOW());


-- odstranění duplict
ALTER TABLE Crm."Crm_system".Activity
ADD CONSTRAINT one_unique_activity
UNIQUE (Customer, Type, Activity_date);



-- funkce pro automatizovné mazání
CREATE OR REPLACE FUNCTION remove_finishes_activity()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Outcome = 'Successful' THEN
        DELETE FROM Crm."Crm_system".Activity WHERE ActivityID = NEW.ActivityID;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



-- triggrer mazání
CREATE TRIGGER check_finishes_activity
AFTER INSERT OR UPDATE ON "Crm_system".Activity
FOR EACH ROW
EXECUTE FUNCTION remove_finishes_activity();



-- kontrola email vzoru
ALTER TABLE Contacts ADD CONSTRAINT check_email
    CHECK (email LIKE '%_@__%.__%');

ALTER TABLE Customers ADD CONSTRAINT check_email
    CHECK (email LIKE '%_@__%.__%');

CREATE OR REPLACE FUNCTION verify_email()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.email NOT LIKE '%_@__%.__%' THEN
        RAISE EXCEPTION 'Invalid email format';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER verify_email
BEFORE INSERT OR UPDATE ON customers
FOR EACH ROW
EXECUTE FUNCTION verify_email();

