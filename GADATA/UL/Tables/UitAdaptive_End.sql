CREATE TABLE [UL].[UitAdaptive_End] (
    [id]          INT            IDENTITY (1, 1) NOT NULL,
    [spotid]      INT            NOT NULL,
    [Timerid]     INT            NOT NULL,
    [Text]        NCHAR (20)     NOT NULL,
    [DurationOFF] TIME (7)       NULL,
    [starttime]   DATETIME       NULL,
    [WMComment]   NVARCHAR (MAX) NULL,
    [EndTime]     DATETIME       NULL,
    CONSTRAINT [PK_UitAdaptive_End] PRIMARY KEY CLUSTERED ([id] ASC)
);

