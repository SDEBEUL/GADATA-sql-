CREATE PROCEDURE [ABB].[sp_Testproc ]
AS
begin

--Decode the raw irc5 data to readable data
exec abb.sp_Decode_AE_IRC5
--Normalize to the database and drop dupplicate records
exec abb.sp_update_L_IRC5

--Decode the raw S4 data to readable data
exec abb.sp_Decode_AE_S4
--Normalize to the database and drop dupplicate records
exec abb.sp_update_L_S4

--Apply the subgroup and Appl rules to the NEW records 
exec abb.sp_UPDATE_abb_APPL_Subgroup

--Display data from last 24h 
exec abb.sp_get_abb
end