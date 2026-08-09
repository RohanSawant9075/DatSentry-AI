USE DataSentryAI;
GO

IF OBJECT_ID(N'security.Users', N'U') IS NULL
BEGIN
    CREATE TABLE security.Users
    (
        UserID INT IDENTITY(1,1) NOT NULL,

        UserName VARCHAR(100) NOT NULL,

        Email VARCHAR(255) NOT NULL,

        PasswordHash VARCHAR(500) NOT NULL,

        IsActive BIT NOT NULL
            CONSTRAINT DF_Users_IsActive
            DEFAULT 1,

        CreatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_Users_CreatedAt
            DEFAULT SYSUTCDATETIME(),

        LastLoginAt DATETIME2 NULL,

        CONSTRAINT PK_Users
            PRIMARY KEY (UserID),

        CONSTRAINT UQ_Users_UserName
            UNIQUE (UserName),

        CONSTRAINT UQ_Users_Email
            UNIQUE (Email)
    );
END;
GO