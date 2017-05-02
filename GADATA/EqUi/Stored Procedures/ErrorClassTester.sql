CREATE PROCEDURE [EqUi].[ErrorClassTester]
AS
BEGIN

SELECT * FROM (
select 
 'c3g' as 'type'
,l.error_number
,l.error_severity
,l.error_text
,cc.Classification
,cc.Discription
,cs.Subgroup
,cs.Discription as 'cDiscription'
,l.c_RuleId
from  C3G.L_error AS L 
LEFT OUTER JOIN VOLVO.c_Classification as cc on cc.id = L.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as cs on cs.id = L.c_SubgroupId

UNION
select 
 'c4g' as 'type'
,l.error_number
,l.error_severity
,l.error_text
,cc.Classification
,cc.Discription
,cs.Subgroup
,cs.Discription as 'cDiscription'
,l.c_RuleId
from  C4G.L_error AS L 
LEFT OUTER JOIN VOLVO.c_Classification as cc on cc.id = L.c_ClassificationId
LEFT OUTER JOIN VOLVO.c_Subgroup as cs on cs.id = L.c_SubgroupId
) as X 
order by x.type, x.error_number asc
END