DELIMITER //

CREATE FUNCTION time_f(incident_time TIME)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE daypart VARCHAR(20);
    
    IF incident_time BETWEEN '00:00:00' AND '05:00:00' THEN
        SET daypart = 'Midnight';
    ELSEIF incident_time BETWEEN '05:01:00' AND '12:00:00' THEN
        SET daypart = 'Morning';
    ELSEIF incident_time BETWEEN '12:01:00' AND '18:00:00' THEN
        SET daypart = 'Afternoon';
    ELSEIF incident_time BETWEEN '18:01:00' AND '21:00:00' THEN
        SET daypart = 'Evening';
    ELSE
        SET daypart = 'Night';
    END IF;
    
    RETURN daypart;
END //

DELIMITER ;
