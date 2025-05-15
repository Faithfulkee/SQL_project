USE `la_crime`;
DROP procedure IF EXISTS `la_crime_officer_p`;

DELIMITER $$
USE `la_crime`$$
CREATE PROCEDURE la_crime_officer_p ()
BEGIN
INSERT INTO la_crime_officer_t (
    officer_code,
    officer_name,
    officer_sex,
    avg_close_days,
    precinct_code
)
SELECT DISTINCT
    officer_code,	
    officer_name,
    officer_sex,
    avg_close_days,
    precinct_code
FROM la_crime_t WHERE officer_code NOT IN ( SELECT DISTINCT officer_code FROM la_crime_officer_t);

END$$

DELIMITER ;

