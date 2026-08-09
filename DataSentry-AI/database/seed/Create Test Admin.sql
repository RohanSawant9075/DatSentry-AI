IF NOT EXISTS
(
    SELECT 1
    FROM security.Users
    WHERE UserName = 'admin'
)
BEGIN
    INSERT INTO security.Users
    (
        UserName,
        Email,
        PasswordHash
    )
    VALUES
    (
        'admin',
        'admin@datasentry.ai',
        'TEMP_HASH_REPLACE_LATER'
    );
END;
GO