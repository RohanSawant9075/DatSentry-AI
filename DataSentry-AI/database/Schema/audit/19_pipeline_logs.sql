USE DataSentryAI;
GO

IF OBJECT_ID(N'audit.PipelineLogs', N'U') IS NULL
BEGIN
    CREATE TABLE audit.PipelineLogs
    (
        PipelineLogID BIGINT IDENTITY(1,1) NOT NULL,

        JobID BIGINT NOT NULL,

        StageName VARCHAR(100) NOT NULL,

        StartTime DATETIME2 NOT NULL,

        EndTime DATETIME2 NULL,

        Status VARCHAR(50) NOT NULL,

        RecordsProcessed BIGINT NOT NULL
            CONSTRAINT DF_PipelineLogs_RecordsProcessed
            DEFAULT 0,

        ErrorMessage VARCHAR(MAX) NULL,

        CreatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_PipelineLogs_CreatedAt
            DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_PipelineLogs
            PRIMARY KEY (PipelineLogID),

        CONSTRAINT FK_PipelineLogs_Job
            FOREIGN KEY (JobID)
            REFERENCES ingestion.IngestionJobs(JobID)
    );
END;
GO