-- Database: assignments

-- DROP DATABASE IF EXISTS assignments;

CREATE DATABASE assignments
    WITH
    OWNER = webapp
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- SCHEMA: week9

-- DROP SCHEMA IF EXISTS week9 ;

CREATE SCHEMA IF NOT EXISTS week9;
-- Table: week9.users

-- DROP TABLE IF EXISTS week9.users;

CREATE TABLE IF NOT EXISTS week9.users
(
    user_id uuid NOT NULL DEFAULT gen_random_uuid(),
    first_name character varying COLLATE pg_catalog."default" NOT NULL,
    last_name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (user_id)
)

TABLESPACE pg_default;
