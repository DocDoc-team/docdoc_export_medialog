set nocount on;
SELECT 'doctor_id;clinic_id;last_name;first_name';

SELECT
  doctors.MEDECINS_ID doctor_id,
  schedule.FM_INTORG_ID clinic_id,
  doctors.NOM last_name,
  doctors.PRENOM first_name
FROM
  MEDECINS doctors
  join PL_SUBJ schedule on schedule.MEDECINS_ID = doctors.MEDECINS_ID and schedule.OWNER_TYPE = 2 and schedule.ARCHIVE != 1
WHERE
  doctors.TYPE = 0
  AND
  doctors.PRENOM IS NOT NULL AND doctors.PRENOM != ''
  AND
  doctors.NOM IS NOT NULL AND doctors.NOM != ''
  AND
  (
    (ISNULL(doctors.SYSTEM_FLAGS, '') = '')
    OR
    (doctors.SYSTEM_FLAGS LIKE '%US%')
  )
  AND
  (doctors.ARCHIVE NOT IN (1))
  and schedule.FM_INTORG_ID is not null

group by
  doctors.MEDECINS_ID,
  schedule.FM_INTORG_ID,
  doctors.NOM,
  doctors.PRENOM
ORDER BY
  doctors.MEDECINS_ID;
