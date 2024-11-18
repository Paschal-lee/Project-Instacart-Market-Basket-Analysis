# Instacart Market Basket Analysis
The Instacart Market Basket Analysis project aims to explore and analyze customer shopping behavior using transactional data from the Instacart platform. This dataset provides a rich source of information that can be used to derive valuable insights for optimizing operations and enhancing customer experiences.

# Dataset
https://drive.google.com/drive/folders/1jr_MmfjuV6WmABMm7tzE70bImhd64XkG?usp=drive_link

# Data Process and Instights

## Data Exploration
Objective: Understand the structure and content of the database tables.
Actions Taken:
Used DESCRIBE and SELECT queries to inspect tables like aisles, departments, orders, and others.
Ensured familiarity with columns such as product_id, order_id, and reordered, which are essential for further analysis.

## Data Cleaning and Transformation
Objective: Ensure data consistency and readiness for analysis.
Actions Taken:
Identify Empty Datasets:
Queried each table for missing values (e.g., WHERE column_name = '').
Replace Missing Values:
Updated days_since_prior_order to NULL for empty entries.
Rename Columns:
Renamed order_dow to order_day for clarity.
Format Data for Readability:
Converted numeric order_day values to day names (e.g., 0 -> Sunday).
Converted order_hour_of_day to a user-friendly 12-hour format.
Categorize Data:
Updated reordered values to meaningful labels (0 -> First order, 1 -> Multi order) for better interpretability.

## Data Analysis and Insights Generation
Objective: Derive actionable insights based on customer and product data.
Actions Taken:
Market Basket Analysis:
Identified product pairs frequently purchased together using a self-join on order_products__train.
Analyzed products most often added to the cart first to target initial customer interactions.
Explored the diversity of products in an average order by counting unique product IDs.
Customer Segmentation:
Grouped customers based on total spending, purchase frequency, and number of orders.
Segments help target marketing efforts and identify high value customers.
Product Association Rules:
Used combinations of products purchased together to uncover patterns for bundling or promotions.

## Query Optimization
Objective: Ensure efficient querying and accurate results.
Actions Taken:
Used joins (e.g., JOIN on order_id) to combine related datasets for deeper analysis.
Aggregated data with COUNT, GROUP BY, and ORDER BY to identify trends.

## Insight Documentation
Objective: Summarize findings into actionable steps.
Actions Taken:
Highlighted customer behaviors (e.g., frequent purchases, cart-first items).
Proposed operational and marketing strategies based on product associations and customer segments.
