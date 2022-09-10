from pyspark.sql import DataFrame

from silex.fn.date import with_date_column
from silex.fn.drop import drop_col_if_na, drop_col_if_not_distinct
from silex.fn.expect import (
    expect_avg_value_between,
    expect_column,
    expect_columns,
    expect_distinct_values_equal_set,
    expect_distinct_values_in_set,
    expect_max_value_between,
    expect_min_value_between,
    expect_unique_id,
)
from silex.fn.filter import filter_on_range
from silex.fn.has import (
    has_avg_value_between,
    has_column,
    has_columns,
    has_distinct_values_equal_set,
    has_distinct_values_in_set,
    has_max_value_between,
    has_min_value_between,
    has_unique_id,
)
from silex.fn.join import join_closest_date


def extend_dataframes():
    fns = [
        drop_col_if_na,
        drop_col_if_not_distinct,
        expect_avg_value_between,
        expect_column,
        expect_columns,
        expect_distinct_values_equal_set,
        expect_distinct_values_in_set,
        expect_max_value_between,
        expect_min_value_between,
        expect_unique_id,
        filter_on_range,
        has_avg_value_between,
        has_column,
        has_columns,
        has_distinct_values_equal_set,
        has_distinct_values_in_set,
        has_max_value_between,
        has_min_value_between,
        has_unique_id,
        join_closest_date,
        with_date_column,
    ]

    for fn in fns:
        setattr(DataFrame, fn.__name__, fn)  # noqa: B010
