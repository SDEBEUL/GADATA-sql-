CREATE TABLE [ABB].[L_robotpositions] (
    [ID]             INT           IDENTITY (1, 1) NOT NULL,
    [_timestamp]     SMALLDATETIME CONSTRAINT [DF_L_robotpositions__timestamp] DEFAULT (getdate()) NULL,
    [file_timestamp] SMALLDATETIME NULL,
    [controller_id]  INT           NULL,
    [Owner]          NCHAR (50)    NULL,
    [Pos]            NCHAR (50)    NULL,
    [X]              REAL          NULL,
    [Y]              REAL          NULL,
    [Z]              REAL          NULL,
    [q1]             REAL          NULL,
    [q2]             REAL          NULL,
    [q3]             REAL          NULL,
    [q4]             REAL          NULL,
    [cf1]            SMALLINT      NULL,
    [cf4]            SMALLINT      NULL,
    [cf6]            SMALLINT      NULL,
    [cfx]            SMALLINT      NULL,
    [eax_a]          REAL          NULL,
    [eax_b]          REAL          NULL,
    [eax_c]          REAL          NULL,
    [eax_d]          REAL          NULL,
    [eax_e]          REAL          NULL,
    [eax_f]          REAL          NULL,
    CONSTRAINT [PK_L_robotpositions_1] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'data for abb backuppositions', @level0type = N'SCHEMA', @level0name = N'ABB', @level1type = N'TABLE', @level1name = N'L_robotpositions';

