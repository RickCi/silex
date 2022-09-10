from behave import step

from silex.testing.string import parse


@step('the "{field}" is of instance of "{clazz}"')
def step_impl(context, field: str, clazz: str):
    obj = getattr(context, field)
    name = obj.__class__.__name__
    if name != clazz:
        raise ValueError(f"out: '{name}' != expected: '{clazz}'")


@step('the "{field}" equals to "{value}"')
def step_impl(context, field: str, value: str):
    obj = getattr(context, field)
    if obj != parse(value):
        raise ValueError(f"out: '{obj}' != expected: '{value}'")
