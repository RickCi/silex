from typing import List, Union

from pyspark.sql import DataFrame


def expect_unique_id(cols: Union[str, List[str]]) -> DataFrame:
    ...
