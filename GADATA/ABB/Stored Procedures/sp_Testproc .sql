CREATE PROCEDURE [ABB].[sp_Testproc ]
AS
begin
exec abb.sp_Decode_AE_IRC5
exec abb.sp_update_L_IRC5

exec abb.sp_Decode_AE_S4
exec abb.sp_update_L_S4

exec abb.sp_get_abb
end