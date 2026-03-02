# Global Coffee Market Analysis
This project provides an analysis of global coffee production and consumption from 1990 to 2019, showcasing a full data lifecycle workflow. It covers everything from data acquisition and cleaning in Excel to querying in MySQL and final interactive dashboarding in Tableau Public.

## Background
The idea of this project was born naturally from my interest to learn digital tools for data analytics in combination of my history in the coffee industry.

I sourced the data on [Kaggle](https://www.kaggle.com/datasets/michals22/coffee-dataset). It contains information about global producion, export and consumption of coffee.

### The Questions I wanted to answer:

1. Which 10 countries have had the largest production growth between 1990 and 2019?
2. Assessing Global dominance: What share of global production did the largest producer hold in 2019?
3. Which importing countries showed the highest re-export volumes relative to their total imports from 1990 to 2019?
4. What percentage of the produced coffee is exported from coffee producing countries in 2019?
5. How many months of demand could each country's green coffee inventory cover in 2019?

## Tools I used
For my first self-directed project, I practiced the following tools:

- **Microsoft Excel:** I used Power Query in Excel to unpivot and clean the data I sourced. I also created Pivot Tables and charts to see if there are any outliers. In the end, I created clean csv files for querying.
- **MySQL Workbench:** I imported the clean data and ran some queries to answer my questions.
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

- **The "Viet Nam Explosion":** Viet Nam is the most significant outlier in the dataset, with an impressive **2,227%** growth. This data reflects the impact of the Doi-Moi economic reforms that led to a rapid agricultural industrialization.
- **The "Data Anomaly" lesson:** The massive spike demonstrates why data analysts must look beyond the spreadsheet. Without the context of Viet Nam's economic revolution, a growth rate this high might be mistaken for a data entry error.

### 2. Assessing Global dominance: What share of global production did the largest producer hold in 2019?

| Country | Amount MT   | Total Global Production MT | Market Share Percentage |
|:--------|------------:|---------------------------:|------------------------:|
| Brazil  | 3,492,660   | 9,903,180                  | 35.27%                  |

> See the full SQL query [here](./sql_queries/02_global_production_percentage.sql).

- **Market Concentration:** My analysis shows that a single country, Brazil, accounts for over **35%** of the world's total coffee production. This highlights a high level of market dependency. Any environmental or economical shift in Brazil has a disproportionate impact on global coffee prices.
- **Engineering for Scale:** Handlind Brazil's multi-million tonne production volume required a specific architectural choice. To prevent integer overflow during global aggregation, I utilized BIGINT data types in the SQL schema, ensuring the system could accurately process the massive scale of world's leading producers.