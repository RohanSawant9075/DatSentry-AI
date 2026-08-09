USE DataSentryAI;
GO

IF OBJECT_ID(N'quality.QualityRules', N'U') IS NULL
BEGIN
    CREATE TABLE quality.QualityRules
    (
        RuleID BIGINT IDENTITY(1,1) NOT NULL,

        DatasetID INT NOT NULL,

        ColumnID BIGINT NULL,

        RuleName VARCHAR(150) NOT NULL,

        RuleCode VARCHAR(50) NOT NULL,

        RuleType VARCHAR(50) NOT NULL,

        QualityDimension VARCHAR(50) NOT NULL,

        RuleExpression VARCHAR(MAX) NULL,

        Severity VARCHAR(20) NOT NULL,

        IsActive BIT NOT NULL
            CONSTRAINT DF_QualityRules_IsActive
            DEFAULT 1,

        CreatedBy INT NULL,

        CreatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_QualityRules_CreatedAt
            DEFAULT SYSUTCDATETIME(),

        UpdatedAt DATETIME2 NULL,

        CONSTRAINT PK_QualityRules
            PRIMARY KEY (RuleID),

        CONSTRAINT FK_QualityRules_Dataset
            FOREIGN KEY (DatasetID)
            REFERENCES core.Datasets(DatasetID),

        CONSTRAINT FK_QualityRules_Column
            FOREIGN KEY (ColumnID)
            REFERENCES core.DatasetColumns(ColumnID),

        CONSTRAINT FK_QualityRules_User
            FOREIGN KEY (CreatedBy)
            REFERENCES security.Users(UserID),

        CONSTRAINT UQ_QualityRules_Code
            UNIQUE (RuleCode)
    );
END;
GO