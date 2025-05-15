CREATE TABLE la_crime_victim_t (
    victim_code INT,
    victim_name VARCHAR(50),
    victim_sex CHAR(1),
    victim_age INT,
    was_victim_alone VARCHAR(3),
    is_victim_insured VARCHAR(3),
    PRIMARY KEY (victim_code)
);
