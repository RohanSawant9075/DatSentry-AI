import pyodbc

from .config import (
    DB_SERVER,
    DB_NAME,
    DB_DRIVER,
    DB_TRUSTED_CONNECTION,
    DB_TRUST_SERVER_CERTIFICATE,
)


def get_connection():

    connection_string = (
        f"DRIVER={{{DB_DRIVER}}};"
        f"SERVER={DB_SERVER};"
        f"DATABASE={DB_NAME};"
        f"Trusted_Connection={DB_TRUSTED_CONNECTION};"
        f"TrustServerCertificate={DB_TRUST_SERVER_CERTIFICATE};"
    )

    return pyodbc.connect(connection_string)