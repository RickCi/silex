import pyspark.sql.functions as F
from pyspark.sql import DataFrame


def drop_col_if_na(df: DataFrame, max: int = 0) -> DataFrame:
    """Returns a new DataFrame with columns dropped if NA values were found.

    Args:
        df: DataFrame
        max: threshold of allowed NA values within one column, default: 0

    Returns: new DataFrame with columns dropped
    """
    col_counts = [F.count(F.when(F.col(c).isNull(), c)).alias(c) for c in df.columns]
    counts = df.select(col_counts).collect()[0].asDict()
    to_drop = [column for column, cnt in counts.items() if cnt > max]
    return df.drop(*to_drop)


def drop_col_if_not_distinct(df: DataFrame, min: int = 2) -> DataFrame:
    """Returns a new DataFrame with columns dropped if values are not distinct.

    Args:
        df: DataFrame
        min: threshold of distinct values within one column, default: 2

    Returns: new DataFrame with columns dropped
    """
    col_counts = [F.countDistinct(c).alias(c) for c in df.columns]
    counts = df.select(col_counts).collect()[0].asDict()
    to_drop = [column for column, cnt in counts.items() if cnt < min]
    return df.drop(*to_drop)
