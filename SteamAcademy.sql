CREATE DATABASE steam_academy_db;

\c steam_academy_db;

CREATE TABLE coach(
    dni CHARACTER VARYING(15) UNIQUE NOT NULL,
    "name" CHARACTER VARYING(50) NOT NULL,
    last_name CHARACTER VARYING(50) NOT NULL,
    stack text[] NOT NULL,
    birthday DATE NOT NULL,
    cellphone NUMERIC NULL,
    entry_date DATE NOT NULL,
    departure_date DATE NULL,
    CONSTRAINT coach_pkey PRIMARY KEY (dni)
);

CREATE TABLE course(
    id SERIAL,
    "name" CHARACTER VARYING(50) UNIQUE NOT NULL,
    "description" TEXT NOT NULL UNIQUE,
    syllabus TEXT[] NOT NULL UNIQUE,
    duration CHARACTER VARYING(30) NOT NULL,
    price MONEY NOT NULL,
    CONSTRAINT course_pkey PRIMARY KEY (id)
);

CREATE TABLE coach_course(
    course_id INTEGER NOT NULL,
    coach_dni CHARACTER VARYING(15) NOT NULL,
    PRIMARY KEY (course_id, coach_dni),
    FOREIGN KEY (course_id) REFERENCES course(id),
    FOREIGN KEY (coach_dni) REFERENCES coach(dni)
);

CREATE TABLE attendant(
    cc CHARACTER VARYING(15) NOT NULL UNIQUE,
    full_name CHARACTER VARYING(100) NOT NULL,
    cellphone NUMERIC NOT NULL UNIQUE,
    CONSTRAINT attendant_pkey PRIMARY KEY (cc)
);

CREATE TABLE student(
    dni CHARACTER VARYING(15) NOT NULL UNIQUE,
    first_name CHARACTER VARYING(45) NOT NULL,
    last_name CHARACTER VARYING(45) NOT NULL,
    cellphone BIGINT NOT NULL,
    birthday DATE NOT NULL,
    entry_date DATE NOT NULL,
    departure_date DATE NULL,
    attendant_cc CHARACTER VARYING(15) NOT NULL,
    CONSTRAINT student_id PRIMARY KEY (dni),
    FOREIGN KEY (attendant_cc) REFERENCES attendant(cc)
);

CREATE TABLE student_course(
    student_dni CHARACTER VARYING(15) NOT NULL,
    course_id INTEGER NOT NULL,
    PRIMARY KEY (student_dni, course_id),
    FOREIGN KEY (student_dni) REFERENCES student(dni),
    FOREIGN KEY (course_id) REFERENCES course(id)
);