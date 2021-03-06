-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE public.employee_activation_by_employers
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    employer_id integer NOT NULL,
    confirmed_employee_id integer NOT NULL,
    is_confirmed bit(1) NOT NULL,
    confirmed_date date,
    PRIMARY KEY (id)
);

CREATE TABLE public.employers
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    company_name character varying(50) NOT NULL,
    web_adress character varying(80) NOT NULL,
    email character varying(50) NOT NULL,
    tel_number character(11) NOT NULL,
    job_id integer NOT NULL,
    user_id integer,
    PRIMARY KEY (id)
);

CREATE TABLE public.employers_job_positions
(
    employer_job_id integer NOT NULL,
    job_position_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    PRIMARY KEY (employer_job_id)
);

CREATE TABLE public.job_positions
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    job_name character varying(80) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.job_seekers
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    first_name character varying(50) NOT NULL,
    last_name character varying NOT NULL,
    birth_date date NOT NULL,
    national_id character(11) NOT NULL,
    user_id integer,
    PRIMARY KEY (id)
);

CREATE TABLE public.job_seekers_job_positions
(
    job_seeker_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    job_position_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    PRIMARY KEY (job_seeker_id)
);

CREATE TABLE public.mernis
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    national_id character(11) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.staffs_positions
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    system_employees_id integer NOT NULL,
    position_name character varying(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.system_employees
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    position_id integer NOT NULL,
    user_id integer,
    PRIMARY KEY (id)
);

CREATE TABLE public.system_employees_employer_activation_by_employess
(
    system_employees_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    employee_activation_by_employers_confirmed_employee_id integer NOT NULL
);

CREATE TABLE public.system_employees_users
(
    system_employees_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    users_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 )
);

CREATE TABLE public.users
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    email bit varying(50) NOT NULL,
    password bit varying(50) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE public.employee_activation_by_employers
    ADD FOREIGN KEY (confirmed_employee_id)
    REFERENCES public.job_seekers (id)
    NOT VALID;


ALTER TABLE public.employee_activation_by_employers
    ADD FOREIGN KEY (employer_id)
    REFERENCES public.employers (id)
    NOT VALID;


ALTER TABLE public.employers
    ADD FOREIGN KEY (job_id)
    REFERENCES public.job_positions (id)
    NOT VALID;


ALTER TABLE public.employers
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.employers
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.employers_job_positions
    ADD FOREIGN KEY (employer_job_id)
    REFERENCES public.employers (id)
    NOT VALID;


ALTER TABLE public.employers_job_positions
    ADD FOREIGN KEY (job_position_id)
    REFERENCES public.job_positions (id)
    NOT VALID;


ALTER TABLE public.job_seekers
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;


ALTER TABLE public.job_seekers_job_positions
    ADD FOREIGN KEY (job_seeker_id)
    REFERENCES public.job_positions (id)
    NOT VALID;


ALTER TABLE public.job_seekers_job_positions
    ADD FOREIGN KEY (job_seeker_id)
    REFERENCES public.job_seekers (id)
    NOT VALID;


ALTER TABLE public.system_employees
    ADD FOREIGN KEY (position_id)
    REFERENCES public.job_positions (id)
    NOT VALID;


ALTER TABLE public.system_employees
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (id)
    NOT VALID;

END;