from contextlib import suppress
from typing import Union


def try_casting_to_number(s: str) -> Union[str, int, float]:
    """Try to cast to:
        1. float
        2. int

    Returns: cast float, cast int or input string
    """
    with suppress(ValueError):
        return float(s)
    with suppress(ValueError):
        return int(s)
    return s
