USE DataSentryAI;
GO

IF OBJECT_ID(N'warehouse.DimDate', N'U') IS NULL
BEGIN
    CREATE TABLE warehouse.DimDate
    (
        DateKey INT NOT NULL,

        FullDate DATE NOT NULL,

        DayNumber INT NOT NULL,

        MonthNumber INT NOT NULL,

        MonthName VARCHAR(20) NOT NULL,

        QuarterNumber INT NOT NULL,

        YearNumber INT NOT NULL,

        WeekNumber INT NOT NULL,

        DayOfWeekNumber INT NOT NULL,

        DayOfWeekName VARCHAR(20) NOT NULL,

        IsWeekend BIT NOT NULL,

        CONSTRAINT PK_DimDate
            PRIMARY KEY (DateKey),

        CONSTRAINT UQ_DimDate_FullDate
            UNIQUE (FullDate)
    );
END;
GO