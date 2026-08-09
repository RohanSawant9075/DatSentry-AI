USE DataSentryAI;
GO

IF OBJECT_ID(N'core.DatasetVersions', N'U') IS NULL
BEGIN
    CREATE TABLE core.DatasetVersions
    (
        VersionID BIGINT IDENTITY(1,1) NOT NULL,

        DatasetID INT NOT NULL,

        VersionNumber INT NOT NULL,

        FileName VARCHAR(255) NULL,

        FileSizeBytes BIGINT NULL,

        RecordCount BIGINT NULL,

        SchemaHash VARCHAR(128) NULL,

        Status VARCHAR(50) NOT NULL,

        UploadedBy INT NULL,

        UploadedAt DATETIME2 NOT NULL
            CONSTRAINT DF_DatasetVersions_UploadedAt
            DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_DatasetVersions
            PRIMARY KEY (VersionID),

        CONSTRAINT FK_DatasetVersions_Dataset
            FOREIGN KEY (DatasetID)
            REFERENCES core.Datasets(DatasetID),

        CONSTRAINT FK_DatasetVersions_User
            FOREIGN KEY (UploadedBy)
            REFERENCES security.Users(UserID),

        CONSTRAINT UQ_DatasetVersions
            UNIQUE (DatasetID, VersionNumber)
    );
END;
GO