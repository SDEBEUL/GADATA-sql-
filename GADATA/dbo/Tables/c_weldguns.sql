CREATE TABLE [dbo].[c_weldguns] (
    [id]        INT           IDENTITY (1, 1) NOT NULL,
    [Gunname]   VARCHAR (20)  NULL,
    [Variant]   VARCHAR (20)  NULL,
    [Robotname] VARCHAR (20)  NULL,
    [Toolid]    INT           NULL,
    [TheoX]     INT           NULL,
    [TheoY]     INT           NULL,
    [TheoZ]     INT           NULL,
    [Comment]   VARCHAR (255) NULL,
    [KitNr]     VARCHAR (10)  NULL,
    [Ombouw]    VARCHAR (50)  NULL,
    CONSTRAINT [PK_c_weldguns] PRIMARY KEY CLUSTERED ([id] ASC)
);

