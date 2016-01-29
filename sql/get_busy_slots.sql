set nocount on;
select 'doctor_id;clinic_id;date;time;duration';

SELECT
  schedule.MEDECINS_ID  doctor_id,
  schedule.FM_INTORG_ID clinic_id,
  DATE_CONS,
  HEURE                 time,
  DUREE                 duration
FROM PLANNING
  JOIN PL_SUBJ schedule ON schedule.PL_SUBJ_ID = PLANNING.PL_SUBJ_ID
WHERE DATE_CONS BETWEEN DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 0) AND DATEADD(DAY, 30, GETDATE())
      AND CANCELLED != 1
      AND STATUS != 1
ORDER BY PLANNING_ID DESC;
