






CREATE PROCEDURE [EqUi].[sp_LinkAssets]

AS
BEGIN
--clear the table
 DELETE GADATA.EqUi.ASSETS FROM GADATA.EqUi.ASSETS
 
 --run new transfer
                INSERT INTO GADATA.EqUi.ASSETS
                SELECT [SYSTEMID]
                      ,assets.[LOCATION]
                      ,assets.[ASSETNUM]
                      ,assets.[AssetDescription]
                      ,assets.[LocationTree]
                      ,assets.[ClassDescription]
                      ,assets.[ClassStructureId]
                      ,assets.[CLassificationId]
                      ,assets.[ClassificationTree]
                      ,assets.[Station]
                      ,assets.[Area]
                      ,assets.[Team]
                      ,ISNULL(r.controller_name,ra.controller_name) as 'controller_name'
                      ,ISNULL(ISNULL(r.controller_type,ra.controller_type),plc.controller_type) as 'controller_type'
                      ,ISNULL(ISNULL(r.id,ra.id),plc.id) as 'controller_id'
                      ,ROW_NUMBER() OVER (PARTITION BY 
                          ISNULL(r.controller_type,ra.controller_type)
                        , ISNULL(r.id,ra.id), assets.classificationid 
                        ORDER BY assets.location ASC) AS 'controller_ToolID'

                  FROM [GADATA].[Equi].[ASSETS_fromMX7] as assets
--***********************************************ROBOT CONTROLLER JOIN BLOCK***********************************************--
                  --join robot assets with there controller
                  left join GADATA.volvo.Robots as r on 
                  r.controller_name = assets.LOCATION
                  AND
                  (assets.ASSETNUM like 'URC%' OR assets.ASSETNUM like 'URA%') --COMAU and ABB assets
--***********************************************ROBOT CONTROLLED ASSET JOIN BLOCK*******************************************-- 
                  --join robot controller assets with there controller
                  left join GADATA.VOLVO.Robots as ra on 
                  --Grippers
                  (
                  REPLACE(REPLACE(REPLACE(assets.LOCATION,'GH','R'),'GP','R'),'GD','R') LIKE ra.controller_name+'%'
                  )
                  OR
                  --Weld WS (func pack spot) WN (nutweld)
                  (
                  REPLACE(REPLACE(REPLACE(assets.LOCATION,'WS','R'),'WT','R'),'WN','R') LIKE ra.controller_name+'%'
                  )
                    OR
                  -- WT (tucker) Pistool, Toevoer, Lasbron, algemene zaken
                  (
                  REPLACE(REPLACE(REPLACE(REPLACE(assets.LOCATION,'WTP','R'),'WTT','R'),'WTL','R'),'WTA','R') LIKE ra.controller_name+'%'
                  )
                  OR
                  --Dispense (and quis)
                  (
                  REPLACE(REPLACE(assets.LOCATION,'SH','R'),'QF','R') LIKE ra.controller_name+'%'
                  )
                  OR
                  --Nutrunners
                  (
                  REPLACE(assets.LOCATION,'JB','R') LIKE ra.controller_name+'%'
                  )
--***********************************************PLC CONTROLLER JOIN BLOCK***********************************************--
				--join the plc asset with there controller
				left join 
				(
				SELECT 
				'STO' as 'controller_type'
				,c_controller.*
				FROM GADATA.STO.c_controller 
				)
				as plc on plc.ALARMOBJECT LIKE assets.[LOCATION] +'%'
			
--**********************************************only join for GA GB********************************************************--
                where 
               --changed because some assets still not linked 
			   -- (assets.LocationTree like 'VCG -> A%' AND assets.ASSETNUM like 'U%')
			    (assets.LocationTree like 'VCG -> A%')
                OR
                (assets.LocationTree like 'VCG -> B%' AND assets.ASSETNUM like 'U%')
             



			 --*******************************************************************************************************************--
			 --new way 
			 --NGAC
UPDATE GADATA.NGAC.c_controller
SET c_controller.LocationTree = mx.LocationTree 
   ,c_controller.Assetnum = mx.ASSETNUM
   ,c_controller.ProductionTeam = mx.Team
   ,c_controller.ResponsiblePloeg = null --tbd
   ,c_controller.ClassificationTree = mx.ClassificationTree
   ,c_controller.CLassificationId = mx.CLassificationId
FROM GADATA.NGAC.c_controller as C 
LEFT JOIN GADATA.EqUi.ASSETS_fromMX7 as mx on mx.LOCATION = C.controller_name AND mx.SYSTEMID = 'PRODMID'

--C3G
UPDATE GADATA.C3G.c_controller
SET c_controller.LocationTree = mx.LocationTree 
   ,c_controller.Assetnum = mx.ASSETNUM
   ,c_controller.ProductionTeam = mx.Team
   ,c_controller.ResponsiblePloeg = null --tbd
  -- ,c_controller.ClassificationTree = mx.ClassificationTree
  -- ,c_controller.CLassificationId = mx.CLassificationId
FROM GADATA.C3G.c_controller as C 
LEFT JOIN GADATA.EqUi.ASSETS_fromMX7 as mx on mx.LOCATION = C.controller_name AND mx.SYSTEMID = 'PRODMID'

--C4G
UPDATE GADATA.C4G.c_controller
SET c_controller.LocationTree = mx.LocationTree 
   ,c_controller.Assetnum = mx.ASSETNUM
   ,c_controller.ProductionTeam = mx.Team
   ,c_controller.ResponsiblePloeg = null --tbd
  -- ,c_controller.ClassificationTree = mx.ClassificationTree
  -- ,c_controller.CLassificationId = mx.CLassificationId
FROM GADATA.C4G.c_controller as C 
LEFT JOIN GADATA.EqUi.ASSETS_fromMX7 as mx on mx.LOCATION = C.controller_name AND mx.SYSTEMID = 'PRODMID'

end