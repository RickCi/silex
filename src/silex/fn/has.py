from typing import Any, Collection, List, Union

from pyspark.sql import DataFrame


def has_unique_id(df: DataFrame, cols: Union[str, List[str]]) -> bool:
    ...


def has_column(df: DataFrame, col: str) -> bool:
    ...


def has_columns(df: DataFrame, cols: Union[str, List[str]]) -> bool:
    ...


def has_distinct_values_in_set(
    df: DataFrame, cols: Union[str, List[str]], values: Collection[Any]
) -> bool:
    ...


def has_distinct_values_equal_set(
    df: DataFrame, cols: Union[str, List[str]], values: Collection[Any]
) -> bool:
    ...


def has_min_value_between(
    df: DataFrame, cols: Union[str, List[str]], min_v: Any, max_v: Any
) -> bool:
    ...


def has_avg_value_between(
    df: DataFrame, cols: Union[str, List[str]], min_v: Any, max_v: Any
) -> bool:
    ...


def has_max_value_between(
    df: DataFrame, cols: Union[str, List[str]], min_v: Any, max_v: Any
) -> bool:
    ...
