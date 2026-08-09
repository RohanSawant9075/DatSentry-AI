USE DataSentryAI;
GO

IF OBJECT_ID(N'quality.QualityIssues', N'U') IS NULL
BEGIN
    CREATE TABLE quality.QualityIssues
    (
        IssueID BIGINT IDENTITY(1,1) NOT NULL,

        ExecutionID BIGINT NOT NULL,

        VersionID BIGINT NOT NULL,

        ColumnID BIGINT NULL,

        RecordIdentifier VARCHAR(255) NULL,

        IssueType VARCHAR(100) NOT NULL,

        IssueDescription VARCHAR(1000) NULL,

        Severity VARCHAR(20) NOT NULL,

        ResolutionStatus VARCHAR(30) NOT NULL
            CONSTRAINT DF_QualityIssues_ResolutionStatus
            DEFAULT 'OPEN',

        DetectedAt DATETIME2 NOT NULL
            CONSTRAINT DF_QualityIssues_DetectedAt
            DEFAULT SYSUTCDATETIME(),

        ResolvedAt DATETIME2 NULL,

        ResolvedBy INT NULL,

        CONSTRAINT PK_QualityIssues
            PRIMARY KEY (IssueID),

        CONSTRAINT FK_QualityIssues_Execution
            FOREIGN KEY (ExecutionID)
            REFERENCES quality.RuleExecutions(ExecutionID),

        CONSTRAINT FK_QualityIssues_Version
            FOREIGN KEY (VersionID)
            REFERENCES core.DatasetVersions(VersionID),

        CONSTRAINT FK_QualityIssues_Column
            FOREIGN KEY (ColumnID)
            REFERENCES core.DatasetColumns(ColumnID),

        CONSTRAINT FK_QualityIssues_ResolvedBy
            FOREIGN KEY (ResolvedBy)
            REFERENCES security.Users(UserID)
    );
END;
GO