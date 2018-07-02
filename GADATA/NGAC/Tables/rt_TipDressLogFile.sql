CREATE TABLE [NGAC].[rt_TipDressLogFile] (
    [id]                       INT           IDENTITY (1, 1) NOT NULL,
    [rt_csv_file_id]           INT           NULL,
    [Date Time]                DATETIME      NULL,
    [Tool_Nr]                  SMALLINT      NULL,
    [Dress_Num]                SMALLINT      NULL,
    [Weld_Counter]             SMALLINT      NULL,
    [Dress_Reason]             VARCHAR (30)  NULL,
    [Weld_Result]              VARCHAR (30)  NULL,
    [Length_Fixed_Result]      VARCHAR (30)  NULL,
    [Length_Move_Result]       VARCHAR (30)  NULL,
    [Max_Wear_Fixed]           FLOAT (53)    NULL,
    [Wear_Fixed]               FLOAT (53)    NULL,
    [DiffFrLastWear_Fixed]     FLOAT (53)    NULL,
    [Max_Wear_Move]            FLOAT (53)    NULL,
    [Wear_Move]                FLOAT (53)    NULL,
    [DiffFrLastWear_Move]      FLOAT (53)    NULL,
    [MaxDiffFrLastMeas]        FLOAT (53)    NULL,
    [Current_TipWear]          FLOAT (53)    NULL,
    [TipWearRatio]             FLOAT (53)    NULL,
    [Dress_Time1]              FLOAT (53)    NULL,
    [Dress_Pressure1]          FLOAT (53)    NULL,
    [Dress_Time2]              FLOAT (53)    NULL,
    [Dress_Pressure2]          FLOAT (53)    NULL,
    [CleanDress_Time]          FLOAT (53)    NULL,
    [CleanDress_Pressure]      FLOAT (53)    NULL,
    [Time_DressCycleTime]      FLOAT (53)    NULL,
    [ErrorType]                VARCHAR (MAX) NULL,
    [ExtraInfo]                VARCHAR (MAX) NULL,
    [GunTCP_X]                 FLOAT (53)    NULL,
    [GunTCP_Y]                 FLOAT (53)    NULL,
    [GunTCP_Z]                 FLOAT (53)    NULL,
    [GunRefTCP_X]              FLOAT (53)    NULL,
    [GunRefTCP_Y]              FLOAT (53)    NULL,
    [GunRefTCP_Z]              FLOAT (53)    NULL,
    [NomTCP_X]                 FLOAT (53)    NULL,
    [NomTCP_Y]                 FLOAT (53)    NULL,
    [NomTCP_Z]                 FLOAT (53)    NULL,
    [Tool_NrHs]                VARCHAR (MAX) NULL,
    [ChkDrWear_Fixed_Result]   VARCHAR (MAX) NULL,
    [ChkDrWear_Move_Result]    VARCHAR (MAX) NULL,
    [FxSens_SetupVal]          FLOAT (53)    NULL,
    [FxSens_StartVal]          FLOAT (53)    NULL,
    [FxSens_PrevVal]           FLOAT (53)    NULL,
    [FxSens_PrevWare]          FLOAT (53)    NULL,
    [FxSens_DiffValue]         FLOAT (53)    NULL,
    [FxSens_MaxSensZComp]      FLOAT (53)    NULL,
    [FxSens_WarmSensZComp]     FLOAT (53)    NULL,
    [FxSens_FlPinPrevVal]      FLOAT (53)    NULL,
    [FxSens_FlPinSetupVal]     FLOAT (53)    NULL,
    [FxSens_FlPinPhysActVal]   FLOAT (53)    NULL,
    [FxSens_FlPinPhysSetupVal] FLOAT (53)    NULL,
    [Internal_Arg]             VARCHAR (MAX) NULL,
    [_timestamp]               DATETIME      NULL,
    CONSTRAINT [PK_rt_TipDressLogFile] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_rt_TipDressLogFile_rt_csv_file] FOREIGN KEY ([rt_csv_file_id]) REFERENCES [NGAC].[rt_csv_file] ([id])
);








GO



GO



GO
CREATE NONCLUSTERED INDEX [nic_TipDressLogfile_maxWear]
    ON [NGAC].[rt_TipDressLogFile]([Max_Wear_Fixed] ASC, [Max_Wear_Move] ASC, [_timestamp] ASC)
    INCLUDE([id], [rt_csv_file_id], [Date Time], [Tool_Nr], [Dress_Num], [Weld_Counter], [Wear_Fixed], [Wear_Move], [TipWearRatio], [Time_DressCycleTime], [GunTCP_X], [GunTCP_Y], [GunTCP_Z], [NomTCP_X], [NomTCP_Y], [NomTCP_Z]);

