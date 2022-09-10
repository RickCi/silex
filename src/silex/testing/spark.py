from pyspark.sql import DataFrame


def schema_equals(df1: DataFrame, df2: DataFrame, check_nullable: bool):
    def field_list(fields):
        return fields.name, fields.dataType, fields.nullable

    fields1 = [*map(field_list, df1.schema.fields)]
    fields2 = [*map(field_list, df2.schema.fields)]
    if check_nullable:
        res = set(fields1) == set(fields2)
    else:
        res = {field[:-1] for field in fields1} == {field[:-1] for field in fields2}
    return res


def data_equals(df1: DataFrame, df2: DataFrame, sort_cols: bool):
    if sort_cols:
        df1 = df1.select(sorted(df1.columns))
        df2 = df2.select(sorted(df2.columns))

    data1 = df1.collect()
    data2 = df2.collect()
    return set(data1) == set(data2)


def df_equals(df1: DataFrame, df2: DataFrame, check_nullable: bool, sort_cols: bool):
    schema = schema_equals(df1, df2, check_nullable=check_nullable)
    data = data_equals(df1, df2, sort_cols=sort_cols)
    return schema and data
