from contextlib import suppress
from typing import Union


def parse(s: str) -> Union[None, str, bool, int, float]:
    """Try to cast to:
        1. float
        2. int

    Returns: cast float, cast int or input string

    >>> parse("<null>") is None
    True
    >>> parse("<true>")
    True
    >>> parse("<false>")
    False
    >>> parse("1")
    1
    >>> parse("1.0")
    1.0
    >>> parse("a")
    'a'
    """
    s_upper = s.upper()
    if s_upper == "<NULL>":
        return None
    if s_upper == "<TRUE>":
        return True
    if s_upper == "<FALSE>":
        return False
    with suppress(ValueError):
        return int(s)
    with suppress(ValueError):
        return float(s)
    return s
