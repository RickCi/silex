Feature: has_column
  Background:
    Given a Spark Session
    And dataframes are extended

  Scenario: Has column returns True
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"col": "id"}"
    When we try doing "has_column" on table "input" and save the result to "output"
    Then the "output" equals to "<TRUE>"
  Scenario: Has column returns False
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"col": "x"}"
    When we try doing "has_column" on table "input" and save the result to "output"
    Then the "output" equals to "<FALSE>"
