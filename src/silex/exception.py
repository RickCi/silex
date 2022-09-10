class SilexException(Exception):
    pass


class SilexExpectException(SilexException):
    pass


class SilexDuplicateIdsException(SilexExpectException):
    def __init__(self, cols):
        super().__init__(f"Found duplicate ids for columns: {cols}")
