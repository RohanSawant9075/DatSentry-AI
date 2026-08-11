from data_engineering.ingestion.database import get_connection

from data_engineering.ingestion.file_validation import (
    validate_file
)

from data_engineering.ingestion.metadata import (
    get_file_metadata
)

from data_engineering.ingestion.schema_detector import (
    detect_schema
)

from data_engineering.ingestion.metadata_registration import (
    get_or_create_datasource,
    get_or_create_dataset,
    create_dataset_version,
    register_dataset_columns
)


FILE_PATH = "datasets/sample/customer_sample.csv"


def main():

    print("=" * 70)
    print("DataSentry AI - Day 5 Metadata Ingestion")
    print("=" * 70)

    # ========================================================
    # STEP 1 — VALIDATE FILE
    # ========================================================

    print("\n[1] Validating dataset...")

    validate_file(FILE_PATH)

    print("File validation successful.")

    # ========================================================
    # STEP 2 — EXTRACT METADATA
    # ========================================================

    print("\n[2] Extracting file metadata...")

    metadata = get_file_metadata(FILE_PATH)

    print(f"File Name    : {metadata['file_name']}")
    print(f"File Type    : {metadata['file_type']}")
    print(f"File Size    : {metadata['file_size_bytes']} bytes")
    print(f"SHA-256      : {metadata['file_hash']}")

    # ========================================================
    # STEP 3 — DETECT SCHEMA
    # ========================================================

    print("\n[3] Detecting schema...")

    schema = detect_schema(FILE_PATH)

    print(f"Record Count : {schema['record_count']}")
    print(f"Column Count : {schema['column_count']}")

    # ========================================================
    # STEP 4 — CONNECT SQL SERVER
    # ========================================================

    print("\n[4] Connecting to SQL Server...")

    connection = get_connection()

    print("SQL Server connection successful.")

    # ========================================================
    # STEP 5 — REGISTER DATASOURCE
    # ========================================================

    print("\n[5] Registering DataSource...")

    source_id = get_or_create_datasource(
        connection=connection,
        source_name="Customer CSV Source",
        source_type="CSV",
        description="Customer sample CSV data source"
    )

    # ========================================================
    # STEP 6 — REGISTER DATASET
    # ========================================================

    print("\n[6] Registering Dataset...")

    dataset_id = get_or_create_dataset(
        connection=connection,
        source_id=source_id,
        dataset_name="Customer Dataset",
        description="Customer master dataset",
        business_domain="Customer"
    )

    # ========================================================
    # STEP 7 — CREATE DATASET VERSION
    # ========================================================

    print("\n[7] Creating Dataset Version...")

    version_id = create_dataset_version(
        connection=connection,
        dataset_id=dataset_id,
        file_name=metadata["file_name"],
        file_size_bytes=metadata["file_size_bytes"],
        record_count=schema["record_count"],
        schema_hash=metadata["file_hash"]
    )

    # ========================================================
    # STEP 8 — REGISTER COLUMNS
    # ========================================================

    print("\n[8] Registering Dataset Columns...")

    register_dataset_columns(
        connection=connection,
        version_id=version_id,
        columns=schema["columns"]
    )

    # ========================================================
    # CLOSE CONNECTION
    # ========================================================

    connection.close()

    print("\n" + "=" * 70)
    print("DAY 5 METADATA INGESTION COMPLETED SUCCESSFULLY")
    print("=" * 70)


if __name__ == "__main__":
    main()