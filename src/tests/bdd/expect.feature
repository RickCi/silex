@wip
Feature: Expect
  Background:
    Given a Spark Session
    And dataframes are extended

  Scenario: Expecting unique ids raises a SilexDuplicateIdsException
    Given a table named "input"
      | id | value |
      | 0  | 0     |
      | 1  | 1     |
      | 1  | 2     |
    And parameters "{"cols": "id"}"
    When we try doing "expect_unique_id" on table "input" and save the result to "output"
    Then the "output" is of instance of "SilexDuplicateIdsException"
  Scenario: Expecting unique ids returns its input
    Given a table named "input"
      | id | value |
      | 0  | 0     |
      | 1  | 1     |
      | 2  | 2     |
    And a table named "expected"
      | id | value |
      | 0  | 0     |
      | 1  | 1     |
      | 2  | 2     |
    And parameters "{"cols": "id"}"
    When we do "expect_unique_id" on table "input" and save to "output" table
    Then the "output" table matches the "expected" table

  Scenario: Expecting column raises a SilexMissingColumnException
    Given a table named "input"
      | id | value |
      | 0  | 0     |
      | 1  | 1     |
      | 1  | 2     |
    And parameters "{"col": "x"}"
    When we try doing "expect_column" on table "input" and save the result to "output"
    Then the "output" is of instance of "SilexMissingColumnException"
  Scenario: Expecting column returns its input
    Given a table named "input"
      | id | value |
      | 0  | 0     |
      | 1  | 1     |
      | 2  | 2     |
    And a table named "expected"
      | id | value |
      | 0  | 0     |
      | 1  | 1     |
      | 2  | 2     |
    And parameters "{"col": "id"}"
    When we do "expect_column" on table "input" and save to "output" table
    Then the "output" table matches the "expected" table

  Scenario: Expecting columns raises a SilexMissingColumnsException
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": ["value", "x"]}"
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

  Scenario: Expecting distinct values equals set raises a SilexMissingValuesException when subset
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": ["id", "bis"], "values": [0, 1, "a", "b"]}"
    When we try doing "expect_distinct_values_equal_set" on table "input" and save the result to "output"
    Then the "output" is of instance of "SilexMissingValuesException"
  Scenario: Expecting distinct values equals set raises a SilexUnexpectedValuesException when superset
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": ["id", "bis"], "values": [0, 1]}"
    When we try doing "expect_distinct_values_equal_set" on table "input" and save the result to "output"
    Then the "output" is of instance of "SilexUnexpectedValuesException"
  Scenario: Expecting distinct values equals set returns its input
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And a table named "expected"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": ["id", "bis"], "values": [0, 1, "a"]}"
    When we do "expect_distinct_values_equal_set" on table "input" and save to "output" table
    Then the "output" table matches the "expected" table
