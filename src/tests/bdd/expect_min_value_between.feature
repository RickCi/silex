Feature: expect_min_value_between
  Background:
    Given a Spark Session
    And dataframes are extended

  Scenario: Expecting min value outside of range raises SilexUnexpectedValueException
    Given a table named "input"
      | id | value | bis |
      | 0  | 1     | a   |
      | 1  | 2     | a   |
      | 2  | 0     | a   |
    And parameters "{"cols": ["id", "value"], "min_v": 1, "max_v": 3}"
    When we try doing "expect_min_value_between" on table "input" and save the result to "output"
    Then the "output" is of instance of "SilexUnexpectedValueException"
  Scenario: Expecting distinct values equals set raises a SilexUnexpectedValuesException when superset
    Given a table named "input"
      | id | value | bis |
      | 0  | 1     | a   |
      | 1  | 2     | a   |
      | 2  | 0     | a   |
    And a table named "expected"
      | id | value | bis |
      | 0  | 1     | a   |
      | 1  | 2     | a   |
      | 2  | 0     | a   |
    And parameters "{"cols": ["id", "value"], "min_v": -1, "max_v": 3}"
    When we try doing "expect_min_value_between" on table "input" and save the result to "output"
    Then the "output" table matches the "expected" table
