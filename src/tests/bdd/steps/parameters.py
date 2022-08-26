import json

from behave import step


@step('parameters "{parameters}"')
def step_impl(context, parameters: str):
    context.params: dict = json.loads(parameters)
