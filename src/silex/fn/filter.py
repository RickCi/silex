from typing import TypeVar

import pyspark.sql.functions as F
from pyspark.sql import DataFrame

T = TypeVar("T")


def filter_range(
    df: DataFrame,
    col: str,
    from_: T,
    to: T,
    include_from: bool = True,
    include_to: bool = True,
) -> DataFrame:
    if include_from:
        from_cdt = F.col(col) >= from_
    else:
        from_cdt = F.col(col) > from_
    if include_to:
        to_cdt = F.col(col) <= to
    else:
        to_cdt = F.col(col) < to

    return df.filter((from_cdt & to_cdt))
