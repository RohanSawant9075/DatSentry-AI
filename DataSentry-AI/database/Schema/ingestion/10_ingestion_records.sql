USE DataSentryAI;
GO

IF OBJECT_ID(N'ingestion.IngestionRecords', N'U') IS NULL
BEGIN
    CREATE TABLE ingestion.IngestionRecords
    (
        IngestionRecordID BIGINT IDENTITY(1,1) NOT NULL,

        JobID BIGINT NOT NULL,

        FileID BIGINT NULL,

        SourceRecordIdentifier VARCHAR(255) NULL,

        ProcessingStatus VARCHAR(50) NOT NULL,

        RejectionReason VARCHAR(1000) NULL,

        ProcessedAt DATETIME2 NOT NULL
            CONSTRAINT DF_IngestionRecords_ProcessedAt
            DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_IngestionRecords
            PRIMARY KEY (IngestionRecordID),

        CONSTRAINT FK_IngestionRecords_Job
            FOREIGN KEY (JobID)
            REFERENCES ingestion.IngestionJobs(JobID),

        CONSTRAINT FK_IngestionRecords_File
            FOREIGN KEY (FileID)
            REFERENCES ingestion.IngestionFiles(FileID)
    );
END;
GO