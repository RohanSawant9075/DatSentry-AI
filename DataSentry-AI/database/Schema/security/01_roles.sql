USE DataSentryAI;
GO

IF OBJECT_ID(N'security.Roles', N'U') IS NULL
BEGIN
    CREATE TABLE security.Roles
    (
        RoleID INT IDENTITY(1,1) NOT NULL,

        RoleName VARCHAR(50) NOT NULL,

        Description VARCHAR(255) NULL,

        CreatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_Roles_CreatedAt
            DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_Roles
            PRIMARY KEY (RoleID),

        CONSTRAINT UQ_Roles_RoleName
            UNIQUE (RoleName)
    );
END;
GO