USE DataSentryAI;
GO

IF OBJECT_ID(N'warehouse.DimUser', N'U') IS NULL
BEGIN
    CREATE TABLE warehouse.DimUser
    (
        UserKey INT IDENTITY(1,1) NOT NULL,

        UserID INT NOT NULL,

        UserName VARCHAR(100) NOT NULL,

        Email VARCHAR(255) NOT NULL,

        CONSTRAINT PK_DimUser
            PRIMARY KEY (UserKey),

        CONSTRAINT UQ_DimUser_UserID
            UNIQUE (UserID)
    );
END;
GO