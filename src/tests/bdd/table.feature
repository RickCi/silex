Feature: Table
    Background:
      Given a Spark Session
    Scenario: Tables are equal
      Given a table named "left"
        | id | value |
        | 0  | 10    |
        | 1  | 11    |
        | 2  | 12    |
      And a table named "right"
        | id | value |
        | 0  | 10    |
        | 1  | 11    |
        | 2  | 12    |
      Then the "left" table matches the "right" table
    Scenario: Tables are equal with column in different order
      Given a table named "left"
        | id | value |
        | 0  | 10    |
        | 1  | 11    |
        | 2  | 12    |
      And a table named "right"
        | value | id |
        | 10    | 0  |
        | 11    | 1  |
        | 12    | 2  |
      Then the "left" table matches the "right" table
     Scenario: Tables are not equal
      Given a table named "left"
        | id | value |
        | 0  | 10    |
        | 1  | 11    |
        | 2  | 12    |
      And a table named "right"
        | id | value |
        | 0  | 110   |
        | 1  | 111   |
        | 2  | 112   |
      Then the "left" table does not match the "right" table
