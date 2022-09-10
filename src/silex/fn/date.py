import pyspark.sql.functions as F
from pyspark.sql import DataFrame
from pyspark.sql.types import DateType, TimestampType


def with_date_column(
    df: DataFrame, col: str, fmt: str = "yyyy-MM-dd HH:mm:ss"
) -> DataFrame:
    return df.withColumn(
        col,
        F.unix_timestamp(F.col(col), format=fmt).cast(TimestampType()).cast(DateType()),
    )
