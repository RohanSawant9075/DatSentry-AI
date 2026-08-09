USE DataSentryAI;
GO

IF OBJECT_ID(N'warehouse.FactRuleExecution', N'U') IS NULL
BEGIN
    CREATE TABLE warehouse.FactRuleExecution
    (
        RuleExecutionFactKey BIGINT IDENTITY(1,1) NOT NULL,

        DateKey INT NOT NULL,

        DatasetKey INT NOT NULL,

        RuleKey BIGINT NOT NULL,

        ExecutionID BIGINT NOT NULL,

        TotalRecords BIGINT NOT NULL,

        PassedRecords BIGINT NOT NULL,

        FailedRecords BIGINT NOT NULL,

        PassPercentage DECIMAL(5,2) NULL,

        CONSTRAINT PK_FactRuleExecution
            PRIMARY KEY (RuleExecutionFactKey),

        CONSTRAINT FK_FactRuleExecution_Date
            FOREIGN KEY (DateKey)
            REFERENCES warehouse.DimDate(DateKey),

        CONSTRAINT FK_FactRuleExecution_Dataset
            FOREIGN KEY (DatasetKey)
            REFERENCES warehouse.DimDataset(DatasetKey),

        CONSTRAINT FK_FactRuleExecution_Rule
            FOREIGN KEY (RuleKey)
            REFERENCES warehouse.DimRule(RuleKey),

        CONSTRAINT FK_FactRuleExecution_Execution
            FOREIGN KEY (ExecutionID)
            REFERENCES quality.RuleExecutions(ExecutionID)
    );
END;
GO