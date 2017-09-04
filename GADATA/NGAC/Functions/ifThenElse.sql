
CREATE FUNCTION [NGAC].[ifThenElse](@Logicaltest as bit, @strIf VARCHAR(MAX), @StrElse VARCHAR(MAX)) RETURNS VARCHAR(MAX)
AS
BEGIN
IF (@Logicaltest = 1)
BEGIN
  RETURN @strIf
END
  RETURN @StrElse
END