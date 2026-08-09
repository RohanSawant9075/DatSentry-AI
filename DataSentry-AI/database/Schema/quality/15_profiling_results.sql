USE DataSentryAI;
GO

IF OBJECT_ID(N'quality.ProfilingResults', N'U') IS NULL
BEGIN
    CREATE TABLE quality.ProfilingResults
    (
        ProfileID BIGINT IDENTITY(1,1) NOT NULL,

        VersionID BIGINT NOT NULL,

        ColumnID BIGINT NOT NULL,

        TotalRecords BIGINT NOT NULL
            CONSTRAINT DF_ProfilingResults_TotalRecords
            DEFAULT 0,

        NullCount BIGINT NOT NULL
            CONSTRAINT DF_ProfilingResults_NullCount
            DEFAULT 0,

        UniqueCount BIGINT NOT NULL
            CONSTRAINT DF_ProfilingResults_UniqueCount
            DEFAULT 0,

        DuplicateCount BIGINT NOT NULL
            CONSTRAINT DF_ProfilingResults_DuplicateCount
            DEFAULT 0,

        MinimumValue VARCHAR(500) NULL,

        MaximumValue VARCHAR(500) NULL,

        MeanValue DECIMAL(38,10) NULL,

        MedianValue DECIMAL(38,10) NULL,

        StandardDeviation DECIMAL(38,10) NULL,

        ProfiledAt DATETIME2 NOT NULL
            CONSTRAINT DF_ProfilingResults_ProfiledAt
            DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_ProfilingResults
            PRIMARY KEY (ProfileID),

        CONSTRAINT FK_ProfilingResults_Version
            FOREIGN KEY (VersionID)
            REFERENCES core.DatasetVersions(VersionID),

        CONSTRAINT FK_ProfilingResults_Column
            FOREIGN KEY (ColumnID)
            REFERENCES core.DatasetColumns(ColumnID)
    );
END;
GO