USE DataSentryAI;
GO

IF OBJECT_ID(N'security.UserRoles', N'U') IS NULL
BEGIN
    CREATE TABLE security.UserRoles
    (
        UserID INT NOT NULL,

        RoleID INT NOT NULL,

        AssignedAt DATETIME2 NOT NULL
            CONSTRAINT DF_UserRoles_AssignedAt
            DEFAULT SYSUTCDATETIME(),

        CONSTRAINT PK_UserRoles
            PRIMARY KEY (UserID, RoleID),

        CONSTRAINT FK_UserRoles_User
            FOREIGN KEY (UserID)
            REFERENCES security.Users(UserID),

        CONSTRAINT FK_UserRoles_Role
            FOREIGN KEY (RoleID)
            REFERENCES security.Roles(RoleID)
    );
END;
GO