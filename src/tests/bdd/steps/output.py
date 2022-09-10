from behave import step


@step('the "{field}" is of instance of "{clazz}"')
def step_impl(context, field: str, clazz: str):
    obj = getattr(context, field)
    name = obj.__class__.__name__
    if name != clazz:
        raise ValueError(f"out: '{name}' != expected: '{clazz}'")
