from pyspark.sql import DataFrame


def schema_equals(df1: DataFrame, df2: DataFrame, check_nullable=True):
    def field_list(fields):
        return fields.name, fields.dataType, fields.nullable

    fields1 = [*map(field_list, df1.schema.fields)]
    fields2 = [*map(field_list, df2.schema.fields)]
    if check_nullable:
        res = set(fields1) == set(fields2)
    else:
        res = {field[:-1] for field in fields1} == {field[:-1] for field in fields2}
    return res


def data_equals(df1: DataFrame, df2: DataFrame):
    data1 = df1.collect()
    data2 = df2.collect()
    return set(data1) == set(data2)


def df_equals(df1: DataFrame, df2: DataFrame, check_nullable=False):
    return schema_equals(df1, df2, check_nullable=check_nullable) and data_equals(
        df1, df2
    )
