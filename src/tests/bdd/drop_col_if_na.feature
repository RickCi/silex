Feature: Dropping columns having null values
    Background:
      Given a Spark Session
      And dataframes are extended
    Scenario: No null values
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
      When we do "drop_col_if_na" on table "input" with parameters "{}" and save to "output" table
      Then the "output" table matches the "expected" table
    Scenario: 1 null and no threshold
      Given a table named "input"
        | id | value  |
        | 0  | a      |
        | 1  | <NULL> |
        | 2  | b      |
      And a table named "expected"
        | id |
        | 0  |
        | 1  |
        | 2  |
      When we do "drop_col_if_na" on table "input" with parameters "{}" and save to "output" table
      Then the "output" table matches the "expected" table
    Scenario: 1 column below threshold and another above
      Given a table named "input"
        | id | value  | value2 |
        | 0  | a      | <NULL> |
        | 1  | <NULL> | <NULL> |
        | 2  | b      | x      |
      And a table named "expected"
        | id | value  |
        | 0  | a      |
        | 1  | <NULL> |
        | 2  | b      |
      When we do "drop_col_if_na" on table "input" with parameters "{"max": 1}" and save to "output" table
      Then the "output" table matches the "expected" table
