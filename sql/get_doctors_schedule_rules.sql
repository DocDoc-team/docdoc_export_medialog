SET NOCOUNT ON;
SELECT
  'doctor_id;clinic_id;day_name;start_time;finish_time;enabled;day_even;day_of_week;day_of_month;month;year;day_id;schedule_interval;day_order;period_from;period_to;interval_work;interval_off;interval_start_from;day_week_month';
SELECT
  schedule.MEDECINS_ID                                           doctor_id,
  model.FM_INTORG_ID                                             clinic_id,
  ISNULL(days.NAME, ''),
  days.START_TIME,
  days.END_TIME,
  days.ENABLED,
  ISNULL(days.DAY_EVEN, ''),
  ISNULL(days.DAY_OF_WEEK, ''),
  ISNULL(days.DAY_OF_MONTH, ''),
  ISNULL(days.DAY_YEAR, '')                                   AS year,
  ISNULL(days.DAY_MONTH, '')                                  AS month,
  ISNULL(days.PL_DAY_ID, '')                                  AS day_id,
  ISNULL(days.DUREE_TRANCHE, ISNULL(setka.DUREE_TRANCHE, 30)) AS schedule_interval,
  days.DAY_ORDER,
  --
  ISNULL(days.PERIOD_FROM, ''),
  ISNULL(days.PERIOD_TO, ''),
  ISNULL(days.INTERVAL_WORK, ''),
  ISNULL(days.INTERVAL_OFF, ''),
  ISNULL(days.INTERVAL_STARTFROM, ''),
  ISNULL(days.DAY_WEEK_MONTH, '')

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

GROUP BY
  schedule.MEDECINS_ID,
  model.FM_INTORG_ID,
  days.NAME,
  days.START_TIME,
  days.END_TIME,
  days.ENABLED,

  days.DAY_OF_WEEK,
  days.DAY_OF_MONTH,
  days.DAY_EVEN,
  days.DAY_YEAR,
  days.DAY_MONTH,
  days.PL_DAY_ID, --group
  ISNULL(days.DUREE_TRANCHE, ISNULL(setka.DUREE_TRANCHE, 30)),
  days.DAY_ORDER,
  days.PERIOD_FROM,
  days.PERIOD_TO,
  days.INTERVAL_OFF,
  days.INTERVAL_WORK,
  days.INTERVAL_STARTFROM,
  days.DAY_WEEK_MONTH

ORDER BY days.DAY_ORDER DESC;
