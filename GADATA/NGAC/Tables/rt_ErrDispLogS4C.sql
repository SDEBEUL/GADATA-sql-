CREATE TABLE [NGAC].[rt_ErrDispLogS4C] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]     DATETIME      NULL,
    [rt_csv_file_id] INT           NULL,
    [Date Time]      DATETIME      NULL,
    [AlarmNo]        VARCHAR (MAX) NULL,
    [Txt 1]          VARCHAR (MAX) NULL,
    [Txt 2]          VARCHAR (MAX) NULL,
    [Txt 3]          VARCHAR (MAX) NULL,
    [Txt 4]          VARCHAR (MAX) NULL,
    [Txt 5]          VARCHAR (MAX) NULL,
    [Txt 6]          VARCHAR (MAX) NULL,
    [Txt 7]          VARCHAR (MAX) NULL,
    [Txt 8]          VARCHAR (MAX) NULL,
    [Txt 9]          VARCHAR (MAX) NULL,
    [Txt 10]         VARCHAR (MAX) NULL,
    [Txt 11]         VARCHAR (MAX) NULL,
    [Action]         VARCHAR (MAX) NULL,
    [Prg Nr]         VARCHAR (MAX) NULL,
    [Breaktimestamp] DATETIME      NULL,
    [Break Time]     VARCHAR (MAX) NULL
);

