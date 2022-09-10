from typing import Any, Collection, List, Union

import pyspark.sql.functions as F
from pyspark.sql import DataFrame

from silex.exception import (
    SilexDuplicateIdsException,
    SilexMissingColumnException,
    SilexMissingColumnsException,
    SilexMissingValuesException,
    SilexUnexpectedValuesException,
)


def expect_unique_id(df: DataFrame, cols: Union[str, List[str]]) -> DataFrame:
    if df.count() != df.select(cols).distinct().count():
        raise SilexDuplicateIdsException(cols)
    return df


def expect_column(df: DataFrame, col: str) -> DataFrame:
    if col not in df.columns:
        raise SilexMissingColumnException(col)
    return df


def expect_columns(df: DataFrame, cols: Union[str, List[str]]) -> DataFrame:
    missing_cols = set()
    for col in cols:
        if col not in df.columns:
            missing_cols.add(col)
    if len(missing_cols) > 0:
        raise SilexMissingColumnsException(missing_cols)
    return df


def expect_distinct_values_in_set(
    df: DataFrame,
    cols: Union[str, List[str]],
    values: Collection[Any],
    err_msg: str = "value outside of set",
) -> DataFrame:
    assertions = [
        F.assert_true(F.col(col).isin(list(set(values))), errMsg=err_msg)
        for col in cols
    ]
    df.select(*assertions).count()
    return df


def expect_distinct_values_equal_set(
    df: DataFrame, cols: Union[str, List[str]], values: Collection[Any]
) -> DataFrame:
    distinct_v = set()
    for col in cols:
        distinct_v.update([row[col] for row in df.select(col).distinct().collect()])
        if not distinct_v.issubset(values):
            raise SilexUnexpectedValuesException(col)

    if distinct_v != set(values):
        raise SilexMissingValuesException(found=distinct_v, expected=values)
    return df


def expect_min_value_between(
    df: DataFrame, cols: Union[str, List[str]], min_v: Any, max_v: Any
) -> DataFrame:
    ...


def expect_avg_value_between(
    df: DataFrame, cols: Union[str, List[str]], min_v: Any, max_v: Any
) -> DataFrame:
    ...


def expect_max_value_between(
    df: DataFrame, cols: Union[str, List[str]], min_v: Any, max_v: Any
) -> DataFrame:
    ...
