from typing import List

import pyspark.sql.functions as F
from behave import step
from pyspark.sql import DataFrame
from pyspark.sql.types import DateType

from silex.testing.spark import df_equals
from silex.testing.string import parse


@step('a table named "{name}"')
def step_impl(context, name: str):
    def parse_typings(cols: List[str]):
        typing_mapping = dict()
        for col in cols:
            if "<date>" in col:
                typing_mapping[col] = DateType()
        return typing_mapping

    def cast_typings(df: DataFrame, typings: dict):
        for col, type_ in typings.items():
            df = df.withColumn(
                col.replace("<date>", "").strip(), F.col(col).cast(type_)
            ).drop(col)
        return df

    def parse_table(table):
        data = []

        for row in table:
            new_row = []
            for col in context.table.headings:
                value = row[col]
                if col in ["id", "identifier"]:
                    value = int(value)
                else:
                    value = parse(value)
                new_row.append(value)
            data.append(new_row)
        return data

    typings = parse_typings(cols=context.table.headings)
    data = parse_table(context.table)
    df: DataFrame = context.spark.createDataFrame(data).toDF(*context.table.headings)
    df = cast_typings(df=df, typings=typings)
    setattr(context, name, df)


@step('the "{left}" table matches the "{right}" table')
def step_impl(context, left, right):
    left_df = getattr(context, left)
    right_df = getattr(context, right)

    # useful for debugging
    left_df.show()
    right_df.show()

    assert df_equals(left_df, right_df, check_nullable=True, sort_cols=True)


@step('the "{left}" table does not match the "{right}" table')
def step_impl(context, left, right):
    left_df = getattr(context, left)
    right_df = getattr(context, right)

    # useful for debugging
    left_df.show()
    right_df.show()

    assert not df_equals(left_df, right_df, check_nullable=True, sort_cols=True)
