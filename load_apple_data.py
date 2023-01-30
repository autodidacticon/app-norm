import sys

from pyspark.sql import SparkSession
import pandas as pd
import pyspark.pandas as ps

if __name__ == "__main__":
    """
        Usage: load_apple_data /path/to/single_json_file
    """

    spark = SparkSession \
        .builder \
        .appName("load_apple_data") \
        .enableHiveSupport() \
        .getOrCreate()

    json_path = sys.argv[1]

    # this will drop the first and last rows because the objects are stored in a json list
    # attempted to load the data into pandas-spark but ran into memory issues
    spark.read.json(json_path, mode='DROPMALFORMED').write.mode("overwrite").saveAsTable("app_store_raw")
    spark.stop()