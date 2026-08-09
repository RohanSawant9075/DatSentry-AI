USE DataSentryAI;
GO

IF OBJECT_ID(N'quality.AnomalyResults', N'U') IS NULL
BEGIN
    CREATE TABLE quality.AnomalyResults
    (
        AnomalyID BIGINT IDENTITY(1,1) NOT NULL,

        VersionID BIGINT NOT NULL,

        ColumnID BIGINT NULL,

        RecordIdentifier VARCHAR(255) NULL,

        AnomalyType VARCHAR(100) NOT NULL,

        AnomalyScore DECIMAL(10,6) NOT NULL,

        ModelName VARCHAR(100) NOT NULL,

        ModelVersion VARCHAR(50) NULL,

        Prediction VARCHAR(50) NULL,

        DetectedAt DATETIME2 NOT NULL
            CONSTRAINT DF_AnomalyResults_DetectedAt
            DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_AnomalyResults
            PRIMARY KEY (AnomalyID),

        CONSTRAINT FK_AnomalyResults_Version
            FOREIGN KEY (VersionID)
            REFERENCES core.DatasetVersions(VersionID),

        CONSTRAINT FK_AnomalyResults_Column
            FOREIGN KEY (ColumnID)
            REFERENCES core.DatasetColumns(ColumnID)
    );
END;
GO