CREATE TABLE [Alerts].[c_CPT600] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [Discription]  VARCHAR (MAX) NULL,
    [System]       VARCHAR (50)  NOT NULL,
    [LocationTree] VARCHAR (MAX) NULL,
    [AssetRoot]    VARCHAR (MAX) NULL,
    [ActivePloeg]  VARCHAR (50)  NULL,
    [StartTime]    TIME (7)      NULL,
    [EndTime]      TIME (7)      NULL,
    [SMSlimit]     INT           NULL,
    [SMSsend]      INT           NULL,
    CONSTRAINT [PK_c_CPT600] PRIMARY KEY CLUSTERED ([id] ASC)
);

