-- ============================================================
-- Rental License Analytics System - Reporting Views
-- Author: Jason
-- Description:
--   Views designed for analytics and Power BI reporting.
--   Includes license summaries, contact rollups, and time series.
-- ============================================================


-- ============================================================
-- View: current_license_summary
-- Description:
--   Provides a flattened view of each property with its license,
--   associated parties (manager + officer), and contact details.
--   Useful for compliance dashboards and property-level reporting.
-- ============================================================
CREATE OR REPLACE VIEW current_license_summary AS
SELECT
    p.address,
    p.property_type,
    p.total_unit_count,
    r.license_number,
    r.expiration_date,
    GROUP_CONCAT(pi.name SEPARATOR ', ') AS party_names,
    GROUP_CONCAT(ppr.role SEPARATOR ', ') AS party_roles,
    GROUP_CONCAT(pi.phone_number SEPARATOR ', ') AS phone_numbers,
    GROUP_CONCAT(pi.email SEPARATOR ', ') AS emails
FROM property p
JOIN rental_license r 
    ON p.property_id = r.property_id
JOIN property_party_role ppr 
    ON p.property_id = ppr.property_id
JOIN party_information pi 
    ON ppr.party_id = pi.party_id
WHERE r.expiration_date >= CURDATE()
GROUP BY
    p.address,
    p.property_type,
    p.total_unit_count,
    r.license_number,
    r.expiration_date
;


-- ============================================================
-- View: license_time_series
-- Description:
--   Aggregates active vs expired licenses by expiration date.
--   Ideal for time-series visuals in Power BI.
-- ============================================================
CREATE OR REPLACE VIEW license_time_series AS
SELECT
    rl.expiration_date,
    SUM(CASE WHEN rl.expiration_date >= CURDATE() THEN 1 ELSE 0 END) AS active_count,
    SUM(CASE WHEN rl.expiration_date < CURDATE() THEN 1 ELSE 0 END) AS expired_count
FROM rental_license rl
GROUP BY rl.expiration_date
ORDER BY rl.expiration_date
;
