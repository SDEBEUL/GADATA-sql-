CREATE TABLE [GLUE].[vultijden2] (
    [ID]            INT      IDENTITY (1, 1) NOT NULL,
    [c_timestamp]   DATETIME NOT NULL,
    [Controller_id] INT      NOT NULL,
    [vultijd_ms]    INT      NOT NULL
);

