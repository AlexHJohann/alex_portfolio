# Databricks notebook source
# MAGIC %md
# MAGIC %md
# MAGIC # **Gold Layer – Business-Level Tables**
# MAGIC
# MAGIC This notebook creates final analytical tables for reporting and dashboards, based on cleaned Silver Layer data from NexPort Logistics.
# MAGIC
# MAGIC **Source Table:**
# MAGIC - `term_project.silver.joined_traffic_pricing`
# MAGIC
# MAGIC **Tables Created:**
# MAGIC - `monthly_traffic_by_port`
# MAGIC - `vehicle_type_summary`
# MAGIC - `peak_alert_log`
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

# DBTITLE 1,Load Silver Table
# Load Silver Layer joined table
df_silver = spark.read.table("term_project.silver.joined_traffic_pricing")



# COMMAND ----------

# MAGIC %md
# MAGIC %md
# MAGIC ### Gold Table: `monthly_traffic_by_port`
# MAGIC
# MAGIC Aggregates total traffic volume per port for each year and month.
# MAGIC
# MAGIC Useful for visualizing traffic trends over time by location.
# MAGIC

# COMMAND ----------

# DBTITLE 1,monthly_traffic_by_port
df_monthly_traffic = (
    df_silver
    .groupBy("port", "year", "month")
    .agg({"traffic_volume": "sum"})
    .withColumnRenamed("sum(traffic_volume)", "total_traffic")
    .orderBy("port", "year", "month")
)

# Save to Gold
df_monthly_traffic.write.mode("overwrite").format("delta").saveAsTable("term_project.gold.monthly_traffic_by_port")

display(df_monthly_traffic.limit(10))


# COMMAND ----------

# MAGIC %md
# MAGIC %md
# MAGIC ### Gold Table: `vehicle_type_summary`
# MAGIC
# MAGIC Summarizes total traffic by vehicle type and port.
# MAGIC
# MAGIC Enables analysis of the mix of traffic types (trucks, buses, etc.) at each crossing.
# MAGIC

# COMMAND ----------

# DBTITLE 1,vehicle_type_summary
df_vehicle_type = (
    df_silver
    .groupBy("port", "measure")
    .agg({"traffic_volume": "sum"})
    .withColumnRenamed("sum(traffic_volume)", "total_traffic")
    .orderBy("port", "measure")
)

# Save to Gold
df_vehicle_type.write.mode("overwrite").format("delta").saveAsTable("term_project.gold.vehicle_type_summary")

display(df_vehicle_type.limit(10))


# COMMAND ----------

# MAGIC %md
# MAGIC ### Gold Table: `peak_alert_log`
# MAGIC
# MAGIC Flags rows where traffic volume is in the top 10% for each port.
# MAGIC
# MAGIC Helps identify peak congestion days or months for alerts and planning.
# MAGIC

# COMMAND ----------

# DBTITLE 1,peak_alert_log
from pyspark.sql.window import Window
from pyspark.sql.functions import percentile_approx

# Get 90th percentile by port
df_thresholds = (
    df_silver
    .groupBy("port")
    .agg(percentile_approx("traffic_volume", 0.9).alias("threshold"))
)

# Join back to identify peak rows
df_peaks = (
    df_silver
    .join(df_thresholds, on="port")
    .filter(df_silver["traffic_volume"] >= df_thresholds["threshold"])
    .select("port", "date", "traffic_volume", "measure", "year", "month", "quarter")
    .orderBy("port", "date")
)

# Save to Gold
df_peaks.write.mode("overwrite").format("delta").saveAsTable("term_project.gold.peak_alert_log")

display(df_peaks.limit(10))


# COMMAND ----------

# MAGIC %md
# MAGIC ### Gold Table: `crossing_vs_pricing`
# MAGIC
# MAGIC Combines total border crossing traffic with the freight index for each month and year.
# MAGIC
# MAGIC Useful for identifying patterns between traffic volume and shipping costs.
# MAGIC

# COMMAND ----------

# DBTITLE 1,crossing_vs_pricing
from pyspark.sql.functions import col, concat_ws

# Load cleaned Silver tables with correct names
df_border_cleaned = spark.read.table("term_project.silver.border_cleaned")
df_freight_cleaned = spark.read.table("term_project.silver.freight_cleaned")

# Filter to freight-matching time range
df_border_cleaned = df_border_cleaned.filter(col("year") >= 2000)

# Join on year and month
df_silver = (
    df_border_cleaned.alias("b")
    .join(
        df_freight_cleaned.select("freight_index", "year", "month").alias("f"),
        on=["year", "month"],
        how="left"
    )
)

# Aggregate monthly traffic and average freight index
df_crossing_vs_pricing = (
    df_silver
    .withColumn("freight_index", col("freight_index").cast("double"))
    .groupBy("year", "month")
    .agg(
        {"traffic_volume": "sum", "freight_index": "avg"}
    )
    .withColumnRenamed("sum(traffic_volume)", "total_traffic")
    .withColumnRenamed("avg(freight_index)", "avg_freight_index")
    .withColumn("year_month", concat_ws("-", col("year"), col("month")))
    .orderBy("year", "month")
)

# Save Gold Table df_crossing_vs_pricing.write.mode("overwrite").format("delta").saveAsTable("term_project.gold.crossing_vs_pricing") .saveAsTable("term_project.gold.crossing_vs_pricing")

# Preview
display(df_crossing_vs_pricing.limit(10))
