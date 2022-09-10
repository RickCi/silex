from typing import List

from behave import step
from pyspark.sql import DataFrame


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


@step('we do "{op}" on tables [{ins}] and save to "{out}" table')
def step_impl(context, op: str, ins: str, out: str):
    if hasattr(context, "params"):
        params: dict = context.params
    else:
        params = dict()
    dfs: List[DataFrame] = [getattr(context, in_) for in_ in ins.split(",")]
    fn = getattr(dfs[0], op)
    output: DataFrame = fn(*dfs[1:], **params)
    setattr(context, out, output)


@step('we try doing "{op}" on table "{in_}" and save the result to "{out}"')
def step_impl(context, op: str, in_: str, out: str):
    if hasattr(context, "params"):
        params: dict = context.params
    else:
        params = dict()
    df: DataFrame = getattr(context, in_)
    fn = getattr(df, op)
    try:
        output = fn(**params)
    except Exception as e:
        output = e
    setattr(context, out, output)
