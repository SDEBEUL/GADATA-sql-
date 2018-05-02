CREATE TABLE [C3G].[SBCUrefernce] (
    [Controller_id] INT           NULL,
    [tool_id]       TINYINT       NULL,
    [Longcheck]     BIT           NULL,
    [SampleStart]   DATETIME      NULL,
    [nDataPoints]   INT           NULL,
    [avg]           FLOAT (53)    NULL,
    [Max]           FLOAT (53)    NULL,
    [Min]           FLOAT (53)    NULL,
    [Stdev]         FLOAT (53)    NULL,
    [UCL]           FLOAT (53)    NULL,
    [LCL]           FLOAT (53)    NULL,
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [Variant]       VARCHAR (MAX) NULL,
    [Active]        BIT           NULL,
    [_timestamp]    ROWVERSION    NULL,
    [Comment]       VARCHAR (MAX) NULL,
    CONSTRAINT [PK_SBCUrefernce] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_SBCUrefernce_c_controller] FOREIGN KEY ([Controller_id]) REFERENCES [C3G].[c_controller] ([id])
);



