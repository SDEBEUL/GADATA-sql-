CREATE TABLE [NGAC].[h_TipWearBeforeChange] (
    [controller_name]             VARCHAR (30) NULL,
    [controller_id]               INT          NULL,
    [tipDressID]                  INT          NOT NULL,
    [Tool_Nr]                     SMALLINT     NOT NULL,
    [TipchangeTimestamp]          DATETIME     NULL,
    [FixedWearBeforeChange]       FLOAT (53)   NULL,
    [MoveWearBeforeChange]        FLOAT (53)   NULL,
    [WearBeforeChange]            FLOAT (53)   NULL,
    [WeldsBeforeChange]           INT          NULL,
    [DressBeforeChange]           SMALLINT     NULL,
    [%FixedWearBeforeChange]      FLOAT (53)   NULL,
    [%MoveWearBeforeChange]       FLOAT (53)   NULL,
    [ESTnSpotsFixedWearBefore100] FLOAT (53)   NULL,
    [ESTnSpotsMoveWearBefore100]  FLOAT (53)   NULL,
    [TipAge(h)]                   INT          NULL,
    [DeltaNom]                    FLOAT (53)   NULL,
    [DeltaNomBeforeChange]        FLOAT (53)   NULL
);

