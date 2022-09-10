from contextlib import suppress
from typing import Union


def parse(s: str) -> Union[None, str, bool, int, float]:
    """Try to cast to:
        1. None: <null> (case is ignored)
        2. bool: {<true>, <false>} (case is ignored)
        3. integer
        4. float

    or keep as string.

    Returns: None

    >>> parse("<null>") is None
    True
    >>> parse("<true>")
    True
    >>> parse("<FALSE>")
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
