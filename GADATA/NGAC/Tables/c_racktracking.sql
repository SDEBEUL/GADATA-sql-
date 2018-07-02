CREATE TABLE [NGAC].[c_racktracking] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [Rackname]        VARCHAR (50)  NOT NULL,
    [c_controller_id] INT           NOT NULL,
    [isLoading]       BIT           NOT NULL,
    [rfidBase]        INT           NOT NULL,
    [nRows]           INT           NOT NULL,
    [nParts]          INT           NOT NULL,
    [RackPng]         VARCHAR (50)  NULL,
    [xRowMin]         INT           NULL,
    [xRowMax]         INT           NULL,
    [yRowMin]         INT           NULL,
    [yRowMax]         INT           NULL,
    [xPartMin]        INT           NULL,
    [xPartMax]        INT           NULL,
    [yPartMin]        INT           NULL,
    [yPartMax]        INT           NULL,
    [UserComment]     VARCHAR (MAX) NULL,
    CONSTRAINT [PK_c_racktracking] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_c_racktracking_c_controller] FOREIGN KEY ([c_controller_id]) REFERENCES [NGAC].[c_controller] ([id])
);

