CREATE  OR REPLACE VIEW rep_vict_v AS
SELECT
	rep.REPORT_NO,
    rep.VICTIM_CODE,
    rep.OFFENDER_RELATION,
    rep.CRIME_TYPE,
    rep.INCIDENT_TIME,
    vic.VICTIM_AGE
FROM la_crime_report_t rep 
JOIN la_crime_victim_t vic
ON rep.VICTIM_CODE = vic.VICTIM_CODE;