USE DataSentryAI;
GO

IF OBJECT_ID(N'warehouse.FactAnomaly', N'U') IS NULL
BEGIN
    CREATE TABLE warehouse.FactAnomaly
    (
        AnomalyFactKey BIGINT IDENTITY(1,1) NOT NULL,

        DateKey INT NOT NULL,

        DatasetKey INT NOT NULL,

        AnomalyID BIGINT NOT NULL,

        AnomalyScore DECIMAL(10,6) NOT NULL,

        AnomalyCount INT NOT NULL
            CONSTRAINT DF_FactAnomaly_AnomalyCount
            DEFAULT 1,

        CONSTRAINT PK_FactAnomaly
            PRIMARY KEY (AnomalyFactKey),

        CONSTRAINT FK_FactAnomaly_Date
            FOREIGN KEY (DateKey)
            REFERENCES warehouse.DimDate(DateKey),

        CONSTRAINT FK_FactAnomaly_Dataset
            FOREIGN KEY (DatasetKey)
            REFERENCES warehouse.DimDataset(DatasetKey),

        CONSTRAINT FK_FactAnomaly_Anomaly
            FOREIGN KEY (AnomalyID)
            REFERENCES quality.AnomalyResults(AnomalyID)
    );
END;
GO