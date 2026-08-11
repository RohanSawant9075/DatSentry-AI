import os
from pathlib import Path

from dotenv import load_dotenv


PROJECT_ROOT = Path(__file__).resolve().parents[2]

load_dotenv(PROJECT_ROOT / ".env")


DB_SERVER = os.getenv("DB_SERVER")

DB_NAME = os.getenv("DB_NAME")

DB_DRIVER = os.getenv("DB_DRIVER")

DB_TRUSTED_CONNECTION = os.getenv(
    "DB_TRUSTED_CONNECTION",
    "yes"
)

DB_TRUST_SERVER_CERTIFICATE = os.getenv(
    "DB_TRUST_SERVER_CERTIFICATE",
    "yes"
)


RAW_DATA_DIR = PROJECT_ROOT / "data" / "raw"

PROCESSED_DATA_DIR = PROJECT_ROOT / "data" / "processed"

REJECTED_DATA_DIR = PROJECT_ROOT / "data" / "rejected"

SAMPLE_DATA_DIR = PROJECT_ROOT / "data" / "sample"