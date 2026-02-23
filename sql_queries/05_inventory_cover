/* PROJECT: Global Coffee Market Analysis
| QUESTION:
| How many months of demand could each country's green coffee inventory cover in 2019?
| GOAL:
| To determine the supply chain security of importing nations by calculating the ratio
| of stock-on-hand to total monthly demand (consumption + re-exports).
*/

/* Note: All volume metrics are expressed in Metric Tonnes (1,000 kg).
| Conversion performed during the cleaning phase.
*/

-- SQL Query Logic:
SELECT
i.Country, 
i.Amount AS inventory,
c.Amount AS consumption,
r.Amount AS re_export,
ROUND(i.Amount / ((c.Amount + r.Amount)/12),1)
as months_of_cover
FROM
green_coffee_inventory i
JOIN
importers_consumption c ON i.Country=c.Country
AND i.Year=c.Year
JOIN
re_export r ON i.Country=r.Country
AND i.Year=r.Year
WHERE
i.Year=2019
AND (c.Amount+r.Amount)>0
ORDER BY
months_of_cover DESC;

-- Results preview:
/*
| Country                  | inventory | consumption | re_export | months_of_cover |
|:-------------------------|:----------|:------------|:----------|:----------------|
| Japan                    | 176040    | 453060      | 9480      | 4.6             |
| United States of America | 410100    | 1638600     | 170520    | 2.7             |
| Germany                  | 208740    | 520200      | 828060    | 1.9             |
| Norway                   | 7440      | 46260       | 900       | 1.9             |
| Netherlands              | 42420     | 121800      | 199440    | 1.6             |
*/