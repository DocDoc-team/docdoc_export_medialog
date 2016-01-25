set nocount on;
select 'clinic_id;name';
select  FM_ORG_ID, LABEL from FM_ORG where ORG_TYPE = 'I' and ARCHIVE != 1;
