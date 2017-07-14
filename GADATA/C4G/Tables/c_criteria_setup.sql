﻿CREATE TABLE [C4G].[c_criteria_setup] (
    [id]                      INT           IDENTITY (1, 1) NOT NULL,
    [axes_mask]               INT           NULL,
    [shift_mask]              INT           NULL,
    [model_code]              INT           NULL,
    [c_rec_variable_id_if1]   INT           NULL,
    [kpi_if1]                 INT           NULL,
    [operator_if1]            INT           NULL,
    [value_if1]               REAL          NULL,
    [boolean_clause_if1]      INT           NULL,
    [c_rec_variable_id_if2]   INT           NULL,
    [kpi_if2]                 INT           NULL,
    [operator_if2]            INT           NULL,
    [value_if2]               REAL          NULL,
    [boolean_clause_if2]      INT           NULL,
    [c_rec_variable_id_if3]   INT           NULL,
    [kpi_if3]                 INT           NULL,
    [operator_if3]            INT           NULL,
    [value_if3]               REAL          NULL,
    [c_rec_variable_id_when1] INT           NULL,
    [kpi_when1]               INT           NULL,
    [operator_when1]          INT           NULL,
    [value_when1]             REAL          NULL,
    [boolean_clause_when1]    INT           NULL,
    [c_rec_variable_id_when2] INT           NULL,
    [kpi_when2]               INT           NULL,
    [operator_when2]          INT           NULL,
    [value_when2]             REAL          NULL,
    [boolean_clause_when2]    INT           NULL,
    [c_rec_variable_id_when3] INT           NULL,
    [kpi_when3]               INT           NULL,
    [operator_when3]          INT           NULL,
    [value_when3]             REAL          NULL,
    [action_level]            INT           NULL,
    [action_post]             INT           NULL,
    [action_data]             VARCHAR (256) NULL,
    [description]             VARCHAR (256) NULL,
    [keycode]                 INT           NULL,
    CONSTRAINT [PK_c_criteria_setup] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_c_criteria_setup_c_rec_variable_if1] FOREIGN KEY ([c_rec_variable_id_if1]) REFERENCES [C4G].[c_rec_variable] ([id]),
    CONSTRAINT [FK_c_criteria_setup_c_rec_variable_if2] FOREIGN KEY ([c_rec_variable_id_if2]) REFERENCES [C4G].[c_rec_variable] ([id]),
    CONSTRAINT [FK_c_criteria_setup_c_rec_variable_if3] FOREIGN KEY ([c_rec_variable_id_if3]) REFERENCES [C4G].[c_rec_variable] ([id]),
    CONSTRAINT [FK_c_criteria_setup_c_rec_variable_when1] FOREIGN KEY ([c_rec_variable_id_when1]) REFERENCES [C4G].[c_rec_variable] ([id]),
    CONSTRAINT [FK_c_criteria_setup_c_rec_variable_when2] FOREIGN KEY ([c_rec_variable_id_when2]) REFERENCES [C4G].[c_rec_variable] ([id]),
    CONSTRAINT [FK_c_criteria_setup_c_rec_variable_when3] FOREIGN KEY ([c_rec_variable_id_when3]) REFERENCES [C4G].[c_rec_variable] ([id])
);

