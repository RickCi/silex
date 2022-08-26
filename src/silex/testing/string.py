from contextlib import suppress
from typing import Union


def parse(s: str) -> Union[None, str, int, float]:
    """Try to cast to:
        1. float
        2. int

    Returns: cast float, cast int or input string
    """
    if s == "<NULL>":
        return None
    with suppress(ValueError):
        return float(s)
    with suppress(ValueError):
        return int(s)
    return s
