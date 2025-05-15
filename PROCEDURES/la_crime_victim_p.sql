DELIMITER $$
CREATE PROCEDURE la_crime_victim_p ()
BEGIN
INSERT INTO la_crime_victim_t (
    victim_code,
    victim_name,
    victim_sex,
    victim_age,
    was_victim_alone,
    is_victim_insured
)
SELECT DISTINCT
    victim_code,
    victim_name,
    victim_sex,
    victim_age,
    was_victim_alone,
    is_victim_insured
FROM la_crime_t WHERE victim_code NOT IN (SELECT DISTINCT victim_code FROM la_crime_victim_t);

END;$$

DELIMITER ;

