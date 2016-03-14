Create Proc GLUE.spblablabla2
@OperatorActionInfo_id int,
@OldValue nvarchar(20)
as
Begin
	Select OperatorActionInfo_id, c_timestamp, NewValue from GLUE.h_operator Where OldValue=@Oldvalue and OperatorActionInfo_id=@OperatorActionInfo_id
End