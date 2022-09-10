Feature: has_columns
  Background:
    Given a Spark Session
    And dataframes are extended

  Scenario: Has columns returns True
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": ["value", "id"]}"
    When we try doing "has_columns" on table "input" and save the result to "output"
    Then the "output" equals to "<TRUE>"
  Scenario: Has columns returns False
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": "x"}"
    When we try doing "has_columns" on table "input" and save the result to "output"
    Then the "output" equals to "<FALSE>"
