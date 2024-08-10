-- test aktivity triggeru
INSERT INTO crm.Activity
    (Activity_Id, Customer, Type, Activity_Date, Outcome)
VALUES (1, 1, 'Phone',  '2024-08-06 14:00:00', 'Other actions');

SELECT * FROM crm.Activity;

INSERT INTO crm.Activity
    (Activity_Id, Customer, Type, Activity_Date, Outcome)
VALUES (3,2,'Meeting','2024-01-02 09:00:00', 'Successful');

INSERT INTO Crm."Crm_system".customers
    (customer_id, first_name, last_name, email, phone_nmb, company)
VALUES (1, 'Elza', 'Smutná', 'elzaS@example.cz', 718154362, FALSE);

SET search_path TO "Crm_System";

SELECT * FROM "Crm_system".customers;

SELECT * FROM information_schema.tables;


DO $$
BEGIN
    BEGIN
        INSERT INTO "Crm_system".customers
            (first_name, last_name, email, Company)
        VALUES ('Radek', 'Černý', '(radekC)@example', FALSE);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END;
END $$;


INSERT INTO Crm."Crm_system".customers
    (customer_id, first_name, last_name, email, phone_nmb, company)
VALUES
    (2, 'Jan', 'Veliký', 'JanVelkej@example.cz', 711258367, TRUE);