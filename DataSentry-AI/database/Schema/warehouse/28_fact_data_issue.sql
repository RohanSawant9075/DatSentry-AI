USE DataSentryAI;
GO

IF OBJECT_ID(N'warehouse.FactDataIssue', N'U') IS NULL
BEGIN
    CREATE TABLE warehouse.FactDataIssue
    (
        DataIssueFactKey BIGINT IDENTITY(1,1) NOT NULL,

        DateKey INT NOT NULL,

        DatasetKey INT NOT NULL,

        IssueTypeKey INT NOT NULL,

        IssueID BIGINT NOT NULL,

        Severity VARCHAR(20) NOT NULL,

        ResolutionStatus VARCHAR(30) NOT NULL,

        IssueCount INT NOT NULL
            CONSTRAINT DF_FactDataIssue_IssueCount
            DEFAULT 1,

        CONSTRAINT PK_FactDataIssue
            PRIMARY KEY (DataIssueFactKey),

        CONSTRAINT FK_FactDataIssue_Date
            FOREIGN KEY (DateKey)
            REFERENCES warehouse.DimDate(DateKey),

        CONSTRAINT FK_FactDataIssue_Dataset
            FOREIGN KEY (DatasetKey)
            REFERENCES warehouse.DimDataset(DatasetKey),

        CONSTRAINT FK_FactDataIssue_Type
            FOREIGN KEY (IssueTypeKey)
            REFERENCES warehouse.DimIssueType(IssueTypeKey),

        CONSTRAINT FK_FactDataIssue_Issue
            FOREIGN KEY (IssueID)
            REFERENCES quality.QualityIssues(IssueID)
    );
END;
GO