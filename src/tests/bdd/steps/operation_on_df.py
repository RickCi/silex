import json

from behave import step

operations = {"": ""}


@step(
    'we do "{op}" on table "{in_}" with parameters "{parameters}" and save to table "{out}"'
)
def step_impl(context, op: str, in_: str, parameters: str, out: str):
    params = json.loads(parameters)
    output = operations[op](getattr(context, in_), **params)
    setattr(context, out, output)
