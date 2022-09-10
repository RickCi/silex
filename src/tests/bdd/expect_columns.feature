Feature: expect_columns
  Background:
    Given a Spark Session
    And dataframes are extended

  Scenario: Expecting columns raises a SilexMissingColumnsException
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": ["value", "x"]}"
    When we try doing "expect_columns" on table "input" and save the result to "output"
    Then the "output" is of instance of "SilexMissingColumnsException"
  Scenario: Expecting columns raises a SilexMissingColumnsException, not finding single col
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": "x"}"
    When we try doing "expect_columns" on table "input" and save the result to "output"
    Then the "output" is of instance of "SilexMissingColumnsException"
  Scenario: Expecting columns returns its input
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 2  | 2     | a   |
    And a table named "expected"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 2  | 2     | a   |
    And parameters "{"cols": ["id", "value"]}"
    When we do "expect_columns" on table "input" and save to "output" table
    Then the "output" table matches the "expected" table
  Scenario: Expecting columns returns its input, finding single col
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 2  | 2     | a   |
    And a table named "expected"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 2  | 2     | a   |
    And parameters "{"cols": "id"}"
    When we do "expect_columns" on table "input" and save to "output" table
    Then the "output" table matches the "expected" table
