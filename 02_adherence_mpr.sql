
-- Medication Possession Ratio (MPR) Calculation with Adherence Label

WITH adherence AS (
  SELECT 
    v.patient_id,
    SUM(v.days_supply) AS total_days,
    DATEDIFF(DAY, MIN(v.refill_date), MAX(v.refill_date)) + 1 AS days_between,
    COUNT(*) AS refills
  FROM visits v
  GROUP BY v.patient_id
)

SELECT 
  a.patient_id,
  p.age,
  p.gender,
  p.region,
  ROUND(a.total_days * 1.0 / a.days_between, 2) AS mpr,
  CASE 
    WHEN ROUND(a.total_days * 1.0 / a.days_between, 2) < 0.8 THEN 'Non-Adherent'
    ELSE 'Adherent'
  END AS adherence_status
FROM adherence a
JOIN patients p ON p.patient_id = a.patient_id;
