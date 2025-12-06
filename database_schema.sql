-- E-commerce Automation Demo - Database Schema
-- Database: rahulshettyacademy

CREATE DATABASE IF NOT EXISTS rahulshettyacademy;
USE rahulshettyacademy;

-- ============================================
-- Table: RegistrationDetails
-- Stores user registration information
-- ============================================
CREATE TABLE RegistrationDetails (
    id_number VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    occupation VARCHAR(100),
    gender VARCHAR(10),
    password VARCHAR(255), -- Note: In production, always hash passwords!
    is_18_or_older BOOLEAN DEFAULT FALSE
);

-- ============================================
-- Table: UserNames
-- Stores email addresses linked to users
-- ============================================
CREATE TABLE UserNames (
    id_number VARCHAR(50) PRIMARY KEY,
    email VARCHAR(200) UNIQUE NOT NULL,
    FOREIGN KEY (id_number) REFERENCES RegistrationDetails(id_number)
);

-- ============================================
-- Sample Test Data
-- ============================================

-- Insert sample users for testing
INSERT INTO RegistrationDetails (id_number, first_name, last_name, phone_number, occupation, gender, password, is_18_or_older) VALUES
('USER001', 'John', 'Doe', '123-456-7890', 'Engineer', 'Male', 'Pass@123', TRUE),
('USER002', 'Jane', 'Smith', '987-654-3210', 'Teacher', 'Female', 'Jane@456', TRUE),
('USER003', 'Peter', 'Jones', '555-123-4567', 'Student', 'Male', 'Peter@789', FALSE),
('USER004', 'Alice', 'Brown', '111-222-3333', 'Doctor', 'Female', 'Alice@321', TRUE),
('USER005', 'David', 'Wilson', '444-555-6666', 'Artist', 'Male', 'David@654', TRUE);

-- Insert corresponding emails
INSERT INTO UserNames (id_number, email) VALUES
('USER001', 'JohnDoe434@gmail.com'),
('USER002', 'JaneSmith@gmail.com'),
('USER003', 'PeterJones@gmail.com'),
('USER004', 'AliceBrown@gmail.com'),
('USER005', 'DavidWilson@gmail.com');

-- ============================================
-- Useful Queries
-- ============================================

-- Get random user for testing
-- SELECT * FROM RegistrationDetails ORDER BY RAND() LIMIT 1;
-- SELECT * FROM UserNames ORDER BY RAND() LIMIT 1;

-- Join query to get complete user information
-- SELECT rd.*, un.email 
-- FROM RegistrationDetails rd 
-- JOIN UserNames un ON rd.id_number = un.id_number;

-- ============================================
-- Security Note
-- ============================================
-- This is a DEMO database for testing purposes only.
-- In production:
-- 1. Always hash passwords using bcrypt or similar
-- 2. Use proper access controls
-- 3. Implement proper data validation
-- 4. Never store sensitive data in plain text
