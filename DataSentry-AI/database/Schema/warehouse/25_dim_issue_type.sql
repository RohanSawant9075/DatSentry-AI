USE DataSentryAI;
GO

IF OBJECT_ID(N'warehouse.DimIssueType', N'U') IS NULL
BEGIN
    CREATE TABLE warehouse.DimIssueType
    (
        IssueTypeKey INT IDENTITY(1,1) NOT NULL,

        IssueType VARCHAR(100) NOT NULL,

        Description VARCHAR(500) NULL,

        CONSTRAINT PK_DimIssueType
            PRIMARY KEY (IssueTypeKey),

        CONSTRAINT UQ_DimIssueType
            UNIQUE (IssueType)
    );
END;
GO