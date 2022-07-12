-- Create Clinic Database

CREATE DATABASE clinic-db;

-- Create patients table

CREATE TABLE patients (
    id INT PRIMARY KEY,
    name VARCHAR,
    date_of_birth DATE
);

-- Create medical histories table

CREATE TABLE medical_histories (
    id INT PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR
);

-- Create invoices table

CREATE TABLE invoices (
  id INT PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history__id INT
);

-- Create invoice_items table

CREATE TABLE invoice_items (
  id INT PRIMARY KEY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT
);

-- Create treatments table

CREATE TABLE treatments(
  id INT PRIMARY KEY,
  type VARCHAR,
  name VARCHAR
);

-- Create relationship one to many between medical histories table with patients talbe

ALTER TABLE medical_histories
ADD FOREIGN KEY (patient_id) REFERENCES patients(id);

-- Create relationship one to one between medical histories table with invoices talbe

ALTER TABLE invoices
ADD FOREIGN KEY (medical_history__id) REFERENCES medical_histories(id);

-- Create relationship one to many between invoices table with invoices items

ALTER TABLE invoice_items
ADD FOREIGN KEY (invoice_id) REFERENCES invoices(id);

-- Create relationship one to many between treatment table with invoices items

ALTER TABLE invoice_items
ADD FOREIGN KEY (treatment_id) REFERENCES treatments(id);

-- Create the table linking medical_histories and treatments many to many
CREATE TABLE medical_histories_treatments (
medical_histories_id INT,
treatments_id INT,
CONSTRAINT fk_medical_histories FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
CONSTRAINT fk_treatments FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

--Create indexes to be able to get data very faster from the database
CREATE INDEX medical_history_patient_id ON medical_histories (patient_id);
CREATE INDEX invoices_medical_history_id ON invoices (medical_history_id);
CREATE INDEX invoice_items_invoice_id ON invoice_items (invoice_id);
CREATE INDEX invoice_items_treatments_id_index ON invoice_items(treament_id);
CREATE INDEX medical_history_and_treatment_medical_history_index ON medical_histories_treaments (medical_history_id);
CREATE INDEX medical_history_treaments_treament_id_index ON medical_histories_treaments(treament_id);
