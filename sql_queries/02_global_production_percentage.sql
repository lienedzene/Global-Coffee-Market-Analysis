/* PROJECT: Global Coffee Market Analysis
QUESTION:
Assessing Global dominance: What share of global production did the largest
producer hold in 2019?
GOAL:
To see how much of the global coffee supply comes from just the largest
producing country.
*/

/* Note: All volume metrics are expressed in Metric Tonnes (1,000 kg).
| Conversion performed during the cleaning phase.
*/

-- SQL Query Logic:
SELECT 
Country,
Amount,
(SELECT SUM(amount) FROM production WHERE Year = 2019) AS total_global_production,
ROUND ((Amount / (SELECT SUM(Amount) FROM production WHERE Year = 2019)) * 100,2) AS market_share_percentage 
FROM production
WHERE Year = 2019
ORDER BY Amount DESC
LIMIT 1;

-- Results preview:
/*
| Country | Amount  | total_global_production | market_share_percentage |
|:--------|--------:|------------------------:|------------------------:|
| Brazil  | 3492660 | 9903180	              | 35.27                   |
*/