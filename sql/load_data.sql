-- ============================================================
-- Rental License Analytics System - Data Load Script
-- Author: Jason
-- Description:
--   Inserts cleaned and deduplicated data from raw_scrape
--   into the normalized schema.
-- ============================================================

-- Insert unique properties
INSERT INTO property (address, property_type, total_unit_count)
SELECT DISTINCT address, property_type, total_unit_count
FROM raw_scrape
;

-- Insert unique properties and repeat this for Responsible Officer:
INSERT INTO party_information (name, address, city, state, zip_code, phone_number, email)
SELECT DISTINCT property_manager_name, property_manager_address, property_manager_city,
       property_manager_state, property_manager_zip_code, property_manager_telephone,
       property_manager_email_address
FROM raw_scrape
WHERE property_manager_name IS NOT NULL
;

INSERT INTO party_information (name, address, city, state, zip_code, phone_number, email)
SELECT DISTINCT responsible_officer_name, responsible_officer_address, responsible_officer_city,
       responsible_officer_state, responsible_officer_zip_code, responsible_officer_telephone,
       responsible_officer_email_address
FROM raw_scrape
WHERE responsible_officer_name IS NOT NULL
;

-- Link parties to properties (property_party_role) and repeat this for Responsible Officer:
INSERT INTO property_party_role (property_id, party_id, role)
SELECT DISTINCT
    p.property_id,
    pi.party_id,
    'Property Manager'
FROM raw_scrape r
JOIN property p ON p.address = r.address
JOIN party_information pi ON pi.name = r.property_manager_name AND pi.address = r.property_manager_address
;

INSERT INTO property_party_role (property_id, party_id, role)
SELECT DISTINCT
    p.property_id,
    pi.party_id,
    'Responsible Officer'
FROM raw_scrape r
JOIN property p ON p.address = r.address
JOIN party_information pi ON pi.name = r.responsible_officer_name AND pi.address = r.responsible_officer_address
;

-- Insert Rental Licenses:
INSERT INTO rental_license (property_id, license_number, expiration_date)
SELECT p.property_id, r.existing_license_number, r.license_expiration_date
FROM raw_scrape r
JOIN property p ON p.address = r.address
WHERE r.existing_license_number IS NOT NULL
;
