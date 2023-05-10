CREATE DATABASE clinic;

CREATE TABLE patients(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE medical_histories(
    id INT GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT NOT NULL,
    status VARCHAR(255),
    FOREIGN KEY(patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
);

CREATE TABLE treatments(
    id INT GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE medical_histories_treatments(
    history_id INT NOT NULL,
    treatment_id INT NOT NULL,
    FOREIGN KEY(history_id) REFERENCES medical_histories(id) ON DELETE CASCADE,
    FOREIGN KEY(treatment_id) REFERENCES treatments(id) ON DELETE CASCADE,
    PRIMARY KEY(history_id, treatment_id)
);

CREATE TABLE invoices (
    id INT NOT NULL,
    total_amount DECIMAL NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    payed_at TIMESTAMP NOT NULL,
    history_id INT UNIQUE NOT NULL,
    FOREIGN KEY(history_id) REFERENCES medical_histories(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
);

CREATE TABLE invoice_items (
    id INT NOT NULL,
    unit_price DECIMAL NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL NOT NULL,
    invoice_id INT NOT NULL,
    treatment_id INT NOT NULL,
    FOREIGN KEY(invoice_id) REFERENCES invoices(id) ON DELETE CASCADE,
    FOREIGN KEY(treatment_id) REFERENCES treatments(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
);
CREATE INDEX patient_id_index ON medical_histories(patient_id);
CREATE INDEX treatment_id_index ON medical_histories_treatments(treatment_id);
CREATE INDEX history_id_index ON medical_histories_treatments(history_id);
CREATE INDEX invoice_id_index ON invoice_items(invoice_id);

