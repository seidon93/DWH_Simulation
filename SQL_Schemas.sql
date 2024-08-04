COMMENT ON DATABASE Crm IS 'Odpovědná osoba je CDO';
CREATE SCHEMA Users;
ALTER DATABASE Crm OWNER TO Cdo;
GRANT ALL PRIVILEGES ON DATABASE Crm TO Administrator;



GRANT CONNECT, TEMPORARY ON DATABASE crm TO technical_group;
GRANT USAGE ON SCHEMA Users TO technical_group;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA Users TO technical_group;
GRANT CONNECT ON DATABASE crm TO analysis_group;

-- GRANT SELECT ON ALL TABLES IN SCHEMA  Users TO analysis_group;


CREATE SCHEMA Activity;
ALTER DATABASE Crm OWNER TO Cdo;
GRANT ALL PRIVILEGES ON DATABASE Crm TO Cdo;

CREATE SCHEMA Data_Quality;
ALTER SCHEMA Data_Quality OWNER TO Cdo;
GRANT ALL PRIVILEGES ON DATABASE Crm TO Cdo;


CREATE SCHEMA Audit;
ALTER SCHEMA Audit OWNER TO Cdo;
GRANT ALL PRIVILEGES ON DATABASE Crm TO Cdo;



CREATE SCHEMA Security;
ALTER SCHEMA Security OWNER TO Cdo;
GRANT ALL PRIVILEGES ON DATABASE Crm TO Cdo;