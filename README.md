# Silex

Add more 🔥 to [Apache Spark](https://spark.apache.org/)!

[![Python](https://img.shields.io/badge/Python3.8-Python?style=for-the-badge&logo=Python)](https://www.python.org/downloads/release/python-380/)
[![Manager: Poetry](https://img.shields.io/badge/Manager-Poetry-blue?style=for-the-badge)](https://python-poetry.org/)
[![Test: BDD](https://img.shields.io/badge/Test-BDD-critical?style=for-the-badge)](https://github.com/behave/behave)
[![Test: Doctest](https://img.shields.io/badge/Test-Doctest-success?style=for-the-badge)](https://docs.python.org/3/library/doctest.html)

[![Code style: Black](https://img.shields.io/badge/Codestyle-Black-black?style=for-the-badge)](https://github.com/psf/black)
[![Imports: isort](https://img.shields.io/badge/%20imports-isort-%231674b1?style=for-the-badge&labelColor=ef8336)](https://pycqa.github.io/isort/)
[![Linter: Flake8](https://img.shields.io/badge/Linter-Flake8-black?style=for-the-badge)](https://github.com/PyCQA/flake8)
[![try/except style: tryceratops](https://img.shields.io/badge/try%2Fexcept%20style-tryceratops%20%F0%9F%A6%96%E2%9C%A8-black?style=for-the-badge)](https://github.com/guilatrova/tryceratops)

[![Typing: MyPy](https://img.shields.io/badge/Typing-MyPy-blue?style=for-the-badge)](https://github.com/python/mypy)
[![Security: Bandit](https://img.shields.io/badge/Security-Bandit-critical?style=for-the-badge)](https://github.com/PyCQA/bandit)


[![Git: Pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&style=for-the-badge&logoColor=white)](https://pre-commit.com/)
[![Git: Conventional](https://img.shields.io/badge/Git-conventional-ff69b4?style=for-the-badge)](https://www.conventionalcommits.org)
[![Version: Semantic](https://img.shields.io/badge/Version-Semantic-black?style=for-the-badge)](https://semver.org/)

![Apache Spark](https://img.shields.io/static/v1?style=for-the-badge&message=Apache+Spark+%20+3&color=E25A1C&logo=Apache+Spark&logoColor=FFFFFF&label=)

## TLDR

Silex is a Data Engineering library to extend PySpark.

You don't need another class, just use PySpark as usual and you have new functions to your DataFrames!

```python
import silex
from pyspark.sql import DataFrame

# extends your DataFrame with silex functions!
# if for some reason you don't want to do that, check 'Without extending Dataframes' README section below
silex.extend_dataframes()

df: DataFrame = ...  # your regular Spark DataFrame
df: DataFrame = df.drop_col_if_na()  # new function! and still a regular Spark Dataframe!
# scroll for more information!
```

### Available functions

```python
# assertions (raises an Exception if not met /!\)
def expect_column(self, col: str) -> DataFrame: ...
def expect_columns(self, cols: Union[str, List[str]]) -> DataFrame: ...

def expect_distinct_values_equal_set(self, cols: Union[str, List[str]], values: Collection[Any]) -> DataFrame: ...
def expect_distinct_values_in_set(self, cols: Union[str, List[str]], values: Collection[Any]) -> DataFrame: ...

def expect_min_value_between(self, cols: Union[str, List[str]], min: Any, max: Any) -> DataFrame: ...
def expect_avg_value_between(self, cols: Union[str, List[str]], min: Any, max: Any) -> DataFrame: ...
def expect_max_value_between(self, cols: Union[str, List[str]], min: Any, max: Any) -> DataFrame: ...

def expect_unique_id(self, cols: Union[str, List[str]]) -> DataFrame: ...

# boolean checks
def has_column(self, col: str) -> bool: ...
def has_columns(self, cols: Union[str, List[str]]) -> bool: ...

def has_distinct_values_equal_set(self, cols: Union[str, List[str]], values: Collection[Any]) -> bool: ...
def has_distinct_values_in_set(self, cols: Union[str, List[str]], values: Collection[Any]) -> bool: ...

def has_min_value_between(self, cols: Union[str, List[str]], min: Any, max: Any) -> bool: ...
def has_avg_value_between(self, cols: Union[str, List[str]], min: Any, max: Any) -> bool: ...
def has_max_value_between(self, cols: Union[str, List[str]], min: Any, max: Any) -> bool: ...

def has_unique_id(self, cols: Union[str, List[str]]) -> bool: ...

# dates
def with_date_column(self, col: str, fmt: str, new_col: Optional[str] = None) -> DataFrame: ...

# drop
def drop_col_if_na(self, max: int) -> DataFrame: ...
def drop_col_if_not_distinct(self, min: int) -> DataFrame: ...

# filters
def filter_on_range(self, col: str, from_: Any, to: Any, ...) -> DataFrame: ...

# joins
def join_closest_date(self, other: DataFrame, ...) -> DataFrame: ...
```

## Getting started

### Pre-requisites

- Python 3.8 or above
- Spark 3 or above

### Installation

```shell
pip install < # TODO >
```

### Usage

#### By extending DataFrames! ⚡

```python
import silex
from pyspark.sql import DataFrame, SparkSession

# extends your DataFrame with silex functions!
# if for some reason you don't want to do that, check next example
silex.extend_dataframes()

spark = SparkSession.builder.getOrCreate()

data = [
    (0, "2022-01-01", "a", 1.0),
    (1, "2022-02-01", "b", 2.0),
    (2, "2022-03-01", "c", 3.0),
]
df: DataFrame = spark.createDataFrame(data, schema=["id", "date", "text", "value"])

df.show()
# +---+----------+----+-----+
# | id|      date|text|value|
# +---+----------+----+-----+
# |  0|2022-01-01|   a|  1.0|
# |  1|2022-02-01|   b|  2.0|
# |  2|2022-03-01|   c|  3.0|
# +---+----------+----+-----+

df.printSchema()
# root
#  |-- id: long (nullable = true)
#  |-- date: string (nullable = true)
#  |-- text: string (nullable = true)
#  |-- value: double (nullable = true)

df = df.with_date_column(col="date", fmt="yyyy-MM-dd")

df.show()
# +---+----------+----+-----+
# | id|      date|text|value|
# +---+----------+----+-----+
# |  0|2022-01-01|   a|  1.0|
# |  1|2022-02-01|   b|  2.0|
# |  2|2022-03-01|   c|  3.0|
# +---+----------+----+-----+

df.printSchema()
# root
#  |-- id: long (nullable = true)
#  |-- date: date (nullable = true)
#  |-- text: string (nullable = true)
#  |-- value: double (nullable = true)
```

#### Without extending Dataframes 🌧️

```python
from silex.fn.date import with_date_column
from pyspark.sql import DataFrame, SparkSession

spark = SparkSession.builder.getOrCreate()

data = [
    (0, "2022-01-01", "a", 1.0),
    (1, "2022-02-01", "b", 2.0),
    (2, "2022-03-01", "c", 3.0),
]
df: DataFrame = spark.createDataFrame(data, schema=["id", "date", "text", "value"])

df.show()
# +---+----------+----+-----+
# | id|      date|text|value|
# +---+----------+----+-----+
# |  0|2022-01-01|   a|  1.0|
# |  1|2022-02-01|   b|  2.0|
# |  2|2022-03-01|   c|  3.0|
# +---+----------+----+-----+

df.printSchema()
# root
#  |-- id: long (nullable = true)
#  |-- date: string (nullable = true)
#  |-- text: string (nullable = true)
#  |-- value: double (nullable = true)

df = with_date_column(df=df, col="date", fmt="yyyy-MM-dd")

df.show()
# +---+----------+----+-----+
# | id|      date|text|value|
# +---+----------+----+-----+
# |  0|2022-01-01|   a|  1.0|
# |  1|2022-02-01|   b|  2.0|
# |  2|2022-03-01|   c|  3.0|
# +---+----------+----+-----+

df.printSchema()
# root
#  |-- id: long (nullable = true)
#  |-- date: date (nullable = true)
#  |-- text: string (nullable = true)
#  |-- value: double (nullable = true)
```

## Contributing

```shell
# install poetry and python 3.8, using pyenv for instance

cd silex
poetry env use path/to/python3.8  # e.g. ~/.pyenv/versions/3.8.12/bin/python
poetry shell
poetry install
pre-commit install

make help
# or open Makefile to learn about available commands for development
```
