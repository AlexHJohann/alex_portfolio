# Databricks notebook source
# MAGIC %md
# MAGIC %md
# MAGIC # **Silver Layer – Cleaned and Enriched Data**
# MAGIC
# MAGIC This notebook processes the raw Delta tables from the Bronze Layer and prepares cleaned, normalized data for analysis.
# MAGIC
# MAGIC **Border Crossing Entry Data**
# MAGIC
# MAGIC **Source Table:** `term_project.bronze.border_entry_raw`
# MAGIC
# MAGIC **Actions Performed:**
# MAGIC - Normalize port names and casing
# MAGIC - Extract and format date fields (Year, Month, Quarter)
# MAGIC - Handle missing values in key columns
# MAGIC - Rename `value` to `traffic_volume`
# MAGIC - Save cleaned data as `term_project.silver.border_cleaned`
# MAGIC
# MAGIC **Freight Transportation Services Index (TSIFRGHT)**
# MAGIC
# MAGIC **Source Table:** `term_project.bronze.freight_index_raw`
# MAGIC
# MAGIC **Actions Performed:**
# MAGIC - Extract date parts (Year, Month, Quarter)
# MAGIC - Rename `tsifrght` to `freight_index`
# MAGIC - Remove rows with missing freight values
# MAGIC - Save cleaned data as `term_project.silver.freight_cleaned`
# MAGIC
# MAGIC **Final Join Table**
# MAGIC
# MAGIC **Table:** `term_project.silver.joined_traffic_pricing`
# MAGIC
# MAGIC **Actions Performed:**
# MAGIC - Join the cleaned border and freight datasets on `year` and `month`
# MAGIC - Save the enriched joined data for Gold Layer aggregations
# MAGIC
# MAGIC

# COMMAND ----------

# DBTITLE 1,Create Schemas
# Create schemas inside the term_project catalog
catalog = "term_project"
schemas = ["bronze", "silver", "gold"]

for schema in schemas:
    spark.sql(f"CREATE SCHEMA IF NOT EXISTS {catalog}.{schema}")
    print(f"✅ Schema created or already exists: {catalog}.{schema}")


# COMMAND ----------

# DBTITLE 1,Load Bronze Tables
df_border = spark.table("term_project.bronze.border_entry_raw")
df_freight = spark.table("term_project.bronze.freight_index_raw")


# COMMAND ----------

# DBTITLE 1,Clean and Save Border Crossing Data
from pyspark.sql.functions import to_date, year, month, quarter, col, upper

df_border_cleaned = (
    df_border
    .withColumnRenamed("value", "traffic_volume")
    .withColumnRenamed("port_name", "port")
    .withColumn("date", to_date(col("date"), "MMM yyyy"))
    .filter(col("date").isNotNull())
    .withColumn("year", year("date"))
    .withColumn("month", month("date"))
    .withColumn("quarter", quarter("date"))
    .withColumn("port", upper(col("port")))
    .dropna(subset=["port", "traffic_volume"])
)

df_border_cleaned.write.mode("overwrite").format("delta").saveAsTable("term_project.silver.border_cleaned")
display(df_border_cleaned.limit(5))




# COMMAND ----------

# DBTITLE 1,Clean and Save Freight Data
from pyspark.sql.functions import to_date, year, month, quarter, col

df_freight_cleaned = (
    df_freight
    .withColumnRenamed("tsifrght", "freight_index")
    .withColumn("freight_date", to_date(col("observation_date"), "yyyy-MM-dd"))
    .filter(col("freight_date").isNotNull())
    .withColumn("year", year("freight_date"))
    .withColumn("month", month("freight_date"))
    .withColumn("quarter", quarter("freight_date"))
    .dropna(subset=["freight_index"])
)

df_freight_cleaned.write.mode("overwrite").format("delta").saveAsTable("term_project.silver.freight_cleaned")
display(df_freight_cleaned.limit(5))


# COMMAND ----------

# DBTITLE 1,Join Cell
from pyspark.sql.functions import col

# Join Cleaned Data and cast freight_index
df_joined = (
    df_border_cleaned.alias("b")
    .join(
        df_freight_cleaned.select("freight_index", "year", "month").alias("f"),
        on=["year", "month"],
        how="left"
    )
    .withColumn("freight_index", col("freight_index").cast("double"))
)

# Save Joined Silver Table
df_joined.write.mode("overwrite").format("delta").saveAsTable("term_project.silver.joined_traffic_pricing")
