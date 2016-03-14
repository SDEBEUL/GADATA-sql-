Create Proc GLUE.spblablabla
@OperatorActionInfo_id int,
@OldValue nvarchar(20)
as
Begin
	Select c_timestamp, NewValue from GLUE.h_operator Where OldValue=@Oldvalue and OperatorActionInfo_id=@OperatorActionInfo_id
End