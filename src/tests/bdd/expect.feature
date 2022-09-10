@wip
Feature: Expect
    Background:
      Given a Spark Session
      And dataframes are extended
    Scenario: Expecting unique ids raise a SilexDuplicateIdsException
      Given a table named "input"
        | id | value |
        | 0  | 0     |
        | 1  | 1     |
        | 1  | 2     |
      And parameters "{"cols": "id"}"
      When we try doing "expect_unique_id" on table "input" and save the result to "output"
      Then the "output" is of instance of "SilexDuplicateIdsException"
    Scenario: Expecting unique ids returns its input
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
      And parameters "{"cols": "id"}"
      When we do "expect_unique_id" on table "input" and save to "output" table
      Then the "output" table matches the "expected" table

#    Scenario: Expecting column
#      Given a table named "input"
#        | id | value  |
#        | 0  | a      |
#        | 1  | <NULL> |
#        | 2  | b      |
#      And a table named "expected"
#        | id |
#        | 0  |
#        | 1  |
#        | 2  |
#      When we do "expect_column" on table "input" and save to "output" table
#      Then the "output" table matches the "expected" table
#    Scenario: Expecting columns
#      Given a table named "input"
#        | id | value  | value2 |
#        | 0  | a      | <NULL> |
#        | 1  | <NULL> | <NULL> |
#        | 2  | b      | x      |
#      And a table named "expected"
#        | id | value  |
#        | 0  | a      |
#        | 1  | <NULL> |
#        | 2  | b      |
#      And parameters "{"max": 1}"
#      When we do "expect_columns" on table "input" and save to "output" table
#      Then the "output" table matches the "expected" table
