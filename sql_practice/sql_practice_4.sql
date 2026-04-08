--4
WITH job_rank AS(
    SELECT 
        job_id,
        salary_year_avg AS salary,
        dense_rank() OVER(ORDER BY salary_year_avg DESC) AS rank
    FROM job_postings_fact
    WHERE
        salary_year_avg is NOT NULL 
)
SELECT
    *
FROM job_rank
WHERE
    rank <= 3