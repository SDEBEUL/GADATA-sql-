CREATE PROCEDURE [dbo].[MyFirstStoredProcedure]
   @number1 as int = 1
  ,@number2 as int = 5
  ,@someText as varchar(200) = 'test'
AS
begin

Select 
 @number1 as 'the first number'
,@number2 as 'second number'
,(@number1 + @number2) as 'the sum'
,GETDATE() as 'timestamp'
,@sometext as 'a comment'
end