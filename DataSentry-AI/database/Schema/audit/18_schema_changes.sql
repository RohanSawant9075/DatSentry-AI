USE DataSentryAI;
GO

IF OBJECT_ID(N'audit.SchemaChanges', N'U') IS NULL
BEGIN
    CREATE TABLE audit.SchemaChanges
    (
        ChangeID BIGINT IDENTITY(1,1) NOT NULL,

        DatasetID INT NOT NULL,

        VersionID BIGINT NOT NULL,

        ColumnName VARCHAR(255) NOT NULL,

        ChangeType VARCHAR(100) NOT NULL,

        OldDataType VARCHAR(100) NULL,

        NewDataType VARCHAR(100) NULL,

        OldColumnPosition INT NULL,

        NewColumnPosition INT NULL,

        DetectedAt DATETIME2 NOT NULL
            CONSTRAINT DF_SchemaChanges_DetectedAt
            DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_SchemaChanges
            PRIMARY KEY (ChangeID),

        CONSTRAINT FK_SchemaChanges_Dataset
            FOREIGN KEY (DatasetID)
            REFERENCES core.Datasets(DatasetID),

        CONSTRAINT FK_SchemaChanges_Version
            FOREIGN KEY (VersionID)
            REFERENCES core.DatasetVersions(VersionID)
    );
END;
GO