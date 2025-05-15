


/*-----------------------------------------------------------------------------------------------------------------------------------

  
-----------------------------------------------------------------------------------------------------------------------------------

                                                         QUESTIONS
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  
/*-- QUESTIONS ANSWERD FROM THE DATA BASE
-- [Q1] Which was the most frequent crime committed each week? 

SELECT 
    crime_type, 
    week_number, 
    crime_count
FROM
(SELECT 
    crime_type, 
    week_number, 
    crime_count,
    RANK() OVER (PARTITION BY week_number ORDER BY crime_count DESC) AS rank_position
FROM 
    (SELECT 
    crime_type, 
    week_number, 
    COUNT(*) AS crime_count
FROM 
    la_crime.rep_loc_off_v
GROUP BY 
    1,2
    ) AS weekly_crime_counts) 
AS ranked_crimes
where rank_position = 1;



-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q2] Is crime more prevalent in areas with a higher population density, fewer police personnel, and a larger precinct area? 

SELECT AREA_NAME,
    POPULATION_DENSITY,
    COUNT(DISTINCT OFFICER_CODE) AS NO_OF_OFFICERS,
    COUNT(DISTINCT CRIME_CODE) AS NO_OF_CRIMES,
    RANK() OVER ( ORDER BY POPULATION_DENSITY DESC) AS POD_RNK,
    RANK() OVER ( ORDER BY COUNT(DISTINCT OFFICER_CODE)DESC) AS OFF_RNK,
    RANK() OVER ( ORDER BY COUNT(DISTINCT CRIME_CODE)DESC) AS CRIME_RNK
FROM REP_LOC_OFF_V
GROUP BY AREA_NAME, POPULATION_DENSITY
ORDER BY CRIME_RNK;



-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q3] At what points of the day is the crime rate at its peak? Group this by the type of crime.

select week, time_period,crime_count
FROM
(select
      week_number AS week,
	  time_f(incident_time) AS time_period, 
	  COUNT(*) AS crime_count,
	RANK() OVER(PARTITION BY week_number ORDER BY COUNT(*) DESC) AS rank_position
      FROM rep_loc_off_v
      GROUP BY 1,2) HYH
      WHERE rank_position = 1;
      




-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q4] At what point in the day do more crimes occur in a different locality?

SELECT 
    area_name, 
	time_period, 
	crime_count
FROM( SELECT 
		area_name, 
		time_period, 
		crime_count,
        RANK() OVER(PARTITION BY area_name ORDER BY crime_count DESC) AS rank_position
             FROM (SELECT 
					  area_name, 
					  time_f(incident_time) AS time_period, 
					  COUNT(*) AS crime_count
					  FROM rep_loc_off_v
					  GROUP BY 1,2) 
              AS crime_count) AS crimes
WHERE rank_position = 1;




-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q5] Which age group of people is more likely to fall victim to crimes at certain points in the day?

SELECT
	age_grade,
    time_period,
    crime_count
FROM( SELECT
		age_grade,
		time_period,
		crime_count,
		rank() OVER (PARTITION BY age_grade ORDER BY crime_count ) AS rank_position
      FROM(SELECT 
			age_f(victim_age) AS age_grade,
			time_f(incident_time) AS time_period,
			count(*) AS crime_count
	      FROM rep_vict_v
	      GROUP BY 1,2) AS crime)
	AS ranked_crimes
WHERE rank_position = 5;
     


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q6] What is the status of reported crimes?.

SELECT
    CASE_STATUS_DESC,
    COUNT(*) AS crime_count
FROM rep_loc_off_v
GROUP BY 1;






-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q7] Does the existence of CCTV cameras deter crimes from happening?
SELECT 
    AREA_name,
    CCTV_COUNT AS no_of_cctvs, 
    COUNT(*) AS crime_rate
FROM 
    rep_loc_off_v
GROUP BY 
    AREA_name, 
    CCTV_COUNT
ORDER BY 
    AREA_name, 
    CCTV_COUNT DESC;
      
      
      

-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q8] How much footage has been recovered from the CCTV at the crime scene?

SELECT 
    AREA_NAME,
    SUM(CASE WHEN CCTV_FLAG = 'TRUE' THEN 1 ELSE 0 END) AS footage_available,
    SUM(CASE WHEN CCTV_FLAG = 'FALSE' THEN 1 ELSE 0 END) AS footage_not_available,
    COUNT(*) AS total_crimes
FROM 
    rep_loc_off_v
GROUP BY 
    1
ORDER BY 
    1;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q9] Is crime more likely to be committed by relation of victims than strangers?

SELECT 
    crime_type,
    COUNT(CASE WHEN offender_relation = 'yes' THEN 1 ELSE NULL END) AS crimes_by_relation,
    COUNT(CASE WHEN offender_relation = 'no' THEN 1 ELSE NULL END) AS crimes_by_stranger,
	      CASE WHEN COUNT(CASE WHEN offender_relation = 'yes' THEN 1 ELSE NULL END) > 
             COUNT(CASE WHEN offender_relation = 'no' THEN 1 ELSE NULL END)
		  THEN 'LIKELY BY RELATION'
		  ELSE 'LIKELY BY STRANGERS' END AS possibility_crime
FROM 
    rep_vict_v
GROUP BY 
    crime_type
ORDER BY 
    crime_type;




-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q10] What are the methods used by the public to report a crime? 
SELECT 
    complaint_type,
    COUNT(*) AS crime_count
FROM 
    rep_loc_off_v
GROUP BY 
    complaint_type
ORDER BY 
    crime_count DESC;



-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



