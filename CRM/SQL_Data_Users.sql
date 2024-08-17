CREATE USER CDO
   LOGIN SUPERUSER ENCRYPTED PASSWORD 'paswordcdo';

SET search_path = "Users";

CREATE ROLE Administrator
    CREATEDB
    NOINHERIT
    REPLICATION;

COMMENT ON ROLE Administrator IS 'Zástupce superuživatele';

GRANT ALL PRIVILEGES ON DATABASE Crm TO Administrator WITH GRANT OPTION;


CREATE ROLE Technik
    NOSUPERUSER
    CREATEDB
    CREATEROLE
    LOGIN PASSWORD 'Support'
    REPLICATION
    NOBYPASSRLS;

COMMENT ON ROLE Technik IS 'Technický pracovník';



CREATE ROLE Developer
    NOCREATEROLE
    NOBYPASSRLS
    CREATEDB
    LOGIN PASSWORD 'Devworker';

COMMENT ON ROLE Developer IS 'Vývojář';



CREATE ROLE Analytik
    NOSUPERUSER
    NOINHERIT
    NOREPLICATION
    NOBYPASSRLS
    LOGIN PASSWORD 'datamaniak';

COMMENT ON ROLE Analytik IS 'Osoba odpovědná za výsledky z dat';


CREATE USER alice WITH ENCRYPTED PASSWORD '11111';
CREATE USER donald WITH ENCRYPTED PASSWORD '22222';
CREATE USER jelena WITH ENCRYPTED PASSWORD '33333';
CREATE USER karlos WITH ENCRYPTED PASSWORD '44444';
CREATE USER elis WITH ENCRYPTED PASSWORD '55555';

CREATE GROUP dev_group WITH USER Alice, Donald;
CREATE GROUP technical_group WITH ROLE Technik;
CREATE GROUP analysis_group WITH ROLE  Analytik;

GRANT Administrator TO Jelena;
GRANT Technik TO  Karlos;
GRANT Analytik To Elis;

ALTER ROLE Cdo CREATEROLE;
