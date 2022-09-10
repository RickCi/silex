from typing import Any, Collection, List, Union

import pyspark.sql.functions as F
from pyspark.sql import DataFrame


def has_unique_id(df: DataFrame, cols: Union[str, List[str]]) -> bool:
    return df.count() == df.select(cols).distinct().count()


def has_column(df: DataFrame, col: str) -> bool:
    return col in df.columns


def has_columns(df: DataFrame, cols: Union[str, List[str]]) -> bool:
    return all((col in df.columns for col in cols))


def has_distinct_values_in_set(
    df: DataFrame, cols: Union[str, List[str]], values: Collection[Any]
) -> bool:
    try:
        df.expect_distinct_values_in_set(cols=cols, values=values)
    except Exception:
        return False
    else:
        return True


def has_distinct_values_equal_set(
    df: DataFrame, cols: Union[str, List[str]], values: Collection[Any]
) -> bool:
    try:
        df.expect_distinct_values_equal_set(cols=cols, values=values)
    except Exception:
        return False
    else:
        return True


def has_min_value_between(
    df: DataFrame, cols: Union[str, List[str]], min_v: Any, max_v: Any
) -> bool:
    return _check_value_between(df=df, cols=cols, min_v=min_v, max_v=max_v, fn=F.min)


def has_avg_value_between(
    df: DataFrame, cols: Union[str, List[str]], min_v: Any, max_v: Any
) -> bool:
    return _check_value_between(df=df, cols=cols, min_v=min_v, max_v=max_v, fn=F.avg)


def has_max_value_between(
    df: DataFrame, cols: Union[str, List[str]], min_v: Any, max_v: Any
) -> bool:
    return _check_value_between(df=df, cols=cols, min_v=min_v, max_v=max_v, fn=F.max)


def _check_value_between(
    df: DataFrame,
    cols: Union[str, List[str]],
    min_v: Any,
    max_v: Any,
    fn,
):
    for col in cols:
        has = (
            df.select(fn(col).alias(col)).filter(min_v <= F.col(col) <= max_v)
            # .filter(F.col(col) >= min_v & F.col(col) <= max_v)
        )
        if not has:
            return False
    return True
