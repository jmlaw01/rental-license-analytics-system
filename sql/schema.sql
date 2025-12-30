-- ============================================================
-- Rental License Analytics System - Database Schema
-- Author: Jason
-- Description:
--   Normalized schema for properties, parties, roles, and
--   rental license data. Designed for clean analytics,
--   referential integrity, and Power BI reporting.
-- ============================================================

-- Property table
CREATE TABLE IF NOT EXISTS property (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(100) NOT NULL,
    property_type VARCHAR(30),
    total_unit_count INT,
    INDEX (address)
) ENGINE=InnoDB;

-- Party information table
CREATE TABLE IF NOT EXISTS party_information (
    party_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(70) NOT NULL,
    address VARCHAR(100),
    city VARCHAR(30),
    state VARCHAR(20),
    zip_code VARCHAR(50),
    phone_number VARCHAR(20),
    email VARCHAR(64)
) ENGINE=InnoDB;

-- Junction table linking properties to parties with roles
CREATE TABLE IF NOT EXISTS property_party_role (
    property_id INT NOT NULL,
    party_id INT NOT NULL,
    role VARCHAR(20) NOT NULL,
    PRIMARY KEY (property_id, party_id, role),
    FOREIGN KEY (property_id) REFERENCES property(property_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (party_id) REFERENCES party_information(party_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Rental license table
CREATE TABLE IF NOT EXISTS rental_license (
    license_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    license_number VARCHAR(20),
    expiration_date DATE,
    FOREIGN KEY (property_id) REFERENCES property(property_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    INDEX (license_number)
) ENGINE=InnoDB;
