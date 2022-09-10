from typing import Optional

import pyspark.sql.functions as F
from pyspark.sql import DataFrame
from pyspark.sql.types import DateType, TimestampType


def with_date_column(
    df: DataFrame, col: str, fmt: str, new_col: Optional[str] = None
) -> DataFrame:
    if new_col is None:
        new_col = col

    return df.withColumn(
        new_col,
        F.unix_timestamp(F.col(col), format=fmt).cast(TimestampType()).cast(DateType()),
    )
