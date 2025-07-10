
-- Cost vs ROI Simulation for Intervention Strategy

WITH at_risk_revenue AS (
  SELECT patient_id, SUM(claim_amount) AS lost_revenue
  FROM claims
  WHERE patient_id IN (
    SELECT patient_id
    FROM visits
    GROUP BY patient_id
    HAVING SUM(days_supply) * 1.0 / (DATEDIFF(DAY, MIN(refill_date), MAX(refill_date)) + 1) < 0.8
  )
  GROUP BY patient_id
)

SELECT 
  COUNT(*) AS at_risk_count,
  SUM(lost_revenue) AS total_loss,
  ROUND(SUM(lost_revenue) * 0.10, 2) AS recovered_if_10_percent_adhere,
  COUNT(*) * 5 AS intervention_cost,
  ROUND((SUM(lost_revenue) * 0.10) - (COUNT(*) * 5), 2) AS net_roi
FROM at_risk_revenue;
