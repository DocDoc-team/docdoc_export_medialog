set nocount on;
select 'doctor_id;clinic_id;date_start;date_finish';

SELECT

   schedule.MEDECINS_ID  doctor_id,

   schedule.FM_INTORG_ID clinic_id,

   DATEADD(MINUTE, substring(cast(HEURE as varchar), 1, LEN(HEURE) /2) * 60 +

   substring(cast(HEURE as varchar), LEN(HEURE) /2 + 1, 2), DATE_CONS) as FROM_DATE,

   DATEADD(MINUTE, substring(cast(HEURE as varchar), 1, LEN(HEURE) /2) * 60 +

   substring(cast(HEURE as varchar), LEN(HEURE) /2 + 1, 2) + DUREE, DATE_CONS) as TO_DATE

FROM PLANNING

   JOIN PL_SUBJ schedule ON schedule.PL_SUBJ_ID = PLANNING.PL_SUBJ_ID

WHERE DATE_CONS BETWEEN cast(getdate() as date) AND DATEADD(DAY, 30, GETDATE())

       AND CANCELLED != 1

       AND STATUS != 1

union all

select

   schedule.MEDECINS_ID  doctor_id,

   schedule.FM_INTORG_ID clinic_id,

   DATEADD(MINUTE, substring(cast(from_time as varchar), 1, LEN(from_time) /2) * 60 +

   substring(cast(from_time as varchar), LEN(from_time) /2 +1, 2), from_date) as FROM_DATE,

   DATEADD(MINUTE, substring(cast(to_time as varchar), 1, LEN(to_time) /2) * 60 +

   substring(cast(to_time as varchar), LEN(to_time) /2 +1, 2), to_date) as TO_DATE

from PL_EXCL

   JOIN PL_SUBJ schedule ON schedule.PL_SUBJ_ID = PL_EXCL.PL_SUBJ_ID

WHERE FROM_DATE BETWEEN cast(getdate() as date) AND DATEADD(DAY, 30, GETDATE())