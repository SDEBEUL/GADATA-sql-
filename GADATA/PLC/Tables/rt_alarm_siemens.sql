CREATE TABLE [PLC].[rt_alarm_siemens] (
    [Workstation] VARCHAR (50)  NULL,
    [DateTime]    DATETIME      NULL,
    [DownTime_s]  INT           NULL,
    [FaultClass]  VARCHAR (200) NULL,
    [Str1]        VARCHAR (200) NULL,
    [Str2]        VARCHAR (200) NULL,
    [Str3]        VARCHAR (200) NULL,
    [ID]          INT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_rt_alarm_siemens] PRIMARY KEY CLUSTERED ([ID] ASC)
);

