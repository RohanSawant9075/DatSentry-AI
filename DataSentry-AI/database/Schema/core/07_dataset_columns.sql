USE DataSentryAI;
GO

IF OBJECT_ID(N'core.DatasetColumns', N'U') IS NULL
BEGIN
    CREATE TABLE core.DatasetColumns
    (
        ColumnID BIGINT IDENTITY(1,1) NOT NULL,

        VersionID BIGINT NOT NULL,

        ColumnName VARCHAR(255) NOT NULL,

        DataType VARCHAR(100) NOT NULL,

        IsNullable BIT NOT NULL
            CONSTRAINT DF_DatasetColumns_IsNullable
            DEFAULT 1,

        OrdinalPosition INT NOT NULL,

        IsPrimaryKeyCandidate BIT NOT NULL
            CONSTRAINT DF_DatasetColumns_IsPKCandidate
            DEFAULT 0,

        Description VARCHAR(500) NULL,

        CreatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_DatasetColumns_CreatedAt
            DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_DatasetColumns
            PRIMARY KEY (ColumnID),

        CONSTRAINT FK_DatasetColumns_Version
            FOREIGN KEY (VersionID)
            REFERENCES core.DatasetVersions(VersionID),

        CONSTRAINT UQ_DatasetColumns
            UNIQUE (VersionID, ColumnName)
    );
END;
GO