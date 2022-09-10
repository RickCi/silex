Feature: with_date_column
  Background:
    Given a Spark Session
    And dataframes are extended

  Scenario: Parse string as date with format "yyyy-MM-dd HH:mm:ss"
    Given a table named "input"
      | id | date                |
      | 0  | 2022-01-01 00:00:00 |
      | 1  | 2022-01-31 23:59:59 |
    And a table named "expected"
      | id | date <date> |
      | 0  | 2022-01-01  |
      | 1  | 2022-01-31  |
    And parameters "{"col": "date", "fmt": "yyyy-MM-dd HH:mm:ss"}"
    When we try doing "with_date_column" on table "input" and save the result to "output"
    Then the "output" table matches the "expected" table

  Scenario: Parse string as date with format "yyyy/dd/MM"
    Given a table named "input"
      | id | date       |
      | 0  | 2022/01/01 |
      | 1  | 2022/31/01 |
    And a table named "expected"
      | id | date <date> |
      | 0  | 2022-01-01  |
      | 1  | 2022-01-31  |
    And parameters "{"col": "date", "fmt": "yyyy/dd/MM"}"
    When we try doing "with_date_column" on table "input" and save the result to "output"
    Then the "output" table matches the "expected" table

  Scenario: Parse string as date with format "yyyy/MM/dd"
    Given a table named "input"
      | id | date       |
      | 0  | 2022/01/01 |
      | 1  | 2022/01/31 |
    And a table named "expected"
      | id | date <date> |
      | 0  | 2022-01-01  |
      | 1  | 2022-01-31  |
    And parameters "{"col": "date", "fmt": "yyyy/MM/dd"}"
    When we try doing "with_date_column" on table "input" and save the result to "output"
    Then the "output" table matches the "expected" table
