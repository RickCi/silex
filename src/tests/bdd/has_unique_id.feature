Feature: has_unique_id
  Background:
    Given a Spark Session
    And dataframes are extended
  Scenario: Has unique id returns True
    Given a table named "input"
      | id |
      | 0  |
      | 1  |
      | 2  |
    And parameters "{"cols": "id"}"
    When we try doing "has_unique_id" on table "input" and save the result to "output"
    Then the "output" equals to "<TRUE>"
  Scenario: Has unique idreturns False
    Given a table named "input"
      | id |
      | 0  |
      | 1  |
      | 1  |
    And parameters "{"cols": "id"}"
    When we try doing "has_unique_id" on table "input" and save the result to "output"
    Then the "output" equals to "<FALSE>"
  Scenario: Has unique id returns True, several cols
    Given a table named "input"
      | id | id2 |
      | 0  | 0   |
      | 1  | 1   |
      | 2  | 2   |
    And parameters "{"cols": ["id", "id2"]}"
    When we try doing "has_unique_id" on table "input" and save the result to "output"
    Then the "output" equals to "<TRUE>"
  Scenario: Has unique id returns False, several cols
    Given a table named "input"
      | id | id2 |
      | 0  | 0   |
      | 1  | 1   |
      | 1  | 1   |
    And parameters "{"cols": ["id", "id2"]}"
    When we try doing "has_unique_id" on table "input" and save the result to "output"
    Then the "output" equals to "<FALSE>"
