USE DataSentryAI;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = N'security'
)
BEGIN
    EXEC(N'CREATE SCHEMA security');
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = N'core'
)
BEGIN
    EXEC(N'CREATE SCHEMA core');
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = N'ingestion'
)
BEGIN
    EXEC(N'CREATE SCHEMA ingestion');
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = N'quality'
)
BEGIN
    EXEC(N'CREATE SCHEMA quality');
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = N'audit'
)
BEGIN
    EXEC(N'CREATE SCHEMA audit');
END;
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.schemas
    WHERE name = N'warehouse'
)
BEGIN
    EXEC(N'CREATE SCHEMA warehouse');
END;
GO