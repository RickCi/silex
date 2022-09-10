from behave import step


@step('the "{field}" is of instance of "{clazz}"')
def step_impl(context, field: str, clazz: str):
    obj = getattr(context, field)
    assert obj.__class__.__name__ == clazz
