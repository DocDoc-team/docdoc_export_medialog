set nocount on;
SELECT 'doctor_id;last_name;first_name';
SELECT
  MEDECINS_ID,
  NOM,
  PRENOM
FROM
  MEDECINS
WHERE
  TYPE = 0
  AND
  PRENOM IS NOT NULL AND PRENOM != ''
  AND
  NOM IS NOT NULL AND NOM != ''
  AND
  (
    (ISNULL(SYSTEM_FLAGS, '') = '')
    OR
    (SYSTEM_FLAGS LIKE '%US%')
  )
  AND
  (ARCHIVE NOT IN (1))
ORDER BY
  NOM, PRENOM;
