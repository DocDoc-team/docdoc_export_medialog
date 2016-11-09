IF OBJECT_ID (N'dbo.getSlotDateTime', N'FN') IS NULL
BEGIN
  CREATE FUNCTION dbo.getSlotDateTime (
  @slotDate as datetime, @slotStart as int, @slotLength as int = 0)

  RETURNS datetime

  BEGIN

  return DATEADD(MINUTE, round(@slotStart / 100, 0) * 60 + @slotStart % 100 + @slotLength, @slotDate);
  END;
END

GO

set nocount on;
SELECT 'doctor_id;clinic_id;date_start;date_finish';

SELECT
   schedule.MEDECINS_ID  doctor_id,
   schedule.FM_INTORG_ID clinic_id,
   dbo.getSlotDateTime(from_date, from_time, default) as FROM_DATE,
   dbo.getSlotDateTime(to_date, to_time, default) as TO_DATE

FROM PL_EXCL

JOIN PL_SUBJ schedule ON schedule.PL_SUBJ_ID = PL_EXCL.PL_SUBJ_ID

WHERE PL_LEG_ID IN (8, 11, 95) AND FROM_DATE BETWEEN cast(getdate() as date) AND DATEADD(DAY, 30, GETDATE())