# Databricks notebook source
# MAGIC %md
# MAGIC # **Bronze Layer – Raw Data Ingestion**
# MAGIC
# MAGIC This notebook performs the ingestion of raw datasets into the Bronze Layer of the data lakehouse.
# MAGIC
# MAGIC **Border Crossing Entry Data**
# MAGIC
# MAGIC **Source:** U.S. Department of Transportation
# MAGIC
# MAGIC **Path:** /Volumes/term_project/data/raw_data/Border_Crossing_Entry_Data.csv
# MAGIC
# MAGIC **Freight Transportation Services Index (TSIFRGHT)**
# MAGIC
# MAGIC **Source:** FRED (Federal Reserve Economic Data)
# MAGIC
# MAGIC **Path:** /Volumes/term_project/data/raw_data/TSIFRGHT.csv
# MAGIC
# MAGIC **Actions Performed:**
# MAGIC Read both CSV files from the specified raw data location.
# MAGIC
# MAGIC Add ingestion metadata:
# MAGIC
# MAGIC ingestion_timestamp
# MAGIC
# MAGIC source_file
# MAGIC
# MAGIC Save as Delta tables in `term_project.bronze`

# COMMAND ----------

# DBTITLE 1,Create Schemas
# Create schemas inside the term_project catalog
catalog = "term_project"
schemas = ["bronze", "silver", "gold"]

for schema in schemas:
    spark.sql(f"CREATE SCHEMA IF NOT EXISTS {catalog}.{schema}")
    print(f"✅ Schema created or already exists: {catalog}.{schema}")


# COMMAND ----------

# DBTITLE 1,Clean Column Names Function
# Helper: Clean column names for Delta Lake compatibility
def clean_column_names(df):
    for col_name in df.columns:
        cleaned = (
            col_name.strip()
            .lower()
            .replace(" ", "_")
            .replace("(", "")
            .replace(")", "")
            .replace(",", "")
            .replace("=", "")
            .replace("\n", "")
            .replace("\t", "")
        )
        df = df.withColumnRenamed(col_name, cleaned)
    return df


# COMMAND ----------

# DBTITLE 1,Ingest Border Crossing Entry Data
from pyspark.sql.functions import current_timestamp, col

# Path
border_path = "/Volumes/term_project/data/raw_data/Border_Crossing_Entry_Data.csv"

# Read with metadata
df_border_raw = (
    spark.read
    .option("header", True)
    .option("includeMetadata", True)
    .csv(border_path)
    .withColumn("ingestion_timestamp", current_timestamp())
    .withColumn("source_file", col("_metadata.file_path"))
)

# Clean column names
df_border_cleaned = clean_column_names(df_border_raw)

# Save as Delta
df_border_cleaned.write.mode("overwrite").format("delta").saveAsTable("term_project.bronze.border_entry_raw")

display(df_border_cleaned.limit(5))


# COMMAND ----------

# DBTITLE 1,Ingest Freight Pricing Index
freight_path = "/Volumes/term_project/data/raw_data/TSIFRGHT.csv"

df_freight_raw = (
    spark.read
    .option("header", True)
    .option("includeMetadata", True)
    .csv(freight_path)
    .withColumn("ingestion_timestamp", current_timestamp())
    .withColumn("source_file", col("_metadata.file_path"))
)

df_freight_cleaned = clean_column_names(df_freight_raw)

df_freight_cleaned.write.mode("overwrite").format("delta").saveAsTable("term_project.bronze.freight_index_raw")

display(df_freight_cleaned.limit(5))
