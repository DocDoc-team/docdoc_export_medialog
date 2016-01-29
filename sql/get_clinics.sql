set nocount on;
select 'clinic_id;name;code';
select  FM_ORG_ID, LABEL, CODE from FM_ORG where ORG_TYPE = 'I' and ARCHIVE != 1;
