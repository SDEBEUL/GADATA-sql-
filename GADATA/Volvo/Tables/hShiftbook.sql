CREATE TABLE [Volvo].[hShiftbook] (
    [id]                  BIGINT         IDENTITY (1, 1) NOT NULL,
    [controller_type]     VARCHAR (5)    NULL,
    [controller_id]       INT            NULL,
    [Breakdown_id]        INT            NULL,
    [ci]                  INT            NULL,
    [wo]                  INT            NULL,
    [State]               VARCHAR (15)   NULL,
    [userDescription]     VARCHAR (400)  NULL,
    [userComment]         VARCHAR (MAX)  NULL,
    [ReportUser]          VARCHAR (100)  NULL,
    [Report_timestamp]    DATETIME       NULL,
    [State_history]       VARCHAR (4000) NULL,
    [updateTimestamp]     DATETIME       NULL,
    [IndependantLocation] VARCHAR (50)   NULL,
    [AcceptUser]          VARCHAR (100)  NULL,
    CONSTRAINT [PK_Shiftbook2] PRIMARY KEY CLUSTERED ([id] ASC)
);



