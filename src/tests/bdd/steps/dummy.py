from behave import step

from silex.dummy import hello


@step("saying hello world")
def step_impl(context):
    context.hello = hello()


@step("we hear hello world")
def step_impl(context):
    assert context.hello == "hello world"
