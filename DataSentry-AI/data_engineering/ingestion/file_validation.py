from pathlib import Path


# ============================================================
# ALLOWED FILE TYPES
# ============================================================

ALLOWED_EXTENSIONS = {
    ".csv"
}


# ============================================================
# FILE VALIDATION
# ============================================================

def validate_file(file_path: str) -> bool:
    """
    Validate whether the input dataset file exists,
    is a file, has a supported extension, and is not empty.
    """

    path = Path(file_path)

    # --------------------------------------------------------
    # Check file exists
    # --------------------------------------------------------

    if not path.exists():
        raise FileNotFoundError(
            f"File does not exist: {path}"
        )

    # --------------------------------------------------------
    # Check path is actually a file
    # --------------------------------------------------------

    if not path.is_file():
        raise ValueError(
            f"Path is not a file: {path}"
        )

    # --------------------------------------------------------
    # Check extension
    # --------------------------------------------------------

    if path.suffix.lower() not in ALLOWED_EXTENSIONS:
        raise ValueError(
            f"Unsupported file type: {path.suffix}"
        )

    # --------------------------------------------------------
    # Check empty file
    # --------------------------------------------------------

    if path.stat().st_size == 0:
        raise ValueError(
            "File is empty."
        )

    return True