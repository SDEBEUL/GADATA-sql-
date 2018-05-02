CREATE PROCEDURE [C3G].[sp_update_Lerror_classifcation]
    @Update as bit = 0 -- 0 = only update records that currently have NULL (new records) | 1 = recalc ALL records
   ,@OverRideManualSet as bit = 0 -- 1 manully set Classification will be overruled. 
   ,@c_ClassificationId as int = 0
   ,@c_SubgroupId as int = 0
AS
BEGIN

UPDATE GADATA.C3G.L_error 
SET 
 [c_ClassificationId] = Cr.c_ClassificationId
,[c_SubgroupId] = Cr.c_SubgroupId
,[c_RuleId] = CR.id


FROM GADATA.C3G.L_error as L 
--get classification
LEFT JOIN GADATA.C3G.c_LogClassRules as Cr ON 
(
	(L.error_number BETWEEN Cr.Err_start AND Cr.Err_end)
	OR
	(L.error_text LIKE RTRIM(Cr.Err_text))
)
WHERE 
--Clause to make update or Full reapply mode 
(
--*****************************************************************************************************--
--only update new l_erros. (runs like this every minute) for job manager
--*****************************************************************************************************--
	(
		(L.c_ClassificationId is null) 
		AND 
		(L.c_SubgroupId is null) 
		AND 
		(@Update = 0)
	)
--*****************************************************************************************************--
--for Errormanger UI ! 
--*****************************************************************************************************--
--these modes only run one group at a time 
OR--full reapply mode NO overide of manual set 
	(
		(@Update = 1)
		AND 
		(@OverRideManualSet = 0)
		AND
		((l.c_RuleId <> -1) OR (l.c_RuleId is null))-- -1 signals that it was set manually
		AND
		(Cr.c_ClassificationId = @c_ClassificationId)
		AND
		(Cr.c_SubgroupId = @c_SubgroupId)
	)
OR--full reapply mode OVERRIDE of manual set 
	(
		(@Update = 1)
		AND 
		(@OverRideManualSet = 1)
		AND
		(Cr.c_ClassificationId = @c_ClassificationId)
		AND
		(Cr.c_SubgroupId = @c_SubgroupId)
	)
--*****************************************************************************************************--
--manual operations 
--*****************************************************************************************************--
--these modes only run ON EVERYTING ! 
OR--full reapply mode NO overide of manual set 
	(
		(@Update = 1)
		AND 
		(@OverRideManualSet = 0)
		AND
		((l.c_RuleId <> -1) OR (l.c_RuleId is null))-- -1 signals that it was set manually
		AND
		(@c_ClassificationId is null)
		AND
		(@c_SubgroupId is null)
	)
OR--full reapply mode OVERRIDE of manual set 
	(
		(@Update = 1)
		AND 
		(@OverRideManualSet = 1)
		AND
		(@c_ClassificationId is null)
		AND
		(@c_SubgroupId is null)
	)
)

END