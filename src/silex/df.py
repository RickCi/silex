from pyspark.sql import DataFrame

from silex.fn.drop import drop_col_if_na, drop_col_if_not_distinct
from silex.fn.filter import filter_range
from silex.fn.join import join_closest_date


def extend_dataframes():
    fns = [
        drop_col_if_na,
        drop_col_if_not_distinct,
        filter_range,
        join_closest_date,
    ]

    for fn in fns:
        setattr(DataFrame, fn.__name__, fn)  # noqa: B010
