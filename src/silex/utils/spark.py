from pyspark.sql import SparkSession


def get_spark_session() -> SparkSession:
    """Get or create a SparkSession.

    >>> assert(isinstance(get_spark_session(), SparkSession))
    """
    return SparkSession.builder.getOrCreate()
