set nocount on;
select 'doctor_id;clinic_id;date_start;date_finish;name;memo';

select
   schedule.MEDECINS_ID  doctor_id,
   schedule.FM_INTORG_ID clinic_id,
   DATE_START,
   DATE_END,
   PL_EXCL.NAME,
   EXCL_MEMO
 from PL_EXCL
   JOIN PL_SUBJ schedule ON schedule.PL_SUBJ_ID = PL_EXCL.PL_SUBJ_ID
 WHERE DATE_START BETWEEN GETDATE() AND DATEADD(DAY, 30, GETDATE())