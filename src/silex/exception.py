class SilexException(Exception):
    pass


class SilexExpectException(SilexException):
    pass


class SilexDuplicateIdsException(SilexExpectException):
    def __init__(self, cols):
        super().__init__(f"Found duplicate ids for columns: {cols}")


class SilexMissingColumnException(SilexExpectException):
    def __init__(self, col):
        super().__init__(f"Missing column: {col}")


class SilexMissingColumnsException(SilexExpectException):
    def __init__(self, cols):
        super().__init__(f"Missing columns: {cols}")


class SilexUnexpectedValuesException(SilexExpectException):
    def __init__(self, col):
        super().__init__(f"Unexpected values for column: {col}")


class SilexMissingValuesException(SilexExpectException):
    def __init__(self, found, expected):
        msg = f"set of values are not equal: len(found)={len(found)} != len(expected)={len(expected)}"
        super().__init__(msg)
