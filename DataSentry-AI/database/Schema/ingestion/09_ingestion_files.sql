USE DataSentryAI;
GO

IF OBJECT_ID(N'ingestion.IngestionFiles', N'U') IS NULL
BEGIN
    CREATE TABLE ingestion.IngestionFiles
    (
        FileID BIGINT IDENTITY(1,1) NOT NULL,

        JobID BIGINT NOT NULL,

        FileName VARCHAR(255) NOT NULL,

        FilePath VARCHAR(1000) NULL,

        FileType VARCHAR(50) NULL,

        FileSizeBytes BIGINT NULL,

        FileHash VARCHAR(128) NULL,

        ReceivedAt DATETIME2 NOT NULL
            CONSTRAINT DF_IngestionFiles_ReceivedAt
            DEFAULT SYSUTCDATETIME(),

        ProcessedAt DATETIME2 NULL,

        Status VARCHAR(50) NOT NULL,

        CONSTRAINT PK_IngestionFiles
            PRIMARY KEY (FileID),

        CONSTRAINT FK_IngestionFiles_Job
            FOREIGN KEY (JobID)
            REFERENCES ingestion.IngestionJobs(JobID)
    );
END;
GO