Feature: Dropping columns for not having distinct values
    Background:
      Given a Spark Session
      And dataframes are extended
    Scenario: No distinct values
      Given a table named "input"
        | id | value |
        | 0  | 0     |
        | 1  | 0     |
        | 2  | 0     |
      And a table named "expected"
        | id |
        | 0  |
        | 1  |
        | 2  |
      When we do "drop_col_if_not_distinct" on table "input" and save to "output" table
      Then the "output" table matches the "expected" table
    Scenario: Distinct values with null, null are not counted
      Given a table named "input"
        | id | value  |
        | 0  | a      |
        | 1  | <NULL> |
        | 1  | b      |
      And a table named "expected"
        | id |
        | 0  |
        | 1  |
        | 1  |
          Scenario: Distinct values
      Given a table named "input"
        | id | value  |
        | 0  | a      |
        | 1  | c      |
        | 1  | b      |
      And a table named "expected"
        | id | value  |
        | 0  | a      |
        | 1  | c      |
        | 1  | b      |
      When we do "drop_col_if_not_distinct" on table "input" and save to "output" table
      Then the "output" table matches the "expected" table
    Scenario: Threshold set at 3 different values, null are not counted
      Given a table named "input"
        | id | value  | value2 |
        | 0  | a      | <NULL> |
        | 1  | <NULL> | <NULL> |
        | 2  | b      | x      |
      And a table named "expected"
        | id |
        | 0  |
        | 1  |
        | 2  |
      And parameters "{"min": 3}"
      When we do "drop_col_if_not_distinct" on table "input" and save to "output" table
      Then the "output" table matches the "expected" table
