import json

from behave import step
from pyspark.sql import DataFrame


@step(
    'we do "{op}" on table "{in_}" with parameters "{parameters}" and save to table "{out}"'
)
def step_impl(context, op: str, in_: str, parameters: str, out: str):
    params: dict = json.loads(parameters)
    df: DataFrame = getattr(context, in_)
    fn = getattr(df, op)
    output: DataFrame = fn(**params)
    setattr(context, out, output)
