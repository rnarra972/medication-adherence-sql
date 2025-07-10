
-- Advanced Refill Gap Analysis with Rolling Window

SELECT 
  v.patient_id,
  v.refill_date,
  v.days_supply,
  LAG(v.refill_date) OVER (PARTITION BY v.patient_id ORDER BY v.refill_date) AS last_refill,
  DATEDIFF(DAY, LAG(v.refill_date) OVER (PARTITION BY v.patient_id ORDER BY v.refill_date), v.refill_date) AS gap_days,
  CASE 
    WHEN DATEDIFF(DAY, LAG(v.refill_date) OVER (PARTITION BY v.patient_id ORDER BY v.refill_date), v.refill_date) > v.days_supply + 5 
    THEN 'At Risk'
    ELSE 'Compliant'
  END AS refill_status
FROM visits v;
