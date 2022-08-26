Feature: Dropping columns having null values
    Background:
      Given a Spark Session
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
      When we do "drop_if_na" on table "input" with parameters "{}" and save to table "output"
      Then the "output" table matches the "expected" table
    Scenario: Some null values
      Given a table named "input"
        | id | value |
        | 0  | a     |
        | 1  | NULL  |
        | 2  | b     |
      And a table named "expected"
        | id |
        | 0  |
        | 1  |
        | 2  |
      When we do "drop_if_na" on table "input" with parameters "{}" and save to table "output"
      Then the "output" table matches the "expected" table
