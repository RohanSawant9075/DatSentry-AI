USE DataSentryAI;
GO

IF OBJECT_ID(N'core.Datasets', N'U') IS NULL
BEGIN
    CREATE TABLE core.Datasets
    (
        DatasetID INT IDENTITY(1,1) NOT NULL,

        SourceID INT NOT NULL,

        DatasetName VARCHAR(150) NOT NULL,

        Description VARCHAR(500) NULL,

        BusinessDomain VARCHAR(100) NULL,

        OwnerUserID INT NULL,

        CreatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_Datasets_CreatedAt
            DEFAULT SYSUTCDATETIME(),

        UpdatedAt DATETIME2 NULL,

        CONSTRAINT PK_Datasets
            PRIMARY KEY (DatasetID),

        CONSTRAINT FK_Datasets_Source
            FOREIGN KEY (SourceID)
            REFERENCES core.DataSources(SourceID),

        CONSTRAINT FK_Datasets_Owner
            FOREIGN KEY (OwnerUserID)
            REFERENCES security.Users(UserID),

        CONSTRAINT UQ_Datasets_Name
            UNIQUE (SourceID, DatasetName)
    );
END;
GO