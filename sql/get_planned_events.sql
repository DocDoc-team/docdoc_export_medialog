SET NOCOUNT ON;
SELECT
  'event_id;start_time;end_time;start_time;day_id';
SELECT
	event.PL_INT_ID as event_id,
	INT_FROM as start_time,
	INT_to as end_time,
  day.PL_DAY_ID as day_id
FROM PL_INT event
JOIN PL_DAY day ON day.PL_DAY_ID = event.PL_DAY_ID
ORDER BY event.PL_INT_ID