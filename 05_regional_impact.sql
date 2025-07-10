
-- Regional Revenue Loss Breakdown

SELECT 
  p.region,
  ROUND(SUM(c.claim_amount), 2) AS regional_loss
FROM claims c
JOIN patients p ON c.patient_id = p.patient_id
JOIN (
  SELECT patient_id
  FROM visits
  GROUP BY patient_id
  HAVING SUM(days_supply) * 1.0 / (DATEDIFF(DAY, MIN(refill_date), MAX(refill_date)) + 1) < 0.8
) r ON r.patient_id = c.patient_id
GROUP BY p.region
ORDER BY regional_loss DESC;
