USE DataSentryAI;
GO

IF OBJECT_ID(N'quality.QualityScores', N'U') IS NULL
BEGIN
    CREATE TABLE quality.QualityScores
    (
        ScoreID BIGINT IDENTITY(1,1) NOT NULL,

        VersionID BIGINT NOT NULL,

        CompletenessScore DECIMAL(5,2) NOT NULL,

        AccuracyScore DECIMAL(5,2) NOT NULL,

        ConsistencyScore DECIMAL(5,2) NOT NULL,

        UniquenessScore DECIMAL(5,2) NOT NULL,

        ValidityScore DECIMAL(5,2) NOT NULL,

        TimelinessScore DECIMAL(5,2) NOT NULL,

        OverallScore DECIMAL(5,2) NOT NULL,

        RiskLevel VARCHAR(20) NOT NULL,

        CalculatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_QualityScores_CalculatedAt
            DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_QualityScores
            PRIMARY KEY (ScoreID),

        CONSTRAINT FK_QualityScores_Version
            FOREIGN KEY (VersionID)
            REFERENCES core.DatasetVersions(VersionID),

        CONSTRAINT UQ_QualityScores_Version
            UNIQUE (VersionID),

        CONSTRAINT CK_QualityScores_Range
            CHECK
            (
                CompletenessScore BETWEEN 0 AND 100
                AND AccuracyScore BETWEEN 0 AND 100
                AND ConsistencyScore BETWEEN 0 AND 100
                AND UniquenessScore BETWEEN 0 AND 100
                AND ValidityScore BETWEEN 0 AND 100
                AND TimelinessScore BETWEEN 0 AND 100
                AND OverallScore BETWEEN 0 AND 100
            )
    );
END;
GO