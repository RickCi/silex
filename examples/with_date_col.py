from pyspark.sql import DataFrame, SparkSession

import silex

silex.extend_dataframes()

spark = SparkSession.builder.getOrCreate()

data = [
    (0, "01/29/2022", "a", 1.0),
    (1, "01/30/2022", "b", 2.0),
    (2, "01/31/2022", "c", 3.0),
]
df: DataFrame = spark.createDataFrame(data, schema=["id", "date_US", "text", "value"])
df.show()
# +---+----------+----+-----+
# | id|   date_US|text|value|
# +---+----------+----+-----+
# |  0|01/29/2022|   a|  1.0|
# |  1|01/30/2022|   b|  2.0|
# |  2|01/31/2022|   c|  3.0|
# +---+----------+----+-----+

df = df.with_date_column(col="date_US", new_col="date", fmt="MM/dd/yyyy")
df.show()
df.printSchema()
# +---+----------+----+-----+----------+
# | id|   date_US|text|value|      date|
# +---+----------+----+-----+----------+
# |  0|01/29/2022|   a|  1.0|2022-01-29|
# |  1|01/30/2022|   b|  2.0|2022-01-30|
# |  2|01/31/2022|   c|  3.0|2022-01-31|
# +---+----------+----+-----+----------+
#
# root
#  |-- id: long (nullable = true)
#  |-- date_US: string (nullable = true)
#  |-- text: string (nullable = true)
#  |-- value: double (nullable = true)
#  |-- date: date (nullable = true)
