from typing import Any, Collection, List, Union

from pyspark.sql import DataFrame


def expect_unique_id(df: DataFrame, cols: Union[str, List[str]]) -> DataFrame:
    ...


def expect_column(df: DataFrame, col: str) -> bool:
    ...


def expect_columns(df: DataFrame, cols: Union[str, List[str]]) -> bool:
    ...


def expect_distinct_values_in_set(
    df: DataFrame, cols: Union[str, List[str]], values: Collection[Any]
) -> bool:
    ...


def expect_distinct_values_equal_set(
    df: DataFrame, cols: Union[str, List[str]], values: Collection[Any]
) -> bool:
    ...


def expect_min_value_between(
    df: DataFrame, cols: Union[str, List[str]], min_v: Any, max_v: Any
) -> bool:
    ...


def expect_avg_value_between(
    df: DataFrame, cols: Union[str, List[str]], min_v: Any, max_v: Any
) -> bool:
    ...


def expect_max_value_between(
    df: DataFrame, cols: Union[str, List[str]], min_v: Any, max_v: Any
) -> bool:
    ...
