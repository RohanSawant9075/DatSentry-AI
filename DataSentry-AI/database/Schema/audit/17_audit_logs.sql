USE DataSentryAI;
GO

IF OBJECT_ID(N'audit.AuditLogs', N'U') IS NULL
BEGIN
    CREATE TABLE audit.AuditLogs
    (
        AuditID BIGINT IDENTITY(1,1) NOT NULL,

        UserID INT NULL,

        Action VARCHAR(100) NOT NULL,

        EntityName VARCHAR(150) NOT NULL,

        EntityID VARCHAR(100) NULL,

        OldValue VARCHAR(MAX) NULL,

        NewValue VARCHAR(MAX) NULL,

        IPAddress VARCHAR(45) NULL,

        UserAgent VARCHAR(500) NULL,

        CreatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_AuditLogs_CreatedAt
            DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_AuditLogs
            PRIMARY KEY (AuditID),

        CONSTRAINT FK_AuditLogs_User
            FOREIGN KEY (UserID)
            REFERENCES security.Users(UserID)
    );
END;
GO