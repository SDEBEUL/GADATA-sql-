
-- ============================================= 
-- Author:    Coppejans Jens 
-- Create date:  
-- Description:   
-- ============================================= 
CREATE PROCEDURE [WELDING].[TimerErrorLog] 
AS 
  BEGIN 
      SET nocount ON; 

 

    --NPT22 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([19.148.180.162\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT23 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([19.148.181.53\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT24 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([19.148.180.227\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT26 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([19.148.181.154\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT27 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([19.148.181.155\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT28 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([19.148.180.141\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT29 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([19.148.180.149\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT30 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([19.148.180.203\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT31 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([19.148.180.39\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT32 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([19.148.192.18\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT33 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([19.148.192.33\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT40 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.240.10\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT41 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.240.11\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT42 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.240.12\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT43 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.240.13\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT50 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.225.199\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT51 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.225.197\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT52 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.225.198\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT53 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.240.14\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT54 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.225.200\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT55 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.226.5\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT56 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.225.133\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT57 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.203.138\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT58 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.226.7\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT59 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.226.8\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT70 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.227.69\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT71 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.222.197\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT72 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.225.135\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 

    --NPT73 
    INSERT INTO dbo.timererrorlog 
                (datetime, 
                 timerid, 
                 errorid, 
                 error2id) 
    SELECT errorlog.datetime, 
           dbo.timer.id          AS timerid, 
           dbo.timererrortext.id AS errorID, 
           NULL                  AS ErrorID2 
    FROM   dbo.timererrortext 
           INNER JOIN dbo.timer 
                      INNER JOIN Openquery([10.249.222.198\bos_sqlserv_2005], 
'                  SELECT        *                 FROM            dbo.ExtError_V                  WHERE  (errorCode1 <> 180 AND errorCode1 <> 132 AND errorCode1 <> 1013 AND                           errorCode1 <> 102 AND errorCode1 <> 1008 AND errorCode1 <> 1009) ' 
) AS errorlog 
        ON dbo.timer.NAME = errorlog.timername COLLATE database_default 
        ON dbo.timererrortext.errortext = errorlog.errorcode1_txt COLLATE 
                                          database_default 
LEFT OUTER JOIN dbo.timererrorlog 
             ON errorlog.datetime = dbo.timererrorlog.datetime 
WHERE  ( dbo.timererrorlog.datetime IS NULL ) 
END