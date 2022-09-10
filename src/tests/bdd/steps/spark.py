from behave import step

import silex
from silex.utils.spark import get_spark_session


@step("a Spark Session")
def step_impl(context):
    context.spark = get_spark_session()


@step("dataframes are extended")
def step_impl(context):
    silex.extend_dataframes()
