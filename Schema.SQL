CREATE DATABASE IF NOT EXISTS hospital_db;

USE hospital_db;


CREATE TABLE IF NOT EXISTS patients (

    id INT AUTO_INCREMENT PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    age INT NOT NULL,

    gender VARCHAR(20) NOT NULL,

    phone VARCHAR(20),

    disease VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


CREATE TABLE IF NOT EXISTS doctors (

    id INT AUTO_INCREMENT PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    specialization VARCHAR(100) NOT NULL,

    phone VARCHAR(20)

);


CREATE TABLE IF NOT EXISTS beds (

    id INT AUTO_INCREMENT PRIMARY KEY,

    bed_number VARCHAR(20) NOT NULL UNIQUE,

    room_number VARCHAR(20) NOT NULL,

    status ENUM(
        'Available',
        'Occupied',
        'Maintenance'
    ) DEFAULT 'Available'

);


CREATE TABLE IF NOT EXISTS appointments (

    id INT AUTO_INCREMENT PRIMARY KEY,

    patient_id INT NOT NULL,

    doctor_id INT NOT NULL,

    appointment_date DATETIME NOT NULL,

    reason VARCHAR(255),

    status ENUM(
        'Scheduled',
        'Completed',
        'Cancelled'
    ) DEFAULT 'Scheduled',

    FOREIGN KEY (patient_id)
        REFERENCES patients(id),

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(id)

);


CREATE TABLE IF NOT EXISTS prescriptions (

    id INT AUTO_INCREMENT PRIMARY KEY,

    patient_id INT NOT NULL,

    doctor_id INT NOT NULL,

    medicine VARCHAR(255) NOT NULL,

    dosage VARCHAR(100),

    instructions VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (patient_id)
        REFERENCES patients(id),

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(id)

);


CREATE TABLE IF NOT EXISTS bills (

    id INT AUTO_INCREMENT PRIMARY KEY,

    patient_id INT NOT NULL,

    amount DECIMAL(10,2) NOT NULL,

    description VARCHAR(255),

    payment_status ENUM(
        'Pending',
        'Paid'
    ) DEFAULT 'Pending',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (patient_id)
        REFERENCES patients(id)

);


INSERT INTO doctors
(name, specialization, phone)

SELECT
    'Dr. Amit Kumar',
    'General Physician',
    '9876543210'

WHERE NOT EXISTS (

    SELECT 1
    FROM doctors
    WHERE name = 'Dr. Amit Kumar'

);


INSERT INTO beds
(bed_number, room_number, status)

SELECT
    'B-101',
    'R-01',
    'Available'

WHERE NOT EXISTS (

    SELECT 1
    FROM beds
    WHERE bed_number = 'B-101'

);


INSERT INTO beds
(bed_number, room_number, status)

SELECT
    'B-102',
    'R-01',
    'Available'

WHERE NOT EXISTS (

    SELECT 1
    FROM beds
    WHERE bed_number = 'B-102'

);
