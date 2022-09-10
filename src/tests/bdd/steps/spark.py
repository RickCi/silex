from behave import step

from silex.df import extend_dataframes
from silex.utils.spark import get_spark_session


@step("a Spark Session")
def step_impl(context):
    context.spark = get_spark_session()


@step("dataframes are extended")
def step_impl(context):
    extend_dataframes()
