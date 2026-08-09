USE DataSentryAI;
GO

IF OBJECT_ID(N'warehouse.DimSource', N'U') IS NULL
BEGIN
    CREATE TABLE warehouse.DimSource
    (
        SourceKey INT IDENTITY(1,1) NOT NULL,

        SourceID INT NOT NULL,

        SourceName VARCHAR(150) NOT NULL,

        SourceType VARCHAR(50) NOT NULL,

        CONSTRAINT PK_DimSource
            PRIMARY KEY (SourceKey),

        CONSTRAINT UQ_DimSource_SourceID
            UNIQUE (SourceID)
    );
END;
GO