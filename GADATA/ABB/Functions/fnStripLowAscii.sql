
CREATE FUNCTION [ABB].[fnStripLowAscii] (@InputString nvarchar(4000))
RETURNS nvarchar(4000)
AS
BEGIN
IF @InputString IS NOT NULL
BEGIN
  DECLARE @Counter int, @TestString nvarchar(40)

  SET @TestString = '%[' + NCHAR(0) + NCHAR(1) + NCHAR(2) + NCHAR(3) + NCHAR(4) + NCHAR(5) + NCHAR(6) + NCHAR(7) + NCHAR(8) + NCHAR(11) + NCHAR(12) + NCHAR(14) + NCHAR(15) + NCHAR(16) + NCHAR(17) + NCHAR(18) + NCHAR(19) + NCHAR(20) + NCHAR(21) + NCHAR(22) + NCHAR(23) + NCHAR(24) + NCHAR(25) + NCHAR(26) + NCHAR(27) + NCHAR(28) + NCHAR(29) + NCHAR(30) + NCHAR(31) + NCHAR(60) +NCHAR(62) + NCHAR(38) + ']%'

  SELECT @Counter = PATINDEX (@TestString, @InputString COLLATE Latin1_General_BIN)

  WHILE @Counter <> 0
  BEGIN
    SELECT @InputString = STUFF(@InputString, @Counter, 1, NCHAR(164))
    SELECT @Counter = PATINDEX (@TestString, @InputString COLLATE Latin1_General_BIN)
  END
END
RETURN(@InputString)
END