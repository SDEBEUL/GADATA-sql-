CREATE TABLE [C3G].[GunCylinderefernce] (
    [Controller_id] INT        NULL,
    [tool_id]       TINYINT    NULL,
    [SampleStart]   DATETIME   NULL,
    [nDataPoints]   INT        NULL,
    [avg]           FLOAT (53) NULL,
    [Max]           FLOAT (53) NULL,
    [Min]           FLOAT (53) NULL,
    [Stdev]         FLOAT (53) NULL,
    [UCL]           FLOAT (53) NULL,
    [LCL]           FLOAT (53) NULL,
    CONSTRAINT [FK_GunCylinderefernce_c_controller] FOREIGN KEY ([Controller_id]) REFERENCES [C3G].[c_controller] ([id])
);

