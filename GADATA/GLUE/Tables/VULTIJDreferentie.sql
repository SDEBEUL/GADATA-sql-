CREATE TABLE [GLUE].[VULTIJDreferentie] (
    [Controller]  VARCHAR (50) NOT NULL,
    [SampleStart] DATETIME     NULL,
    [nDataPoints] INT          NULL,
    [avg]         FLOAT (53)   NULL,
    [Max]         FLOAT (53)   NULL,
    [Min]         FLOAT (53)   NULL,
    [Stdev]       FLOAT (53)   NULL,
    [UCL]         FLOAT (53)   NULL,
    [LCL]         FLOAT (53)   NULL
);

