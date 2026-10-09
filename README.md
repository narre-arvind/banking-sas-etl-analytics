
# Banking Customer ETL & Analytics Using SAS

## Project Objective
To build a SAS-based ETL pipeline to clean, transform, validate, and analyze banking customer data for business reporting.

## Dataset
- **Source:** [UCI Bank Marketing Dataset](https://archive.ics.uci.edu/dataset/222/bank+marketing)
- **Records:** 45,211
- **Target Variable:** `y` — term-deposit subscription (`yes`/`no`).

## Tools & Technologies
- SAS
- SQL (PROC SQL)
- Data Quality Checks
- SAS Data Visualization

## Project Workflow
1. **Data Import:** Imported the raw CSV dataset into SAS.
2. **Data Cleaning:** Checked missing values and duplicate records.
3. **Data Transformation:** Created derived variables and encoded the target variable.
4. **Data Analysis:** Used PROC SQL, PROC MEANS, and PROC FREQ to analyze customer data.
5. **Data Quality:** Validated record counts, numeric values, and target encoding.
6. **Visualization:** Generated charts for business reporting.

## Key Outcomes
- Processed 45,211 customer records.
- Created derived features for customer segmentation.
- Performed data quality validation.
- Analyzed term-deposit subscription patterns.

## SAS Programs
| File | Description |
|---|---|
| `01_import.sas` | Imports the raw dataset |
| `02_cleaning.sas` | Cleans the data |
| `03_etl.sas` | Creates derived variables |
| `04_analysis.sas` | Performs analysis and visualization |
| `05_quality_checks.sas` | Validates data quality |

## How to Run
1. Download `bank-full.csv` from the UCI dataset source.
2. Upload it to your SAS environment.
3. Update the file path in `01_import.sas` if required.
4. Run the five SAS programs in numerical order.

## Business Value
Demonstrates ETL development, data validation, customer segmentation, and analytical reporting skills relevant to banking and business intelligence.
