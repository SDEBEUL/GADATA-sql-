CREATE TABLE [Volvo].[c_Classification] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [Classification] VARCHAR (50)  NOT NULL,
    [Discription]    VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_C_Classification] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_c_Classification_23_845870726__K1_2]
    ON [Volvo].[c_Classification]([id] ASC)
    INCLUDE([Classification]);

