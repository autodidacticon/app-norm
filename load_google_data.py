import sys

from pyspark.sql import SparkSession

if __name__ == "__main__":
    """
        Usage: load_google_data /path/to/csvs/* (may include wildcards)
    """

    spark = SparkSession \
        .builder \
        .appName("load_google_data") \
        .enableHiveSupport() \
        .getOrCreate()

    csv_path = sys.argv[1]

    spark.read.csv(csv_path, header=True).write.mode("overwrite").saveAsTable("play_store_raw")
    spark.stop()