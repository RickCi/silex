Feature: Filtering over a range of values
    Background:
      Given a Spark Session
      And dataframes are extended
    Scenario: Integer range: [1, 2]
      Given a table named "input"
        | id | value  |
        | 0  | 0      |
        | 1  | 1      |
        | 2  | 2      |
        | 3  | <NULL> |
      And a table named "expected"
        | id | value  |
        | 1  | 1      |
        | 2  | 2      |
      And parameters "{"col": "value", "from_": 1, "to": 2}"
      When we do "filter_on_range" on table "input" and save to "output" table
      Then the "output" table matches the "expected" table
    Scenario: Integer range: ]1, 3[
      Given a table named "input"
        | id | value  |
        | 0  | 0      |
        | 1  | 1      |
        | 2  | 2      |
        | 3  | <NULL> |
        | 4  | 3      |
      And a table named "expected"
        | id | value  |
        | 2  | 2      |
      And parameters "{"col": "value", "from_": 1, "to": 3, "include_from": false, "include_to": false}"
      When we do "filter_on_range" on table "input" and save to "output" table
      Then the "output" table matches the "expected" table
    Scenario: Float range: [0.0, 1.2]
      Given a table named "input"
        | id | value  |
        | 0  | 0.1    |
        | 1  | 1.1    |
        | 2  | 2.1    |
        | 3  | <NULL> |
      And a table named "expected"
        | id | value  |
        | 0  | 0.1    |
        | 1  | 1.1    |
      And parameters "{"col": "value", "from_": 0.0, "to": 1.2}"
      When we do "filter_on_range" on table "input" and save to "output" table
      Then the "output" table matches the "expected" table
    Scenario: String range: [a, e]
      Given a table named "input"
        | id | value  |
        | 0  | a      |
        | 1  | z      |
        | 2  | e      |
        | 3  | <NULL> |
      And a table named "expected"
        | id | value  |
        | 0  | a      |
        | 2  | e      |
      And parameters "{"col": "value", "from_": "a", "to": "e"}"
      When we do "filter_on_range" on table "input" and save to "output" table
      Then the "output" table matches the "expected" table
