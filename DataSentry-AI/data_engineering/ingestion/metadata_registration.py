from data_engineering.ingestion.database import get_connection


def get_or_create_datasource(
    connection,
    source_name: str,
    source_type: str,
    description: str = None
):
    """
    Get an existing DataSource or create a new one.
    """

    cursor = connection.cursor()

    # --------------------------------------------------------
    # Check existing DataSource
    # --------------------------------------------------------

    cursor.execute(
        """
        SELECT SourceID
        FROM core.DataSources
        WHERE SourceName = ?
        """,
        source_name
    )

    row = cursor.fetchone()

    if row:
        source_id = row[0]

        print(
            f"DataSource already exists. "
            f"SourceID = {source_id}"
        )

        cursor.close()

        return source_id

    # --------------------------------------------------------
    # Create DataSource
    # --------------------------------------------------------

    cursor.execute(
        """
        INSERT INTO core.DataSources
        (
            SourceName,
            SourceType,
            Description
        )
        OUTPUT INSERTED.SourceID
        VALUES
        (
            ?,
            ?,
            ?
        )
        """,
        source_name,
        source_type,
        description
    )

    source_id = cursor.fetchone()[0]

    connection.commit()

    cursor.close()

    print(
        f"DataSource created. "
        f"SourceID = {source_id}"
    )

    return source_id


def get_or_create_dataset(
    connection,
    source_id: int,
    dataset_name: str,
    description: str = None,
    business_domain: str = None
):
    """
    Get an existing Dataset or create a new one.
    """

    cursor = connection.cursor()

    # --------------------------------------------------------
    # Check existing dataset
    # --------------------------------------------------------

    cursor.execute(
        """
        SELECT DatasetID
        FROM core.Datasets
        WHERE SourceID = ?
          AND DatasetName = ?
        """,
        source_id,
        dataset_name
    )

    row = cursor.fetchone()

    if row:

        dataset_id = row[0]

        print(
            f"Dataset already exists. "
            f"DatasetID = {dataset_id}"
        )

        cursor.close()

        return dataset_id

    # --------------------------------------------------------
    # Create dataset
    # --------------------------------------------------------

    cursor.execute(
        """
        INSERT INTO core.Datasets
        (
            SourceID,
            DatasetName,
            Description,
            BusinessDomain
        )
        OUTPUT INSERTED.DatasetID
        VALUES
        (
            ?,
            ?,
            ?,
            ?
        )
        """,
        source_id,
        dataset_name,
        description,
        business_domain
    )

    dataset_id = cursor.fetchone()[0]

    connection.commit()

    cursor.close()

    print(
        f"Dataset created. "
        f"DatasetID = {dataset_id}"
    )

    return dataset_id


def create_dataset_version(
    connection,
    dataset_id: int,
    file_name: str,
    file_size_bytes: int,
    record_count: int,
    schema_hash: str
):
    """
    Create a new dataset version.
    """

    cursor = connection.cursor()

    # --------------------------------------------------------
    # Find next version number
    # --------------------------------------------------------

    cursor.execute(
        """
        SELECT
            ISNULL(MAX(VersionNumber), 0) + 1
        FROM core.DatasetVersions
        WHERE DatasetID = ?
        """,
        dataset_id
    )

    version_number = cursor.fetchone()[0]

    # --------------------------------------------------------
    # Create version
    # --------------------------------------------------------

    cursor.execute(
        """
        INSERT INTO core.DatasetVersions
        (
            DatasetID,
            VersionNumber,
            FileName,
            FileSizeBytes,
            RecordCount,
            SchemaHash,
            Status
        )
        OUTPUT INSERTED.VersionID
        VALUES
        (
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?
        )
        """,
        dataset_id,
        version_number,
        file_name,
        file_size_bytes,
        record_count,
        schema_hash,
        "INGESTED"
    )

    version_id = cursor.fetchone()[0]

    connection.commit()

    cursor.close()

    print(
        f"DatasetVersion created. "
        f"VersionID = {version_id}, "
        f"VersionNumber = {version_number}"
    )

    return version_id


def register_dataset_columns(
    connection,
    version_id: int,
    columns: list
):
    """
    Register detected dataset columns.
    """

    cursor = connection.cursor()

    registered_count = 0

    for column in columns:

        cursor.execute(
            """
            INSERT INTO core.DatasetColumns
            (
                VersionID,
                ColumnName,
                DataType,
                IsNullable,
                OrdinalPosition,
                IsPrimaryKeyCandidate,
                Description
            )
            VALUES
            (
                ?,
                ?,
                ?,
                ?,
                ?,
                ?,
                ?
            )
            """,
            version_id,
            column["column_name"],
            column["data_type"],
            column["is_nullable"],
            column["ordinal_position"],
            False,
            None
        )

        registered_count += 1

    connection.commit()

    cursor.close()

    print(
        f"DatasetColumns registered: "
        f"{registered_count}"
    )