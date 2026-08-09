USE DataSentryAI;
GO

IF OBJECT_ID(N'core.DataSources', N'U') IS NULL
BEGIN
    CREATE TABLE core.DataSources
    (
        SourceID INT IDENTITY(1,1) NOT NULL,

        SourceName VARCHAR(150) NOT NULL,

        SourceType VARCHAR(50) NOT NULL,

        Description VARCHAR(500) NULL,

        OwnerUserID INT NULL,

        IsActive BIT NOT NULL
            CONSTRAINT DF_DataSources_IsActive
            DEFAULT 1,

        CreatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_DataSources_CreatedAt
            DEFAULT SYSUTCDATETIME(),

        UpdatedAt DATETIME2 NULL,

        CONSTRAINT PK_DataSources
            PRIMARY KEY (SourceID),

        CONSTRAINT UQ_DataSources_SourceName
            UNIQUE (SourceName),

        CONSTRAINT FK_DataSources_Owner
            FOREIGN KEY (OwnerUserID)
            REFERENCES security.Users(UserID)
    );
END;
GO