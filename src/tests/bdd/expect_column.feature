Feature: expect_column
  Background:
    Given a Spark Session
    And dataframes are extended

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
