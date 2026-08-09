USE DataSentryAI;
GO

IF OBJECT_ID(N'warehouse.DimDataset', N'U') IS NULL
BEGIN
    CREATE TABLE warehouse.DimDataset
    (
        DatasetKey INT IDENTITY(1,1) NOT NULL,

        DatasetID INT NOT NULL,

        DatasetName VARCHAR(150) NOT NULL,

        BusinessDomain VARCHAR(100) NULL,

        SourceID INT NULL,

        EffectiveFrom DATETIME2 NOT NULL
            CONSTRAINT DF_DimDataset_EffectiveFrom
            DEFAULT SYSUTCDATETIME(),

        EffectiveTo DATETIME2 NULL,

        IsCurrent BIT NOT NULL
            CONSTRAINT DF_DimDataset_IsCurrent
            DEFAULT 1,

        CONSTRAINT PK_DimDataset
            PRIMARY KEY (DatasetKey),

        CONSTRAINT UQ_DimDataset_DatasetID
            UNIQUE (DatasetID)
    );
END;
GO