/* PROJECT: Global Coffee Market Analysis
| QUESTION:
| What percentage of the produced coffee is exported from coffee producing countries in 2019?
| GOAL:
| To analyze the scale of global coffee production and identify which countries are most
| dependent on international trade.
*/

/* Note: All volume metrics are expressed in Metric Tonnes (1,000 kg).
| Conversion performed during the cleaning phase.
*/

-- SQL Query Logic:
SELECT
p.Country,
(SUM(p.Amount)) AS total_production,
(SUM(e.Amount)) AS total_export,
ROUND((SUM(e.Amount) / SUM(p.Amount)) * 100,2) AS percent_exported
FROM production p 
JOIN
export e ON p.Country = e.Country AND p.Year = e.Year
WHERE e.Year = 2019
GROUP BY
p.Country 
ORDER BY
percent_exported DESC;

-- Results preview:
/*
| Country      | total_production | total_export | percent_exported |
|:-------------|:-----------------|:-------------|:-----------------|
| Zambia       | 900              | 1620         | 180.00           |
| Togo         | 2460             | 3480         | 141.46           |
| India        | 299280           | 361680       | 120.85           |
| Sierra Leone | 2400             | 2820         | 117.50           |
| Tanzania     | 55560            | 64140        | 115.44           |
*/
