### mobile app data analysis

#### prerequisites
* Python 3

#### setup
1. `brew tap dbt-labs/dbt && brew install dbt-postgres`
1. `pip3 install pyspark\[pandas_on_spark\] pyArrow dbt-spark\[session\] jupyter`

#### load google source data
1. clone google dataset: `git clone https://github.com/gauthamp10/Google-Playstore-Dataset.git`
1. navigate to archive directory: `cd Google-Playstore-Dataset/dataset`
1. extract archives: `ls *.gz | xargs -I{} tar -xzf {}`, Note: spark should be able to read gz files but the header information seemed mangled
1. execute spark job (from the root directory of this project) to load data into local warehouse: `spark-submit load_google_data.py /absolute/path/to/Google-Playstore-Dataset/dataset/\*csv`

#### load apple source data
1. clone google dataset: `git clone https://github.com/gauthamp10/apple-appstore-apps.git`
1. navigate to archive directory: `cd apple-appstore-apps/dataset`
1. extract archive: `tar --lzma -xvf appleAppData.json.tar.lzma`
1. execute spark job (from the root directory of this project) to load data into local warehouse: `spark-submit load_apple_data.py /absolute/path/to/apple-appstore-apps/dataset/\*.json`

#### execute dbt
From the project root:
1. dbt run
1. dbt test

#### query datasets
```python
>>> spark.sql("show tables").show(10, False)
+---------+-----------------------------------------+-----------+
|namespace|tableName                                |isTemporary|
+---------+-----------------------------------------+-----------+
|default  |app_data_norm                            |false      |
|default  |app_store_data_norm                      |false      |
|default  |app_store_raw                            |false      |
|default  |application_size_distribution_by_category|false      |
|default  |avg_rating_by_category                   |false      |
|default  |new_releases_by_month_and_category       |false      |
|default  |play_store_data_norm                     |false      |
|default  |play_store_raw                           |false      |
|default  |top_10_largest_apps_by_category          |false      |
+---------+-----------------------------------------+-----------+
```

#### visualization
1. start a jupyter server: `jupyter notebook`
1. open: `viz.ipynb`



