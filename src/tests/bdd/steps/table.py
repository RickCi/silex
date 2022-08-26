from typing import List

from behave import step

from silex.testing.spark import df_equals
from silex.testing.string import parse


@step('a table named "{name}"')
def step_impl(context, name: str):
    data = []
    cols_l: List[str] = context.table.headings

    for row in context.table:
        new_row = []
        for col in cols_l:
            value = row[col]
            if col in ["id", "identifier"]:
                value = int(value)
            else:
                value = parse(value)
            new_row.append(value)
        data.append(new_row)
    setattr(context, name, context.spark.createDataFrame(data).toDF(*cols_l))


@step('the "{left}" table matches the "{right}" table')
def step_impl(context, left, right):
    left_df = getattr(context, left)
    right_df = getattr(context, right)

    # useful for debugging
    left_df.show()
    right_df.show()

    assert df_equals(left_df, right_df, check_nullable=True)
