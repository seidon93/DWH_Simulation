USE Finance;

CREATE TABLE IF NOT EXISTS Accounts
(
    Account_Id   INT AUTO_INCREMENT,
    Account_Name VARCHAR(255)                                                      NOT NULL,
    Account_Type ENUM ('Aktivum', 'Pasivum', 'Vlastní kapitál', 'Příjem', 'Výdej') NULL,
    Parent_Acc   INT DEFAULT NULL                                                  NULL,
    CONSTRAINT Accounts_Pk
        PRIMARY KEY ( Account_Id ),
    CONSTRAINT Accounts_Fk
        FOREIGN KEY ( Parent_Acc ) REFERENCES Accounts ( Account_Id )
);


CREATE TABLE IF NOT EXISTS Account_Book
(
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

CREATE TABLE IF NOT EXISTS Invoices
(
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

create table IF NOT EXISTS INVOICES_ITEMS
(
    invoice_item_id int auto_increment,
    invoice_id      int           not null,
    quantity        int           not null,
    unit_price      DOUBLE(20, 2) not null,
    total_price     DOUBLE(20, 2) AS (Quantity * Unit_Price),
    constraint INVOICES_ITEMS_pk
        primary key (invoice_item_id)
);

create table IF NOT EXISTS invoice_tax
(
    invoice_tax_id int auto_increment,
    invoice_id     int           not null,
    tax_id         int           not null,
    tax_amount     DOUBLE(10, 2) not null,
    constraint invoice_tax_pk
        primary key (invoice_tax_id)
);

create table  IF NOT EXISTS taxes
(
    tax_id   int auto_increment,
    tax_rate DECIMAL(3, 2)                                 not null,
    tax_type ENUM ('Daň z příjmu', 'Daň z prodeje', 'DPH') not null,
    constraint taxes_pk
        primary key (tax_id)
);


create table IF NOT EXISTS Payments
(
    payment_id      int auto_increment,
    invoice_id      int                                                           not null,
    payment_date    DATE                                                          not null,
    Amount          DOUBLE(20, 2)                                                 not null,
    Payment_methond ENUM ('Kreditní karta', 'Hotovost', 'Bankovní převod', 'Šek') not null,
    constraint Payments_pk
        primary key (payment_id)
);

create table IF NOT EXISTS Customers_inv
(
    customer_id     int auto_increment,
    Customer_name   NCHAR(255)   not null,
    billing_address TEXT         null,
    contact         varchar(255) not null,
    constraint Customers_pk
        primary key (customer_id)
);

create table IF NOT EXISTS Vendors
(
    vendor_id int auto_increment,
    vendor_name   NCHAR(255)   not null,
    billing_address TEXT         null,
    contact         varchar(255) not null,
    constraint Vendors_pk
        primary key (vendor_id)
);




