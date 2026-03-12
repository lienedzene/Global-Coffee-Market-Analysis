# Global Coffee Market Analysis
This project provides an analysis of global coffee production and consumption from 1990 to 2019, showcasing a full data lifecycle workflow. It covers everything from data acquisition and cleaning in Excel to querying in MySQL and final interactive dashboarding in Tableau Public.

## Background
The idea of this project was born naturally from my interest to learn digital tools for data analytics in combination of my history in the coffee industry.

I sourced the data on [Kaggle](https://www.kaggle.com/datasets/michals22/coffee-dataset). It contains information about global producion, export and consumption of coffee.

### The Questions I wanted to answer:

1. Which 10 countries have had the largest production growth between 1990 and 2019?
2. What share of global production did the largest producer hold in 2019?
3. Which importing countries showed the highest re-export volumes relative to their total imports from 1990 to 2019?
4. What percentage of the produced coffee is exported from coffee producing countries in 2019?
5. How many months of demand could each country's green coffee inventory cover in 2019?

## Tools I used
For my first self-directed project, I practiced the following tools:

- **Microsoft Excel:** I used Power Query in Excel to unpivot and clean the data I sourced. I also created Pivot Tables and charts to see if there are any outliers. In the end, I created clean csv files for querying.
- **MySQL Workbench:** I imported the clean data and ran queries to answer my questions.
- **Tableau Public:** I created an interactive dashboard for visual storytelling.
- **Visual Studio Code:** For creating my portfolio.
- **GitHub:** For sharing all the details of my project.

## Data Cleaning & Transformation
The raw data consisted of 7 separate CSV files containing global coffee metrics from 1990 to 2019. I performed the following steps to ensure that data was ready for analysis.

### Standardizing and Reshaping (Power Query)

- **Unpivoting Years:** The original files were in a wide format with years as headers. I unpivoted these into a long format (Country, Year, Amount) to make the data easier to filter and more compatible with SQL and Tableau.
- **Unit Conversion:** All measurements were converted from kilograms to metric tons to handle large-scale global volumes more effectively.

### Relational Mapping (Excel)

- **Region Assignment:** Since the data only provided country names, I created a custom mapping table to assign each country to a region (e.g., South America, European Union). This improves geographic storytelling in my dashboard.

### Database Loading (MySQL)
- **Schema Design & Optimization:** I imported the cleaned CSV files into MySQL Workbench and refined the schema.
- **Data Type correction:** Converted columns from TEXT to VARCHAR(100) to resolve MySQL Error 1170, allowing the columns to be used in key specifications.
- **Composite Primary Keys:** Implemented a Composite Primary Key across all tables. This enforced data uniqueness and ensured that joins across the 30 year dataset remained accurate.
- **Data Validation:** I wrote SQL scripts to verify that the total production volume matched the original source files after the import, ensuring that there was no data loss.

## Analysis and Insights

### 1. Which 10 countries have had the largest production growth between 1990 and 2019?

| Country   | Amount MT 1990 | Amount MT 2019  | Absolute Increase MT | Growth Percentage | 
|:----------|---------------:|----------------:|---------------------:|------------------:| 
| Viet Nam  | 78,600         | 1,829,220       | 1,750,620            | 2,227.25%         | 
| Nicaragua | 27,660	     | 172,920	       | 145,260              | 525.16%           | 
| Peru      | 56,220         | 230,160	       | 173,940              | 309.39%           | 
| Guinea    | 2,640	         | 10,680	       | 8,040                | 304.55%           | 
| Honduras  | 94,080         | 355,860	       | 261,780              | 278.25%           |

> See the full SQL query [here](./sql_queries/01_production_increase.sql).

- **The Rapid Growth of Viet Nam:** In my analysis of the top 10 growth leaders, Viet Nam stands out as the most significant outlier in the dataset, with an impressive **2,227%** growth. This data reflects the impact of the Doi-Moi economic reforms that led to a rapid agricultural industrialization.
- **The "Data Anomaly" lesson:** The massive spike demonstrates why data analysts must look beyond the spreadsheet. Without the context of Viet Nam's economic revolution, a growth rate this high might be mistaken for a data entry error.


### 2. What share of global production did the largest producer hold in 2019?

| Country | Amount MT   | Total Global Production MT | Market Share Percentage |
|:--------|------------:|---------------------------:|------------------------:|
| Brazil  | 3,492,660   | 9,903,180                  | 35.27%                  |

> See the full SQL query [here](./sql_queries/02_global_production_percentage.sql).

- **Assessing Global Dominance:** My analysis shows that a single country, Brazil, accounts for over **35%** of the world's total coffee production. This highlights a high level of market dependency. Any environmental or economic shift in Brazil has a disproportionate impact on global coffee prices.
- **Engineering for Scale:** Handling Brazil's multi-million tonne production volume required a specific architectural choice. To prevent integer overflow during global aggregation, I utilized BIGINT data types in the SQL schema, ensuring the system could accurately process the massive scale of world's leading producers.


### 3. Which importing countries showed the highest re-export volumes relative to their total imports from 1990 to 2019?

| Country            | Total Imports MT | Total Re-exports MT | Re-export Percentage |
|:-------------------|-----------------:|--------------------:|---------------------:|
| Belgium            | 6,240,540        | 4,779,780           | 76.59%               |
| Belgium/Luxembourg | 1,257,900        | 742,860             | 59.06%               |
| Germany            | 31,481,400       | 14,558,880          | 46.25%               |
| Switzerland        | 3,212,700        | 1,485,780           | 46.25%               |
| Slovakia           | 821,760          | 373,020             | 45.39%               |

> See the full SQL query [here](./sql_queries/03_re-export_percentage.sql)

- **Identifying Industrial Hubs:** The data reveals that Belgium and Germany act as the primary engines of the European coffee trade. While Belgium re-exports a staggering **76.6%** of its imports, Germany's scale stands out with **14.5 million** metric tonnes processed and reexported over the 30-year period - a volume that reflects a massive industrial roasting and packaging infrastructure.
- **The Reality of Imperfect Data:** This analysis highlights how historical impact reflects in modern data storage. For example, the transition from "Belgium/Luxembourg" to individual reporting in 1999 creates "0" values that are **historical artifacts** rather than errors. In these cases, looking at percentages provides a more accurate understanding of a country's industrial role than volumes alone.


### 4. What percentage of the produced coffee is exported from coffee producing countries in 2019?

| Country      | Total Production MT | Total Export MT | Percent Exported |
|:-------------|--------------------:|----------------:|-----------------:|
| Zambia       | 900                 | 1,620           | 180.00%          |
| Togo         | 2,460               | 3,480           | 141.46%          |
| India        | 299,280             | 361,680         | 120.85%          |
| Sierra Leone | 2,400               | 2,820           | 117.50%          |
| Tanzania     | 55,560              | 64,140          | 115.44%          |

> See the full SQL query [here](./sql_queries/04_export_reliance.sql)

- **Analyzing Export Dependency:** The most export-reliant countries are predominantly located in Africa and Asia. For smaller producers, like Zambia and Togo, coffee is a vital source of income. India stands out as the only major producer on this list. It's high export ratio is likely driven by its "Tea-first" culture, and the low domestic coffee demand allows the country to utilize its climate conditions to grow coffee for international commerce.

- **The "Carry-over" Strategy in a Low-Price Market:** An export percentage of over **100%** reflects a strategic response to the **2019 Coffee Price Crisis**. With global coffee prices hitting 13-year lows due to the massive Brazilian surplus, these nations likely exported their "carry-over stock" to maintain their export revenues. This demonstrates how local production is often secondary to global price fluctuations when a country is export-dependent.


### 5. How many months of demand could each country's green coffee inventory cover in 2019?

| Country                  | 2019 Inventory MT | 2019 Consumption MT | 2019 Re-export MT | Months Covered |
|:-------------------------|------------------:|--------------------:|------------------:|---------------:|
| Japan                    | 176,040           | 453,060             | 9,480             | 4.6            |
| United States of America | 410,100           | 1,638,600           | 170,520           | 2.7            |
| Germany                  | 208,740           | 520,200             | 828,060           | 1.9            |
| Norway                   | 7,440             | 46,260              | 900               | 1.9            |
| Netherlands              | 42,420            | 121,800             | 199,440           | 1.6            |

> See the full SQL query [here](./sql_queries/05_inventory_cover.sql)

- **Supply Chain Security & Resilience:** This analysis calculates the "safety net" each country maintains against unpredicted changes in production. Japan stands out with the highest demand coverage margin, holding enough stock for **4.6** months. This shows an inventory strategy designed to prevent shortage risk caused by potential harvest failures in producing regions.

- **The "Efficiency vs. Risk" Trade-off:** In contrast, European countries operate on much smaller margins - all of them under 2 months. For these nations, high re-export volumes and a focus on high-quality "fresh crop" specialty coffee encourage a high inventory turnover instead of long-term stockpiling. This approach prioritizes logistical efficiency over long-term security.

## Data Visualization: The Global Coffee Market

[![Dashboard](/images/GlobalCoffeMarket.png)](https://public.tableau.com/app/profile/liene.dzene/viz/CoffeeSupplyChainAnalysis/GlobalCoffeMarketAnalysis)


To offer a better view of my SQL analysis, I built a dashboard in Tableau to visualize the scale of largest producing countries and industrial hubs in the coffee market.

- **The "Coffee Belt" Visualization:** The production map vividly displays the "Coffee Belt" - the equatorial zone with the specific climate conditions required for coffee cultivation. This visual shows why production is geographically concentrated while consumption is global.

- **The "Bean to Cup" Complexity:** The dashboard highlights the massive scale of re-exports in importing nations. This reveals that most coffee undergoes industrial processing in a second country before reaching the consumer. This multi-stage journey explains the high cost of the final product, reflecting the many participants in the global supply chain.

- **Discovery through Interactivity:** To maintain a clean and professional look, the dashboard utilizes a "minimalist-first" design. Extensive data layers are stored within tooltips, allowing users to discover deeper insights by hovering over elements without cluttering the primary visual interface.

## Technical Challenges & Lessons Learned

These are the key obstacles I encountered and the solutions I developed to overcome them:

### Data Engineering & SQL Logic

-**The "Brazil" Integer Overflow:** During the aggregation of global production data, I encountered an integer overflow error. Brazil's massive output exceeded the capacity of a standard 32-bit integer. I refactored the database schema to use BIGINT, ensuring the system could accurately process and store multi-billion unit calculations.

-**Power Query Transformation:** The raw dataset required "unpivoting" in the Power Query Editor to transition from a wide format (years as columns) to a long format (years as single dimensions). This was essential for creating my SQL queries.

-**Regional Classification:** I initially created a custom mapping to assign global regions to every country. However, as the analysis progressed, I realized that the data tells a better story and it provides more precise business insights if each country is displayed individually.

### The Analytical Mindset

-**Defending "Abnormal" Data:** When I saw Viet Nam's **2,227%** growth, my first instinct was to assume a data entry error. Instead of "cleaning" it out, I did some research on the historical context (Doi-Moi reforms). This taught me that, as an analyst, you must verify with context before you assume that a data anomaly is a mistake.

-**Handling Historical Artifacts:** The Belgian data split in 1999 created "0" values in the timeline. I worked around it by shifting from volume-based totals to **ratio-based analysis**, maintaining a consistent narrative of Belgium's role as an industrial hub despite changes in geopolitical reporting. This taught me that ratio-based analysis gives you a better and more precise insight on the data since there were also "0" values for Post-Soviet countries before the restoration of their independence.

### Tableau: Overcoming Visualization Limits

-**Dual-Labeling Bar Charts:** Tableau does not allow labels both "Inside" and "On Top" of a single bar easily. I solved this by using a **Dual-Axis chart** - layering two identical charts on top of each other - to display the specific values while maintaining a clean look.

-**Customizing Color Steps to Mitigate Outliers:** Brazil's production is so massive that it skewed the initial color gradients, causing all other producing nations to appear in a single, uniform color. To fix this as much as I can, I utilized **stepped color palettes** and chose the largest allowed amount of color steps. This ensured that smaller-scale producers were still somewhat distinguishable from one another, providing the clearest possible picture of the global market distribution.