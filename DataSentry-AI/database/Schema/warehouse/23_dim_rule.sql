USE DataSentryAI;
GO

IF OBJECT_ID(N'warehouse.DimRule', N'U') IS NULL
BEGIN
    CREATE TABLE warehouse.DimRule
    (
        RuleKey BIGINT IDENTITY(1,1) NOT NULL,

        RuleID BIGINT NOT NULL,

        RuleCode VARCHAR(50) NOT NULL,

        RuleName VARCHAR(150) NOT NULL,

        RuleType VARCHAR(50) NOT NULL,

        QualityDimension VARCHAR(50) NOT NULL,

        Severity VARCHAR(20) NOT NULL,

        CONSTRAINT PK_DimRule
            PRIMARY KEY (RuleKey),

        CONSTRAINT UQ_DimRule_RuleID
            UNIQUE (RuleID)
    );
END;
GO