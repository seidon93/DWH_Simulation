
/* ACTIVITY TABLE */

-- kontrola správnosti datumu
ALTER TABLE Crm_System.Activity
ADD CONSTRAINT check_activity_date
CHECK (activity_date <= NOW());


-- odstranění duplict
ALTER TABLE Crm_system.Activity
ADD CONSTRAINT one_unique_activity
UNIQUE (Customer, Type, Activity_date);



-- funkce pro automatizovné mazání
CREATE OR REPLACE FUNCTION remove_finishes_activity()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Outcome = 'Successful' THEN
        DELETE FROM Crm.Crm_system.Activity WHERE ActivityID = NEW.ActivityID;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



-- triggrer mazání
CREATE TRIGGER check_finishes_activity
AFTER INSERT OR UPDATE ON Crm_system.Activity
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

-- kopírování dat do kontaktní tabulky CONTACTS

ALTER TABLE contacts
ADD CONSTRAINT unique_email UNIQUE (email);

CREATE UNIQUE INDEX unique_contact_index
ON Contacts (first_name, last_name, email);

CREATE OR REPLACE FUNCTION copy_to_contacts()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO contacts (first_name, last_name, email)
    VALUES (NEW.first_name, NEW.last_name, NEW.email)
    ON CONFLICT (first_name, last_name, email) DO NOTHING;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER informations_copy
AFTER INSERT ON customers
FOR EACH ROW
EXECUTE FUNCTION copy_to_contacts();


-- Auditování změn zákazníků

CREATE OR REPLACE FUNCTION audit_customers()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit.audit_data (user_name, operation, new_value)
        VALUES (current_user, 'INSERT', row_to_json(NEW)::JSON);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit.audit_data (user_name, operation, old_value, new_value)
        VALUES (current_user, 'UPDATE', row_to_json(OLD)::JSON, row_to_json(NEW)::JSON);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit.audit_data (user_name, operation, old_value)
        VALUES (current_user, 'DELETE', row_to_json(OLD)::JSON);
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER audit_customers_trigger
AFTER INSERT OR UPDATE OR DELETE ON Crm_system.customers
FOR EACH ROW
EXECUTE FUNCTION Crm_System.audit_customers();





