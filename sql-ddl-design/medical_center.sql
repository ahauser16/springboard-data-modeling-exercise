-- STEPS TO RUN FROM THE TERMINAL:
----STEP ONE--start the PostgreSQL service using the command 'sudo service postgresql start'
------'sudo service postgresql start' starts the PostgreSQL service.  After running this command, you should be able to connect to your PostgreSQL server.  Then after running this command, you should be able to connect to your PostgreSQL server by running the next command below.

----STEP TWO--cd into the directory with the sql file you want to run and run the command 'psql -U username -f medical_center.sql'.  After running this script you can connect to the medical_center database and list all tables to verify that they were created.
------The psql -U username -f medical_center.sql command is used to run SQL commands from a file in a PostgreSQL database.
--------'psql': This is the command-line interface for PostgreSQL. It allows you to interact with the PostgreSQL server and perform database operations.
--------'-U username: The -U option is used to specify the username for the PostgreSQL database. You should replace username with your actual PostgreSQL username. When you run the command, you'll be prompted to enter the password for this user.
--------'-f medical_center.sql': The -f option is used to specify a file that contains SQL commands to be run. In this case, medical_center.sql is the file containing the SQL commands. This file should be in the current directory when you run the command, or you should provide the full path to the file.

--STEP THREE-- you can now connect to the psql interface and medical_center database by running the command 'psql -U username -d medical_center' and then you can list all tables to verify that they were created by running the command '\dt'.

DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center;

--NOTES
--homework prompt - Part One: Medical Center
-- Design the schema for a medical center.
---- A medical center employs several doctors
---- A doctors can see many patients
---- A patient can be seen by many doctors
---- During a visit, a patient may be diagnosed to have one or more diseases.

-- Design methodology: Based on the requirements, we can create the following tables:
---- Doctors - to store information about doctors.
---- Patients - to store information about patients.
---- Diseases - to store information about diseases.
---- Visits - to store information about each visit a patient makes.
---- Doctor_Patient - a junction table to handle the many-to-many relationship between doctors and patients.
---- Visit_Diseases - a junction table to handle the many-to-many relationship between visits and diseases.

--DDL for creating tables:
CREATE TABLE doctors (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  specialty TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  phone_number TEXT,
  address TEXT,
  education TEXT,
  experience_years INT CHECK (experience_years >= 0),
  certifications TEXT,
  availability TEXT,
  gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')), -- M for Male, F for Female, O for Other
  language TEXT,
  rating DECIMAL(2,1) CHECK (rating >= 0 AND rating <= 5) -- rating from 0.0 to 5.0
);

CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  date_of_birth DATE NOT NULL,
  email TEXT NOT NULL UNIQUE,
  phone_number TEXT,
  address TEXT,
  gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')), -- M for Male, F for Female, O for Other
  emergency_contact TEXT,
  insurance_details TEXT,
  medical_history TEXT,
  allergies TEXT,
  current_medications TEXT,
  primary_care_doctor TEXT
);

CREATE TABLE diseases (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  category TEXT,
  symptoms TEXT,
  risk_factors TEXT,
  prevention TEXT,
  treatment TEXT,
  prognosis TEXT,
  mortality_rate DECIMAL(5,2), -- assuming mortality rate is a percentage
  incubation_period TEXT
);

CREATE TABLE visits (
  id SERIAL PRIMARY KEY,
  patient_id INT REFERENCES Patients(id),
  doctor_id INT REFERENCES Doctors(id),
  visit_date DATE NOT NULL,
  visit_time TIME,
  reason_for_visit TEXT,
  diagnosis TEXT,
  treatment_prescribed TEXT,
  follow_up_needed BOOLEAN,
  follow_up_date DATE,
  notes TEXT
);

CREATE TABLE doctor_patient (
  doctor_id INT REFERENCES Doctors(id),
  patient_id INT REFERENCES Patients(id),
  date_assigned DATE,
  active BOOLEAN,
  last_visit_date DATE,
  next_visit_date DATE,
  notes TEXT,
  PRIMARY KEY(doctor_id, patient_id)
);

CREATE TABLE visit_diseases (
  visit_id INT REFERENCES Visits(id),
  disease_id INT REFERENCES Diseases(id),
  diagnosis_date DATE,
  severity TEXT CHECK (severity IN ('mild', 'moderate', 'severe')),
  symptoms_present TEXT,
  treatment_plan TEXT,
  follow_up_required BOOLEAN,
  follow_up_date DATE,
  PRIMARY KEY(visit_id, disease_id)
);

--SQL to insert data into these tables:
-- Insert into doctors
INSERT INTO doctors (name, specialty, email, phone_number, address, education, experience_years, certifications, availability, gender, language, rating)
VALUES ('Dr. John Doe', 'Cardiology', 'johndoe@example.com', '1234567890', '123 Main St', 'MD', 10, 'Board Certified', 'Monday to Friday', 'M', 'English', 4.5);

-- Insert into patients
INSERT INTO patients (name, date_of_birth, email, phone_number, address, gender, emergency_contact, insurance_details, medical_history, allergies, current_medications, primary_care_doctor)
VALUES ('Jane Smith', '1980-01-01', 'janesmith@example.com', '0987654321', '456 Elm St', 'F', 'John Smith', 'Insurance Co. Policy #1234', 'None', 'None', 'None', 'Dr. John Doe');

-- Insert into diseases
INSERT INTO diseases (name, description, category, symptoms, risk_factors, prevention, treatment, prognosis, mortality_rate, incubation_period)
VALUES ('Influenza', 'A viral infection that attacks your respiratory system', 'Infectious', 'Fever, cough, sore throat', 'Close contact', 'Vaccination', 'Rest and hydration', 'Usually self-resolving', 0.1, '1 to 4 days');

-- Insert into visits
INSERT INTO visits (patient_id, doctor_id, visit_date, visit_time, reason_for_visit, diagnosis, treatment_prescribed, follow_up_needed, follow_up_date, notes)
VALUES (1, 1, '2022-01-01', '10:00:00', 'Annual checkup', 'Healthy', 'None', FALSE, NULL, 'Patient in good health');

-- Insert into doctor_patient
INSERT INTO doctor_patient (doctor_id, patient_id, date_assigned, active, last_visit_date, next_visit_date, notes)
VALUES (1, 1, '2021-01-01', TRUE, '2022-01-01', '2023-01-01', 'Annual checkup scheduled for next year');

-- Insert into visit_diseases
INSERT INTO visit_diseases (visit_id, disease_id, diagnosis_date, severity, symptoms_present, treatment_plan, follow_up_required, follow_up_date)
VALUES (1, 1, '2022-01-01', 'mild', 'None', 'None', FALSE, NULL);

--design summary: This schema allows for the relationships described in the use case: a medical center employs several doctors, doctors can see many patients, a patient can be seen by many doctors, and during a visit, a patient may be diagnosed with one or more diseases.

--HELPFUL PSQL COMMANDS--
-- \l: List all databases.
-- \c database_name: Connect to a different database.
-- \d table_name: Show the structure of a specific table.
-- \du: List all users.
-- \dn: List all schemas.
-- \dp: List all privileges.
-- \dt: List all tables.
-- \di: List all indexes.
-- \df: List all functions.
-- \dv: List all views.
-- \dx: List all extensions.
-- \timing: Toggle timing of commands. When on, psql will show the time taken to execute each command.
-- \q: Quit psql.