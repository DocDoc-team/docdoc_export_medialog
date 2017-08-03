IF OBJECT_ID (N'dbo.getSlotDateTime', N'FN') IS NOT NULL
    DROP FUNCTION getSlotDateTime;
GO
CREATE FUNCTION dbo.getSlotDateTime (
@slotDate as datetime, @slotStart as int, @slotLength as int = 0)

RETURNS datetime

BEGIN

return DATEADD(MINUTE, round(@slotStart / 100, 0) * 60 + @slotStart % 100 + @slotLength, @slotDate);
END;

GO

set nocount on;
select 'doctor_id;clinic_id;date_start;date_finish';

SELECT

   schedule.MEDECINS_ID  doctor_id,

   schedule.FM_INTORG_ID clinic_id,

   dbo.getSlotDateTime(DATE_CONS, HEURE, default) as FROM_DATE,

   dbo.getSlotDateTime(DATE_CONS, HEURE, DUREE) as TO_DATE


FROM PLANNING

   JOIN PL_SUBJ schedule ON schedule.PL_SUBJ_ID = PLANNING.PL_SUBJ_ID

WHERE DATE_CONS BETWEEN cast(getdate() as datetime) AND DATEADD(DAY, 30, GETDATE())

       AND CANCELLED != 1

union all

select

   schedule.MEDECINS_ID  doctor_id,

   schedule.FM_INTORG_ID clinic_id,

   dbo.getSlotDateTime(from_date, from_time, default) as FROM_DATE,

   dbo.getSlotDateTime(to_date, to_time, default) as TO_DATE

from PL_EXCL

   JOIN PL_SUBJ schedule ON schedule.PL_SUBJ_ID = PL_EXCL.PL_SUBJ_ID

WHERE PL_LEG_ID NOT IN (8, 11, 95) AND FROM_DATE BETWEEN cast(getdate() as datetime) AND DATEADD(DAY, 30, GETDATE())