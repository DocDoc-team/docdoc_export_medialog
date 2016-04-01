set nocount on;
select 'template_id;start_time;end_time;pl_day_id;pl_agend_id;day_of_week';

select
	  templates.PL_INT_ID,
      templates.INT_FROM,
      templates.INT_TO,
      templates.PL_DAY_ID,
      PL_AGEND_ID,
      DAY_OF_WEEK
  from Medialog_750.dbo.PL_INT as templates
  inner join Medialog_750.dbo.PL_DAY
  on templates.PL_DAY_ID = PL_DAY.PL_DAY_ID