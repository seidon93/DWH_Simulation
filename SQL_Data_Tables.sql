-- SCHEMA users (gov)
CREATE TABLE IF NOT EXISTS Users.Uzivatel (
    User_Id  SERIAL PRIMARY KEY,
    Username VARCHAR(255),
    Password VARCHAR(255),
    Email    VARCHAR(255),
    Role     VARCHAR(50)
);

-- SCHEMA CRM (all tables)
GRANT CREATE, USAGE ON SCHEMA Crm_System TO Administrator, Technical_Group, Dev_Group;

GRANT USAGE ON SCHEMA Crm_System TO Analysis_Group;


CREATE TABLE Crm_System.Customers (
    Customer_Id SERIAL,
    First_Name  VARCHAR(255) NOT NULL,
    Last_Name   VARCHAR(255) NOT NULL,
    Full_Name   VARCHAR(255),
    Email       VARCHAR(255) NOT NULL,
    Phone_Nmb   INTEGER,
    Company     BOOLEAN      NOT NULL
);

CREATE UNIQUE INDEX Customers_Uin
    ON Crm_System.Customers ( Customer_Id );

ALTER TABLE Crm_System.Customers
    ADD CONSTRAINT Customers_Pk
        PRIMARY KEY ( Customer_Id );

CREATE TABLE Crm_System.Contacts (
    Contact_Id   SERIAL
        CONSTRAINT Contacts_Pk PRIMARY KEY,
    Title        VARCHAR(255),
    First_Name   VARCHAR(255) NOT NULL,
    Last_Name    VARCHAR(255) NOT NULL,
    Full_Name    VARCHAR(255),
    Email        VARCHAR(255) NOT NULL,
    Company_Name VARCHAR(255)
);

CREATE TABLE Crm_System.Campagin (
    Campagin_Id   SERIAL
        CONSTRAINT Campagin_Pk PRIMARY KEY,
    Campagin_Name VARCHAR(255),
    Start_Date    DATE    NOT NULL,
    End_Date      DATE,
    Status        VARCHAR(255),
    Budget        INTEGER NOT NULL
);

CREATE TABLE Crm_System.Activity (
    Activity_Id   SERIAL
        CONSTRAINT Activity_Pk PRIMARY KEY,
    Customer      INTEGER NOT NULL,
    Activity_Date DATE    NOT NULL,
    Outcome       TEXT    NOT NULL,
    Type          TEXT    NOT NULL
        CONSTRAINT Check_Activity_Type
            CHECK (Type IN ( 'Email', 'Phone', 'Meeting' )),
    CONSTRAINT Check_Outcome
        CHECK (Outcome IN ( 'Successful', 'Unsuccessful', 'Other actions' ))
);

CREATE TABLE Crm_System.Cust_Case (

    Case_Id     SERIAL
        CONSTRAINT Case_Pk PRIMARY KEY,
    Customer    INTEGER,
    Problem     VARCHAR(255) NOT NULL,
    Description TEXT         NOT NULL,
    Status      VARCHAR(255) NOT NULL,
    Priority    VARCHAR(255) NOT NULL,
    Created     TIMESTAMP,
    Solved      TIMESTAMP,
    CONSTRAINT Check_Status
        CHECK (Status IN ( 'Open', 'Closed', 'In the solution' )),
    CONSTRAINT Check_Priority
        CHECK (Priority IN ( 'Low', 'Middle', 'High' ))
);
/* AUDIT SCHEMA */

CREATE TABLE Audit.Audit_Data (
    Audit_Id    SERIAL PRIMARY KEY,
    User_Name   VARCHAR(50),
    Operation   VARCHAR(10),
    Old_Value   Json,
    New_Value   Json,
    Change_Time TIMESTAMP DEFAULT current_timestamp
);

/* Fact table */

CREATE TABLE Crm_Facts (
    Activity  INT,
    Campagin  INT,
    Contacts  INT,
    Cust_Case INT,
    Customer  INT

)