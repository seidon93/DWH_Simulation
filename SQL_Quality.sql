CREATE SCHEMA CRM;

ALTER SCHEMA CRM OWNER TO CDO;

/* ACTIVITY TABLE */

-- kontrola správnosti datumu
ALTER TABLE crm.Activity
ADD CONSTRAINT check_activity_date
CHECK (activity_date <= NOW());

-- odstranění duplict
ALTER TABLE crm.Activity
ADD CONSTRAINT one_unique_activity
UNIQUE (Customer, Type, Activity_date);


-- funkce pro automatizovné mazání
CREATE OR REPLACE FUNCTION remove_finishes_activity()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Outcome = 'Successful' THEN
        DELETE FROM Crm.Crm.Activity WHERE ActivityID = NEW.ActivityID;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- triggrer mazání
CREATE TRIGGER check_finishes_activity
AFTER INSERT OR UPDATE ON Crm.Activity
FOR EACH ROW
EXECUTE FUNCTION remove_finishes_activity();






