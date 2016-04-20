set nocount on;
select 'doctor_id;clinic_id;date_start;date_finish';

SELECT
   schedule.MEDECINS_ID  doctor_id,
   schedule.FM_INTORG_ID clinic_id,
   DATE_START,
   DATE_END
 FROM PLANNING
   JOIN PL_SUBJ schedule ON schedule.PL_SUBJ_ID = PLANNING.PL_SUBJ_ID
 WHERE DATE_START BETWEEN GETDATE() AND DATEADD(DAY, 30, GETDATE())
       AND CANCELLED != 1
       AND STATUS != 1
