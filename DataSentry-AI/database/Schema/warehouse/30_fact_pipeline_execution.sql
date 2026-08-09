USE DataSentryAI;
GO

IF OBJECT_ID(N'warehouse.FactPipelineExecution', N'U') IS NULL
BEGIN
    CREATE TABLE warehouse.FactPipelineExecution
    (
        PipelineExecutionFactKey BIGINT IDENTITY(1,1) NOT NULL,

        DateKey INT NOT NULL,

        DatasetKey INT NOT NULL,

        JobID BIGINT NOT NULL,

        PipelineLogID BIGINT NOT NULL,

        RecordsProcessed BIGINT NOT NULL,

        ExecutionDurationSeconds BIGINT NULL,

        Status VARCHAR(50) NOT NULL,

        CONSTRAINT PK_FactPipelineExecution
            PRIMARY KEY (PipelineExecutionFactKey),

        CONSTRAINT FK_FactPipelineExecution_Date
            FOREIGN KEY (DateKey)
            REFERENCES warehouse.DimDate(DateKey),

        CONSTRAINT FK_FactPipelineExecution_Dataset
            FOREIGN KEY (DatasetKey)
            REFERENCES warehouse.DimDataset(DatasetKey),

        CONSTRAINT FK_FactPipelineExecution_Job
            FOREIGN KEY (JobID)
            REFERENCES ingestion.IngestionJobs(JobID),

        CONSTRAINT FK_FactPipelineExecution_Log
            FOREIGN KEY (PipelineLogID)
            REFERENCES audit.PipelineLogs(PipelineLogID)
    );
END;
GO