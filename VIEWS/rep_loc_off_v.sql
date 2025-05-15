USE `la_crime`;
CREATE  OR REPLACE VIEW rep_loc_off_v AS
SELECT
    rep.REPORT_NO,
	rep.AREA_CODE,
    rep.INCIDENT_TIME,
    rep.COMPLAINT_TYPE,
    rep.CCTV_FLAG,
    rep.CRIME_CODE,
    rep.CRIME_TYPE,
    rep.WEEK_NUMBER,
    rep.CASE_STATUS_CODE,
    rep.CASE_STATUS_DESC,
	loc.AREA_NAME,
	loc.CCTV_COUNT,
	loc.POPULATION_DENSITY,
    off.officer_code,	
	off.precinct_code
    FROM la_crime_report_t AS rep
    JOIN la_crime_location_t AS loc
    ON rep.AREA_CODE = loc.AREA_CODE
    JOIN la_crime_officer_t AS off
    ON rep.OFFICER_CODE = off.officer_code;
