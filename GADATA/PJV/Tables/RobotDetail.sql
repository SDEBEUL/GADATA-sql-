CREATE TABLE [PJV].[RobotDetail] (
    [id]             INT          IDENTITY (1, 1) NOT NULL,
    [name]           VARCHAR (50) NULL,
    [robotSupplier]  VARCHAR (10) NULL,
    [isDead]         INT          NULL,
    [_timestamp]     DATETIME     NULL,
    [_lasttimestamp] DATETIME     NULL,
    [rev_created]    INT          NULL,
    [rev_modified]   INT          NULL,
    CONSTRAINT [PK_RobotDetail] PRIMARY KEY CLUSTERED ([id] ASC)
);

