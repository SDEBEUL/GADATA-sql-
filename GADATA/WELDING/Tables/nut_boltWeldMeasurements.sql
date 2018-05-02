CREATE TABLE [WELDING].[nut_boltWeldMeasurements] (
    [ID]               INT        IDENTITY (1, 1) NOT NULL,
    [Timestamp]        DATETIME   NOT NULL,
    [TimerID]          INT        NOT NULL,
    [SpotID]           INT        NOT NULL,
    [wear]             INT        NULL,
    [I_demand]         FLOAT (53) NULL,
    [I_Actual]         FLOAT (53) NULL,
    [regulation]       NCHAR (5)  NULL,
    [BodyNr]           NCHAR (50) NULL,
    [ElectrodeNr]      SMALLINT   NULL,
    [Weldtime]         INT        NULL,
    [EnergyActual]     INT        NULL,
    [EnergyRef]        INT        NULL,
    [ResistanceActual] INT        NULL,
    [ResistanceRef]    INT        NULL,
    [ExpulsionTime]    INT        NULL,
    CONSTRAINT [PK_nut_boltWeldMeasurements2] PRIMARY KEY CLUSTERED ([ID] ASC)
);

