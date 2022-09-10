from typing import List

import pyspark.sql.functions as F
from pyspark.sql import DataFrame, Window


def join_closest_date(
    df: DataFrame,
    other: DataFrame,
    id_cols: List[str],
    date_col: str,
    other_date_col: str,
    date_diff_col: str = "date_diff",
    dense_rank_col: str = "dr",
    keep_date_diff: bool = False,
) -> DataFrame:
    window = Window.partitionBy(id_cols).orderBy(F.abs(date_diff_col))

    res = (
        df.join(other, id_cols)
        .withColumn(date_diff_col, F.datediff(date_col, other_date_col))
        .withColumn(dense_rank_col, F.dense_rank().over(window))
        .where(f"{dense_rank_col}=1")  # select closest date
        .drop(dense_rank_col)
    )
    if not keep_date_diff:
        return res.drop(date_diff_col)
    return res
