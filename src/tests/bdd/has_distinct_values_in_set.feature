Feature: has_distinct_values_in_set
  Background:
    Given a Spark Session
    And dataframes are extended
  Scenario: returns True
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": "id", "values": [0, 1, 2, 3]}"
    When we try doing "has_distinct_values_in_set" on table "input" and save the result to "output"
    Then the "output" equals to "<TRUE>"
  Scenario: returns False
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": "id", "values": [1, 2, 3]}"
    When we try doing "has_distinct_values_in_set" on table "input" and save the result to "output"
    Then the "output" equals to "<FALSE>"
  Scenario: returns True, several cols
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": ["id", "bis"], "values": [0, 1, 2, 3, "a"]}"
    When we try doing "has_distinct_values_in_set" on table "input" and save the result to "output"
    Then the "output" equals to "<TRUE>"
  Scenario: returns False, several cols
    Given a table named "input"
      | id | value | bis |
      | 0  | 0     | a   |
      | 1  | 1     | a   |
      | 1  | 2     | a   |
    And parameters "{"cols": ["id", "bis"], "values": [0, 1, 2, 3]}"
    When we try doing "has_distinct_values_in_set" on table "input" and save the result to "output"
    Then the "output" equals to "<FALSE>"
