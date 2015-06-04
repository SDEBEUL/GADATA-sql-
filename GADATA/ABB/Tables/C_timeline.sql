CREATE TABLE [ABB].[C_timeline] (
    [id]           INT          IDENTITY (1, 1) NOT NULL,
    [starttime]    DATETIME     NULL,
    [endtime]      DATETIME     NULL,
    [Noproduction] BIT          NULL,
    [Comment]      VARCHAR (50) NULL
);

