-- How many unique age groups, genders, and countries are represented?
SELECT 
COUNT(DISTINCT age_group, gender, region)
FROM zappi_brand_loyalty_survey_csv;

-- What is the distribution of respondents by age category?
SELECT age_category, COUNT(*) AS total_res
FROM zappi_brand_loyalty_survey_csv
GROUP BY age_category 
ORDER BY total_res DESC;

-- What is the gender breakdown of all respondents?
SELECT gender, COUNT(*) AS total_gen
FROM zappi_brand_loyalty_survey_csv
GROUP BY gender
ORDER BY total_gen;

-- Which age group has the highest number of promoters?
SELECT age_group, COUNT(*) AS promoter_count
FROM zappi_brand_loyalty_survey_csv
WHERE nps_category = 'Promoter'
GROUP BY age_group
ORDER BY promoter_count DESC
LIMIT 1;

-- Which gender group has the lowest average NPS score?
SELECT gender, AVG(nps_score) AS low_nps
FROM zappi_brand_loyalty_survey_csv
GROUP BY gender
ORDER BY low_nps ASC
LIMIT 1;

-- What is the average NPS score overall?
SELECT AVG(nps_score) AS average_nps
FROM zappi_brand_loyalty_survey_csv;

-- What is the NPS score breakdown by age, gender, and country?
SELECT 
  age_group,
  gender,
  region,
  nps_category,
  COUNT(*) AS response_count
FROM zappi_brand_loyalty_survey_csv
GROUP BY age_group, gender, region, nps_category
ORDER BY age_group, gender, region, nps_category;

-- Which demographic segment is most likely to be a detractor?
SELECT 
  age_group,
  gender,
  region,
  COUNT(*) AS detractor_count
FROM zappi_brand_loyalty_survey_csv
WHERE nps_category = 'Detractor'
GROUP BY age_group, gender, region
ORDER BY detractor_count DESC
LIMIT 1;

-- How many people are considered loyal (NPS 9–10)?
SELECT COUNT(*) AS loyal
FROM zappi_brand_loyalty_survey_csv
WHERE nps_score BETWEEN 9 AND 10;

-- Are loyal customers more likely to come from certain countries or age groups?
SELECT 
age_group,
region,
COUNT(*) AS total_loyal
FROM zappi_brand_loyalty_survey_csv
WHERE nps_score BETWEEN 9 AND 10
GROUP BY age_group, region
ORDER  BY total_loyal DESC;

-- Do passives and detractors share any common characteristics?
SELECT 
age_group,
region,
gender,
COUNT(*) AS common_charac
FROM zappi_brand_loyalty_survey_csv
WHERE nps_category IN ('passive' OR 'detractors')
GROUP BY age_group, region, gender
ORDER BY common_charac DESC;

-- Are there any missing or NULL values?
SELECT 
  COUNT(*) AS total_rows,
  COUNT(*) - COUNT(respondent_id) AS null_respondent_id,
  COUNT(*) - COUNT(age_group) AS null_age_group,
  COUNT(*) - COUNT(gender) AS null_gender,
  COUNT(*) - COUNT(region) AS null_region,
  COUNT(*) - COUNT(region) AS null_region,
  COUNT(*) - COUNT(income_level) AS null_income_level,
COUNT(*) - COUNT(ad_version_seen) AS null_ad_version_seen,
  COUNT(*) - COUNT(nps_score) AS null_nps_score,
  COUNT(*) - COUNT(nps_category) AS null_nps_category
FROM zappi_brand_loyalty_survey_csv;

-- Which age category is most loyal and should be prioritized?
SELECT 
age_group,
COUNT(*) AS total_loyal
FROM zappi_brand_loyalty_survey_csv
WHERE nps_category = 'promoter'
GROUP BY age_group
ORDER BY total_loyal DESC;

-- Which age group needs more re-engagement?
SELECT 
age_group,
COUNT(*) AS total_reengage 
FROM zappi_brand_loyalty_survey_csv
WHERE nps_category = 'Detractor'
GROUP BY age_group
ORDER BY total_reengage DESC;

-- How can we increase NPS among low-performing groups?
SELECT 
  region,
  gender,
  income_level,
  feedback_comment,
  nps_score
FROM zappi_brand_loyalty_survey_csv
WHERE nps_score BETWEEN 0 AND 6  -- Detractors
ORDER BY nps_score ASC;

-- Where should marketing focus based on region performance?
SELECT 
region, 
COUNT(*) AS region_performance 
FROM zappi_brand_loyalty_survey_csv
WHERE nps_category = 'promoter'
GROUP BY region
ORDER BY region_performance DESC;








