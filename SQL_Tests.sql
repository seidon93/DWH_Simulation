-- test aktivity triggeru
INSERT INTO Crm_system.Activity
    ( Activity_Id, Customer, Type, Activity_Date, Outcome )
VALUES ( 1, 1, 'Phone', '2024-08-06 14:00:00', 'Other actions' );

SELECT *
FROM Crm_system.Activity;

INSERT INTO Crm_system.Activity
    ( Activity_Id, Customer, Type, Activity_Date, Outcome )
VALUES ( 3, 2, 'Meeting', '2024-01-02 09:00:00', 'Successful' );

INSERT INTO Crm.Crm_system.Customers
    ( Customer_Id, First_Name, Last_Name, Email, Phone_Nmb, Company )
VALUES ( 1, 'Elza', 'Smutná', 'elzaS@example.cz', 718154362, FALSE );

SET search_path TO "Crm_System";

SELECT *
FROM Crm_system.Customers;

SELECT *
FROM Information_Schema.Tables;


DO
$$
    BEGIN
        BEGIN
            INSERT INTO Crm_system.Customers
                ( First_Name, Last_Name, Email, Company )
            VALUES ( 'Radek', 'Černý', '(radekC)@example', FALSE );
        EXCEPTION
            WHEN OTHERS THEN
                RAISE;
        END;
    END
$$;


INSERT INTO Crm.Crm_system.Customers
    ( Customer_Id, First_Name, Last_Name, Email, Phone_Nmb, Company )
VALUES ( 2, 'Jan', 'Veliký', 'JanVelkej@example.cz', 711258367, TRUE );



INSERT INTO Crm.Crm_system.Customers
    ( First_Name, Last_Name, Email, Company )
VALUES ( 'Arnošt', 'Novák', 'novakarnost01@example.cz', TRUE );

SELECT *
FROM Contacts;


INSERT INTO Crm.Crm_system.Customers
    ( First_Name, Last_Name, Email, Company )
VALUES ( 'Adéla', 'Svoboda', 'AdelSvoboda@firma.cz', TRUE );


