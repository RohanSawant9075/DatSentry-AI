USE DataSentryAI;
GO

IF OBJECT_ID(N'ingestion.IngestionJobs', N'U') IS NULL
BEGIN
    CREATE TABLE ingestion.IngestionJobs
    (
        JobID BIGINT IDENTITY(1,1) NOT NULL,

        DatasetID INT NOT NULL,

        JobType VARCHAR(50) NOT NULL,

        StartedAt DATETIME2 NOT NULL,

        CompletedAt DATETIME2 NULL,

        Status VARCHAR(50) NOT NULL,

        RecordsRead BIGINT NOT NULL
            CONSTRAINT DF_IngestionJobs_RecordsRead
            DEFAULT 0,

        RecordsLoaded BIGINT NOT NULL
            CONSTRAINT DF_IngestionJobs_RecordsLoaded
            DEFAULT 0,

        RecordsRejected BIGINT NOT NULL
            CONSTRAINT DF_IngestionJobs_RecordsRejected
            DEFAULT 0,

        ErrorMessage VARCHAR(MAX) NULL,

        TriggeredBy INT NULL,

        CreatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_IngestionJobs_CreatedAt
            DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_IngestionJobs
            PRIMARY KEY (JobID),

        CONSTRAINT FK_IngestionJobs_Dataset
            FOREIGN KEY (DatasetID)
            REFERENCES core.Datasets(DatasetID),

        CONSTRAINT FK_IngestionJobs_User
            FOREIGN KEY (TriggeredBy)
            REFERENCES security.Users(UserID)
    );
END;
GO