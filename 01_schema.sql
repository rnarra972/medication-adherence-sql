
-- Advanced Schema with Indexing and Partitioning (Snowflake/PostgreSQL Compatible)

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    age INT,
    gender CHAR(1),
    region VARCHAR(20)
);

CREATE TABLE prescriptions (
    prescription_id INT PRIMARY KEY,
    patient_id INT,
    drug_name VARCHAR(50),
    prescription_date TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

CREATE TABLE visits (
    visit_id INT PRIMARY KEY,
    patient_id INT,
    refill_date TIMESTAMP,
    days_supply INT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

CREATE TABLE claims (
    claim_id INT PRIMARY KEY,
    patient_id INT,
    claim_amount DECIMAL(10,2),
    claim_date TIMESTAMP,
    drug_name VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
