CREATE Function [dbo].[RemoveCharacters](@Temp VarChar(1000))
Returns VarChar(1000)
AS
Begin

    Declare @NumRange as varchar(50) = '%[a-z]%'
    While PatIndex(@NumRange, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@NumRange, @Temp), 1, '%')

    Return @Temp
End