--5
SELECT
    s.skills AS skill,
    count(*) AS demand_count
FROM job_postings_fact j
JOIN skills_job_dim sd ON
    j.job_id = sd.job_id
JOIN skills_dim s ON
    sd.skill_id = s.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
GROUP BY
    s.skills
ORDER BY
     count(*) DESC
LIMIT 5 