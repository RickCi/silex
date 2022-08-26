import pyspark.sql.functions as F
from pyspark.sql import DataFrame


def drop_col_if_na(df: DataFrame, max: int = 0) -> DataFrame:
    """Returns a new DataFrame with columns dropped if NA values were found.

    Args:
        df: DataFrame
        max: threshold of allowed NA values within one column

    Returns: new DataFrame with columns dropped
    """
    col_counts = [F.count(F.when(F.col(c).isNull(), c)).alias(c) for c in df.columns]
    null_counts = df.select(col_counts).collect()[0].asDict()
    to_drop = [column for column, null_cnt in null_counts.items() if null_cnt > max]
    return df.drop(*to_drop)
