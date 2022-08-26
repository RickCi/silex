Feature: Join on closest date
    Background:
      Given a Spark Session
      And dataframes are extended
    Scenario: Simple
      Given a table named "left"
        | id | date       | left  |
        | 0  | 2022-01-01 | 10    |
      And a table named "right"
        | id | date2      | right |
        | 0  | 2022-01-10 | KO    |
        | 0  | 2022-01-02 | OK    |
        | 0  | 2022-01-05 | KO    |
      And a table named "expected"
        | id | date       | left  | date2      | right |
        | 0  | 2022-01-01 | 10    | 2022-01-02 | OK    |
      And parameters "{"id_cols": ["id"], "date_col": "date", "other_date_col": "date2"}"
      When we do "join_closest_date" on tables [left,right] and save to "output" table
      Then the "output" table matches the "expected" table
    Scenario: Complex
      Given a table named "left"
        | id | date       | left  |
        | 0  | 2022-01-01 | 10    |
        | 1  | 2022-01-02 | 11    |
        | 2  | 2022-01-03 | 12    |
        | 3  | 2022-01-04 | 13    |
      And a table named "right"
        | id | date2      | right |
        | 2  | 2022-01-02 | OK    |
        | 2  | 2022-01-05 | KO    |
        | 3  | 2022-02-04 | OK    |
        | 3  | 2022-02-05 | KO    |
        | 0  | 2022-01-10 | KO    |
        | 0  | 2022-01-02 | OK    |
        | 0  | 2022-01-05 | KO    |
        | 1  | 2022-01-01 | KO    |
        | 1  | 2022-01-02 | OK    |
        | 1  | 2022-01-10 | KO    |
      And a table named "expected"
        | id | date       | left  | date2      | right |
        | 0  | 2022-01-01 | 10    | 2022-01-02 | OK    |
        | 1  | 2022-01-02 | 11    | 2022-01-02 | OK    |
        | 2  | 2022-01-03 | 12    | 2022-01-02 | OK    |
        | 3  | 2022-01-04 | 13    | 2022-02-04 | OK    |
      And parameters "{"id_cols": ["id"], "date_col": "date", "other_date_col": "date2"}"
      When we do "join_closest_date" on tables [left,right] and save to "output" table
      Then the "output" table matches the "expected" table
