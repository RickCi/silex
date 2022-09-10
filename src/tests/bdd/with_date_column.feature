Feature: with_date_column
  Background:
    Given a Spark Session
    And dataframes are extended

  Scenario: Has column returns True
    Given a table named "input"
      | id | date                |
      | 0  | 2022-01-01 00:00:00 |
      | 1  | 2022-01-31 23:59:59 |
    And a table named "expected"
      | id | date <date> |
      | 0  | 2022-01-01  |
      | 1  | 2022-01-31  |
    And parameters "{"col": "date"}"
    When we try doing "with_date_column" on table "input" and save the result to "output"
    Then the "output" table matches the "expected" table
