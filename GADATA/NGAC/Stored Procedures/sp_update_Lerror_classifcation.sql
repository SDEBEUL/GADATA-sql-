
CREATE PROCEDURE [NGAC].[sp_update_Lerror_classifcation]
    @Update as bit = 0 -- 0 = only update records that currently have NULL (new records) | 1 = recalc ALL records
   ,@OverRideManualSet as bit = 0 -- 1 manully set Classification will be overruled. 
   ,@c_ClassificationId as int = null
   ,@c_SubgroupId as int = null
AS
BEGIN

UPDATE GADATA.NGAC.L_error 
SET 
 [c_ClassificationId] = Cr.c_ClassificationId
,[c_SubgroupId] = Cr.c_SubgroupId
,[c_RuleId] = CR.id 
,[ClassCalculated] = 1

FROM GADATA.NGAC.L_error  as L WITH (NOLOCK) --added no lock to check if it helpt with the job dealocks SDEBEUL 17w47d06
LEFT JOIN GADATA.NGAC.L_description as ld on ld.id = l.l_description_id
--get classification
LEFT JOIN GADATA.NGAC.c_LogClassRules as Cr ON 
(
	(L.Number BETWEEN Cr.Err_start AND Cr.Err_end)
	OR
	(LD.[Description] LIKE RTRIM(Cr.Err_text))
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
		(L.ClassCalculated is null) --this gets set the first time the @update 0 runs. 
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