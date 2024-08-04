CREATE TEMP TABLE t_user (
    user_ID SERIAL PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(255),
    email VARCHAR(100),
    role VARCHAR(50)
);

COPY t_user (User_Id, Username, password, email, role)
FROM 'C:\Users\###\Users.csv'
DELIMITER ';'
CSV HEADER;

CREATE EXTENSION pgcrypto;

INSERT INTO Users.uzivatel  (username, password, email, role)
SELECT
    username,
    crypt(password, gen_salt('bf')),
    email,
    role
FROM t_user;

SELECT  * FROM Users.Uzivatel;

DROP TABLE T_User;



SELECT rolname
FROM pg_roles;

SELECT U.Username, U.role
FROM users.uzivatel  AS U
JOIN pg_roles R ON U.role = R.rolname
WHERE R.rolname IS NOT NULL;


DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT DISTINCT role
        FROM users.uzivatel
        JOIN pg_roles ON users.uzivatel.role = pg_roles.rolname
        WHERE pg_roles.rolname IS NOT NULL
    LOOP
        EXECUTE format('GRANT SELECT ON ALL TABLES IN SCHEMA users TO %I;', r.role);
    END LOOP;
END $$;






