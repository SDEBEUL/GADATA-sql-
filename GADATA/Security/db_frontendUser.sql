CREATE ROLE [db_frontendUser]
    AUTHORIZATION [VCCNET\SDEBEUL];






GO
ALTER ROLE [db_frontendUser] ADD MEMBER [GADATAui];


GO
ALTER ROLE [db_frontendUser] ADD MEMBER [EqUi];


GO
ALTER ROLE [db_frontendUser] ADD MEMBER [Hangfire];

