CREATE TABLE [Volvo].[L_users] (
    [id]           INT          IDENTITY (1, 1) NOT NULL,
    [username]     VARCHAR (50) NOT NULL,
    [LocationRoot] VARCHAR (50) CONSTRAINT [DF_L_users_LocationRoot] DEFAULT ('VCG') NOT NULL,
    [AssetRoot]    VARCHAR (50) CONSTRAINT [DF_L_users_AssetRoot] DEFAULT ('') NOT NULL,
    [Locked]       BIT          CONSTRAINT [DF_L_users_Locked] DEFAULT ((0)) NOT NULL,
    [Blocked]      BIT          CONSTRAINT [DF_L_users_Blocked] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_L_users] PRIMARY KEY CLUSTERED ([id] ASC)
);

