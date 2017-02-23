CREATE TABLE [dbo].[WM_WeldFaultProtocol] (
    [NPT]           NCHAR (10)   NOT NULL,
    [Robot]         NCHAR (10)   NULL,
    [Date]          DATETIME     NULL,
    [SPOT]          INT          NULL,
    [Program]       INT          NULL,
    [Weldfaultname] NCHAR (10)   NULL,
    [RobotFault]    NCHAR (10)   NULL,
    [PLOEG]         NCHAR (10)   NULL,
    [DownTime]      INT          NULL,
    [WMComment]     VARCHAR (50) NULL
);

