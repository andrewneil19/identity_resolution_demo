--SELECT * from `county_officials_demo.officials`;


CREATE OR REPLACE TABLE `county_officials_demo.candidates` AS
--Find candidate pairs using joins
WITH candidates as ( 
  SELECT
    a.record_id as record_a_id,
    a.name_raw as name_a,
    a.title_raw as title_a,
    a.source as source_a,
    b.record_id as record_b_id,
    b.name_raw as name_b,
    b.title_raw as title_b,
    b.source as source_b,
    a.true_id as true_id_a,
    b.true_id as true_id_b
  FROM `county_officials_demo.officials` a
  JOIN `county_officials_demo.officials` b
    ON a.location = b.location --Only compare within same county
  WHERE a.record_id < b.record_id --Exclude duplicate pairs and self-comparison
    AND a.source <> b.source --Only look across sources
)
SELECT * FROM candidates

