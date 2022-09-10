Feature: expect_distinct_values_in_set
  Background:
    Given a Spark Session
    And dataframes are extended

  Scenario: Expecting distinct values in set raises a SilexMissingColumnsException
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": ["id", "bis"], "values": [0, 1]}"
    When we try doing "expect_distinct_values_in_set" on table "input" and save the result to "output"
    Then the "output" is of instance of "SilexUnexpectedValuesException"
  Scenario: Expecting distinct values in set returns its input
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 2  | 4     | a   |
    And a table named "expected"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 2  | 4     | a   |
    And parameters "{"cols": ["id", "bis"], "values": [0, 1, "a", 2, 3]}"
    When we do "expect_distinct_values_in_set" on table "input" and save to "output" table
    Then the "output" table matches the "expected" table
