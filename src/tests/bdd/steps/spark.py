from behave import step

from silex.utils.spark import get_spark_session


@step("a Spark Session")
def step_impl(context):
    context.spark = get_spark_session()
