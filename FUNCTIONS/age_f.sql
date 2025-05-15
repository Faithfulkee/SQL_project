DELIMITER //

CREATE FUNCTION age_f(victim_age INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE age_group VARCHAR(20);
    
    IF victim_age BETWEEN 0 AND 12 THEN
        SET age_group = 'Kids';
    ELSEIF victim_age BETWEEN 13 AND 23 THEN
        SET age_group = 'Teenage';
    ELSEIF victim_age BETWEEN 24 AND 35 THEN
        SET age_group = 'Middle age';
    ELSEIF victim_age BETWEEN 36 AND 55 THEN
        SET age_group = 'Adults';
    ELSEIF victim_age BETWEEN 56 AND 120 THEN
        SET age_group = 'Old';
    ELSE
        SET age_group = 'Unknown';
    END IF;
    
    RETURN age_group;
END //

DELIMITER ;
