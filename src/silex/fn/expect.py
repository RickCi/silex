from typing import List, Union

from pyspark.sql import DataFrame


def expect_unique_id(df: DataFrame, cols: Union[str, List[str]]) -> DataFrame:
    ...
