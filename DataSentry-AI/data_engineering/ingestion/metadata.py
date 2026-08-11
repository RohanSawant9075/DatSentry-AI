from pathlib import Path
import hashlib


# ============================================================
# FILE SIZE
# ============================================================

def get_file_size(file_path: str) -> int:
    """
    Return file size in bytes.
    """

    return Path(file_path).stat().st_size


# ============================================================
# SHA-256 HASH
# ============================================================

def calculate_file_hash(file_path: str) -> str:
    """
    Calculate SHA-256 hash of a file.

    This helps identify duplicate or previously
    processed files.
    """

    sha256 = hashlib.sha256()

    with open(file_path, "rb") as file:

        while True:

            chunk = file.read(8192)

            if not chunk:
                break

            sha256.update(chunk)

    return sha256.hexdigest()


# ============================================================
# COMPLETE FILE METADATA
# ============================================================

def get_file_metadata(file_path: str) -> dict:
    """
    Return metadata about the dataset file.
    """

    path = Path(file_path)

    return {
        "file_name": path.name,
        "file_type": path.suffix.lower().replace(".", ""),
        "file_size_bytes": get_file_size(file_path),
        "file_hash": calculate_file_hash(file_path),
    }