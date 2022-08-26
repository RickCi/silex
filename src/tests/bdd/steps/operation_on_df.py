import json

from behave import step
from pyspark.sql import DataFrame


@step('we do "{op}" on table "{in_}" with parameters "{p}" and save to "{out}" table')
def step_impl(context, op: str, in_: str, p: str, out: str):
    params: dict = json.loads(p)
    df: DataFrame = getattr(context, in_)
    fn = getattr(df, op)
    output: DataFrame = fn(**params)
    setattr(context, out, output)


@step('we do "{op}" on table "{in_}" and save to "{out}" table')
def step_impl(context, op: str, in_: str, out: str):
    if hasattr(context, "params"):
        params: dict = context.params
    else:
        params = dict()
    df: DataFrame = getattr(context, in_)
    fn = getattr(df, op)
    output: DataFrame = fn(**params)
    setattr(context, out, output)
