--3
SELECT
    j.job_id,
    c.name AS company_name,
    string_agg(s.skills, ',') skills
FROM job_postings_fact j
JOIN skills_job_dim sd ON
    j.job_id = sd.job_id
JOIN skills_dim s ON
    sd.skill_id = s.skill_id
JOIN company_dim c ON
    j.company_id = c.company_id
WHERE
    j.job_title_short = 'Data Analyst'
GROUP BY
    j.job_id,
    c.name
