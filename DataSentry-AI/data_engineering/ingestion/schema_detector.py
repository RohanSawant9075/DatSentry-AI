import pandas as pd


# ============================================================
# SCHEMA DETECTION
# ============================================================

def detect_schema(file_path: str) -> dict:
    """
    Read a CSV dataset and detect its basic schema.
    """

    dataframe = pd.read_csv(file_path)

    columns = []

    # --------------------------------------------------------
    # Inspect every column
    # --------------------------------------------------------

    for position, column_name in enumerate(
        dataframe.columns,
        start=1
    ):

        series = dataframe[column_name]

        columns.append(
            {
                "column_name": column_name,
                "data_type": str(series.dtype),
                "is_nullable": bool(series.isna().any()),
                "ordinal_position": position,
            }
        )

    # --------------------------------------------------------
    # Return schema information
    # --------------------------------------------------------

    return {
        "record_count": len(dataframe),
        "column_count": len(dataframe.columns),
        "columns": columns,
    }