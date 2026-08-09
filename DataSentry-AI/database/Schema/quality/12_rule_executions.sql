USE DataSentryAI;
GO

IF OBJECT_ID(N'quality.RuleExecutions', N'U') IS NULL
BEGIN
    CREATE TABLE quality.RuleExecutions
    (
        ExecutionID BIGINT IDENTITY(1,1) NOT NULL,

        RuleID BIGINT NOT NULL,

        VersionID BIGINT NOT NULL,

        ExecutionStartedAt DATETIME2 NOT NULL,

        ExecutionCompletedAt DATETIME2 NULL,

        TotalRecords BIGINT NOT NULL
            CONSTRAINT DF_RuleExecutions_TotalRecords
            DEFAULT 0,

        PassedRecords BIGINT NOT NULL
            CONSTRAINT DF_RuleExecutions_PassedRecords
            DEFAULT 0,

        FailedRecords BIGINT NOT NULL
            CONSTRAINT DF_RuleExecutions_FailedRecords
            DEFAULT 0,

        PassPercentage DECIMAL(5,2) NULL,

        Status VARCHAR(50) NOT NULL,

        ErrorMessage VARCHAR(MAX) NULL,

        CONSTRAINT PK_RuleExecutions
            PRIMARY KEY (ExecutionID),

        CONSTRAINT FK_RuleExecutions_Rule
            FOREIGN KEY (RuleID)
            REFERENCES quality.QualityRules(RuleID),

        CONSTRAINT FK_RuleExecutions_Version
            FOREIGN KEY (VersionID)
            REFERENCES core.DatasetVersions(VersionID)
    );
END;
GO