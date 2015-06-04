CREATE PROCEDURE [ABB].[sp_UPDATE_abb_APPL_Subgroup]
   @Update as bit = 0 -- 0 = only update records that currently have NULL (new records) | 1 = recalc ALL records
   ,@show as bit = 0 --if 1 the result will be displayed. (debuging)
   ,@FilterText as varchar(50) = '%%' --to filter error text (debugging)
AS
BEGIN
---------------------------------------------------------------------------------------
--set first day of the week to monday (german std)
---------------------------------------------------------------------------------------
SET DATEFIRST 1
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
print '--*****************************************************************************--'
print '--[ABB].[sp_UPDATE_abb_APPL_Subgroup]--'
print '--*****************************************************************************--'
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--Update subgroup and appl ID 
---------------------------------------------------------------------------------------
UPDATE GADATA.abb.L_error 
SET 
 Appl_id = Isnull(Cr.Appl_id,1)
,Subgroup_id = Isnull(Cr.Subgroup_id,1)

FROM GADATA.ABB.L_error as L 
--get classification
LEFT JOIN GADATA.abb.c_LogClassRules as Cr ON 
(
(L.error_number BETWEEN Cr.Err_start AND Cr.Err_end)
OR
((L.error_text LIKE RTRIM(Cr.Err_text) AND Cr.F_error_text = 1))
)
WHERE 
--Clause to make update or Full reapply mode 
(
(((L.Appl_id is null) AND (L.Subgroup_id is null)) AND (@Update = 0))
OR
(@Update = 1)
)

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

if (@show = 1)
BEGIN
---------------------------------------------------------------------------------------
print 'Pulling debug Query'
---------------------------------------------------------------------------------------
SELECT  
L.id
,L.error_number
,L.error_severity
,L.error_text
,L.Appl_id
,L.Subgroup_id
,L.category_id
,Category.Category
,Appl.APPL
,Subgroup.Subgroup
FROM GADATA.ABB.L_error as L 
JOIN abb.c_Appl as Appl on (Appl.id = L.Appl_id)
JOIN abb.c_subgroup as Subgroup on (Subgroup.id = L.Subgroup_id)
JOIN abb.c_category as Category on (Category.id = L.category_id)
where L.error_text LIKE @FilterText
END
---------------------------------------------------------------------------------------

END