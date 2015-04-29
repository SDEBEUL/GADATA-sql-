CREATE PROCEDURE [ABB].[sp_Testproc ]
AS
begin
exec abb.sp_Decode_AE
exec abb.sp_update_L
exec abb.sp_get_abb
end