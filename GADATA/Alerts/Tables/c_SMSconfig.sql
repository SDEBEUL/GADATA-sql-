CREATE TABLE [Alerts].[c_SMSconfig] (
    [id]             INT IDENTITY (1, 1) NOT NULL,
    [c_smsSystem_id] INT NOT NULL,
    [c_CPT600_id]    INT NOT NULL,
    CONSTRAINT [PK_c_SMSconfig] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_c_SMSconfig_c_CPT600] FOREIGN KEY ([c_CPT600_id]) REFERENCES [Alerts].[c_CPT600] ([id]),
    CONSTRAINT [FK_c_SMSconfig_c_smsSystem] FOREIGN KEY ([c_smsSystem_id]) REFERENCES [Alerts].[c_smsSystem] ([id])
);

