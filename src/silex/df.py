from pyspark.sql import DataFrame

from silex.fn.drop import drop_col_if_na, drop_col_if_not_distinct


def extend_dataframes():
    fns = [
        drop_col_if_na,
        drop_col_if_not_distinct,
    ]

    for fn in fns:
        setattr(DataFrame, fn.__name__, fn)  # noqa: B010
