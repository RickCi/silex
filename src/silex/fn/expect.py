from typing import Any, Collection, List, Union

import pyspark.sql.functions as F
from pyspark.sql import DataFrame

from silex.exception import (
    SilexDuplicateIdsException,
    SilexMissingColumnException,
    SilexMissingColumnsException,
    SilexMissingValuesException,
    SilexUnexpectedValueException,
    SilexUnexpectedValuesException,
)


def expect_unique_id(df: DataFrame, cols: Union[str, List[str]]) -> DataFrame:
    if not df.has_unique_id(cols):  # type: ignore[operator]
        raise SilexDuplicateIdsException(cols)
    return df


def expect_column(df: DataFrame, col: str) -> DataFrame:
    if not df.has_column(col):  # type: ignore[operator]
        raise SilexMissingColumnException(col)
    return df


def expect_columns(df: DataFrame, cols: Union[str, List[str]]) -> DataFrame:
    missing_cols = set()
    if isinstance(cols, str):
        cols = [cols]
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
    if isinstance(cols, str):
        cols = [cols]
    assertions = [
        F.assert_true(F.col(col).isin(list(set(values))), errMsg=err_msg)
        for col in cols
    ]
    try:
        df.select(*assertions).collect()
    except Exception as e:
        raise SilexUnexpectedValuesException(cols=cols) from e
    else:
        return df


def expect_distinct_values_equal_set(
    df: DataFrame, cols: Union[str, List[str]], values: Collection[Any]
) -> DataFrame:
    if isinstance(cols, str):
        cols = [cols]
    distinct_v = set()
    for col in cols:
        distinct_v.update([row[col] for row in df.select(col).distinct().collect()])
        if not distinct_v.issubset(values):
            raise SilexUnexpectedValuesException(col)

    if distinct_v != set(values):
        raise SilexMissingValuesException(found=distinct_v, expected=values)
    return df


def expect_min_value_between(
    df: DataFrame, cols: Union[str, List[str]], min: Any, max: Any
) -> DataFrame:
    if not df.has_min_value_between(cols=cols, min=min, max=max):  # type: ignore[operator]
        raise SilexUnexpectedValueException()
    return df


def expect_avg_value_between(
    df: DataFrame, cols: Union[str, List[str]], min: Any, max: Any
) -> DataFrame:
    if not df.has_avg_value_between(cols=cols, min=min, max=max):  # type: ignore[operator]
        raise SilexUnexpectedValueException()
    return df


def expect_max_value_between(
    df: DataFrame, cols: Union[str, List[str]], min: Any, max: Any
) -> DataFrame:
    if not df.has_max_value_between(cols=cols, min=min, max=max):  # type: ignore[operator]
        raise SilexUnexpectedValueException()
    return df
