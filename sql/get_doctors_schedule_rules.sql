SET NOCOUNT ON;
SELECT 'doctor_id;clinic_id;day_name;day_of_week;start_time;end_time;enabled;schedule_interval,count';

SELECT
  schedule.MEDECINS_ID               doctor_id,
  model.FM_INTORG_ID                 clinic_id,
  days.NAME,
  days.DAY_OF_WEEK,
  days.START_TIME                    start_time,
  days.END_TIME                      finish_time,
  days.ENABLED,
  ISNULL(setka.DUREE_TRANCHE, 30) AS schedule_interval,
  count(*)

FROM PL_PARAM model
  JOIN FM_ORG org ON org.FM_ORG_ID = model.FM_INTORG_ID
  JOIN PL_SUBJ_PARAM model2schedule ON model2schedule.PL_PARAM_ID = model.PL_PARAM_ID
  JOIN PL_SUBJ schedule ON schedule.PL_SUBJ_ID = model2schedule.PL_SUBJ_ID
  JOIN PL_AGEND setka ON setka.PL_AGEND_ID = schedule.PL_AGEND_ID1
  JOIN MEDECINS doctors ON doctors.MEDECINS_ID = schedule.MEDECINS_ID
  JOIN PL_DAY days ON days.PL_AGEND_ID = setka.PL_AGEND_ID
WHERE
  (model.ARCHIVE != 1 AND org.ARCHIVE != 1 AND schedule.ARCHIVE != 1 AND setka.ARCHIVE != 1)
  AND
  (schedule.OWNER_TYPE = 2 AND setka.OWNER_TYPE = 2)

GROUP BY schedule.MEDECINS_ID,
  model.FM_INTORG_ID,
  days.NAME,
  days.DAY_OF_WEEK,
  days.START_TIME,
  days.END_TIME,
  days.ENABLED,
  ISNULL(setka.DUREE_TRANCHE, 30);
