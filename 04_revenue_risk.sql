
-- Revenue at Risk by Drug for Non-Adherent Patients

WITH non_adherent AS (
  SELECT patient_id
  FROM (
    SELECT 
      patient_id,
      ROUND(SUM(days_supply) * 1.0 / (DATEDIFF(DAY, MIN(refill_date), MAX(refill_date)) + 1), 2) AS mpr
    FROM visits
    GROUP BY patient_id
  ) sub
  WHERE mpr < 0.8
)

SELECT 
  c.drug_name,
  COUNT(DISTINCT c.patient_id) AS at_risk_patients,
  ROUND(SUM(c.claim_amount), 2) AS revenue_at_risk
FROM claims c
JOIN non_adherent na ON na.patient_id = c.patient_id
GROUP BY c.drug_name
ORDER BY revenue_at_risk DESC;
