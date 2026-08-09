USE DataSentryAI;
GO

IF OBJECT_ID(N'warehouse.FactDataQuality', N'U') IS NULL
BEGIN
    CREATE TABLE warehouse.FactDataQuality
    (
        DataQualityFactKey BIGINT IDENTITY(1,1) NOT NULL,

        DateKey INT NOT NULL,

        DatasetKey INT NOT NULL,

        SourceKey INT NULL,

        VersionID BIGINT NOT NULL,

        CompletenessScore DECIMAL(5,2) NOT NULL,

        AccuracyScore DECIMAL(5,2) NOT NULL,

        ConsistencyScore DECIMAL(5,2) NOT NULL,

        UniquenessScore DECIMAL(5,2) NOT NULL,

        ValidityScore DECIMAL(5,2) NOT NULL,

        TimelinessScore DECIMAL(5,2) NOT NULL,

        OverallScore DECIMAL(5,2) NOT NULL,

        CONSTRAINT PK_FactDataQuality
            PRIMARY KEY (DataQualityFactKey),

        CONSTRAINT FK_FactDataQuality_Date
            FOREIGN KEY (DateKey)
            REFERENCES warehouse.DimDate(DateKey),

        CONSTRAINT FK_FactDataQuality_Dataset
            FOREIGN KEY (DatasetKey)
            REFERENCES warehouse.DimDataset(DatasetKey),

        CONSTRAINT FK_FactDataQuality_Source
            FOREIGN KEY (SourceKey)
            REFERENCES warehouse.DimSource(SourceKey),

        CONSTRAINT FK_FactDataQuality_Version
            FOREIGN KEY (VersionID)
            REFERENCES core.DatasetVersions(VersionID)
    );
END;
GO