from pyspark.sql import DataFrame

from silex.fn.drop import drop_col_if_na


def extend_dataframes():
    setattr(DataFrame, "drop_col_if_na", drop_col_if_na)  # noqa: B010
