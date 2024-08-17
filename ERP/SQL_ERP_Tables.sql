USE Finance;

CREATE TABLE IF NOT EXISTS Accounts (
    Account_Id   INT AUTO_INCREMENT,
    Account_Name VARCHAR(255)                                                      NOT NULL,
    Account_Type ENUM ('Aktivum', 'Pasivum', 'Vlastní kapitál', 'Příjem', 'Výdej') NULL,
    Parent_Acc   INT DEFAULT NULL                                                  NULL,
    CONSTRAINT Accounts_Pk
        PRIMARY KEY ( Account_Id ),
    CONSTRAINT Accounts_Fk
        FOREIGN KEY ( Parent_Acc ) REFERENCES Accounts ( Account_Id )
);


CREATE TABLE IF NOT EXISTS Account_Book (
    Book_Id         INT AUTO_INCREMENT,
    Account_Id      INT           NOT NULL,
    Write_Date      DATE          NOT NULL,
    Acc_Desritption NCHAR(255)    NULL,
    Debit           DOUBLE(20, 2) NULL,
    Credit          DOUBLE(20, 2) NULL,
    CONSTRAINT Account_Book_Pk
        PRIMARY KEY ( Book_Id )
)
    COMMENT 'Účetní kniha obsahující veškeré záznamy';

CREATE TABLE IF NOT EXISTS Invoices (
    Invoice_Id   INT AUTO_INCREMENT,
    Invoice_Code NCHAR(100)                           NOT NULL,
    Customer_Id  INT                                  NOT NULL,
    Issue_Date   DATE                                 NOT NULL,
    Due_Date     DATE                                 NOT NULL,
    Total_Amount DOUBLE(20, 2)                        NOT NULL,
    Status       ENUM ('Unpaid', 'Paid', 'Cancelled') NOT NULL,
    CONSTRAINT Invoices_Pk
        PRIMARY KEY ( Invoice_Id )
);

CREATE TABLE IF NOT EXISTS Invoices_Items (
    Invoice_Item_Id INT AUTO_INCREMENT,
    Invoice_Id      INT           NOT NULL,
    Quantity        INT           NOT NULL,
    Unit_Price      DOUBLE(20, 2) NOT NULL,
    Total_Price     DOUBLE(20, 2) AS (Quantity * Unit_Price),
    CONSTRAINT Invoices_Items_Pk
        PRIMARY KEY ( Invoice_Item_Id )
);

CREATE TABLE IF NOT EXISTS Invoice_Tax (
    Invoice_Tax_Id INT AUTO_INCREMENT,
    Invoice_Id     INT           NOT NULL,
    Tax_Id         INT           NOT NULL,
    Tax_Amount     DOUBLE(10, 2) NOT NULL,
    CONSTRAINT Invoice_Tax_Pk
        PRIMARY KEY ( Invoice_Tax_Id )
);

CREATE TABLE IF NOT EXISTS Taxes (
    Tax_Id   INT AUTO_INCREMENT,
    Tax_Rate DECIMAL(3, 2)                                 NOT NULL,
    Tax_Type ENUM ('Daň z příjmu', 'Daň z prodeje', 'DPH') NOT NULL,
    CONSTRAINT Taxes_Pk
        PRIMARY KEY ( Tax_Id )
);


CREATE TABLE IF NOT EXISTS Payments (
    Payment_Id      INT AUTO_INCREMENT,
    Invoice_Id      INT                                                           NOT NULL,
    Payment_Date    DATE                                                          NOT NULL,
    Amount          DOUBLE(20, 2)                                                 NOT NULL,
    Payment_Methond ENUM ('Kreditní karta', 'Hotovost', 'Bankovní převod', 'Šek') NOT NULL,
    CONSTRAINT Payments_Pk
        PRIMARY KEY ( Payment_Id )
);

CREATE TABLE IF NOT EXISTS Customers_Inv (
    Customer_Id     INT AUTO_INCREMENT,
    Customer_Name   NCHAR(255)   NOT NULL,
    Billing_Address TEXT         NULL,
    Contact         VARCHAR(255) NOT NULL,
    CONSTRAINT Customers_Pk
        PRIMARY KEY ( Customer_Id )
);

CREATE TABLE IF NOT EXISTS Vendors (
    Vendor_Id       INT AUTO_INCREMENT,
    Vendor_Name     NCHAR(255)   NOT NULL,
    Billing_Address TEXT         NULL,
    Contact         VARCHAR(255) NOT NULL,
    CONSTRAINT Vendors_Pk
        PRIMARY KEY ( Vendor_Id )
);


create index account_book_account_id_index
    on account_book (account_id);

create index invoices_customer_id_index
    on invoices (customer_id);

create index invoices_items_invoice_id_index
    on invoices_items (invoice_id);

create index payments_invoice_id_index
    on payments (invoice_id);
