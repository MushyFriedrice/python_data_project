SELECT
    j.job_title_short as job_title,
    c.name as company_name,
    string_agg(s.skills, ',') as skills
FROM job_postings_fact j
JOIN skills_job_dim sk ON
    j.job_id = sk.job_id
JOIN skills_dim s ON
    sk.skill_id = s.skill_id
JOIN company_dim c ON
    j.company_id = c.company_id
WHERE 
    j.job_title_short = 'Data Analyst' 
GROUP BY
    j.job_title_short,
    c.name


with median_salary_cte as(
    select
        s.skills as job_skills,
        percentile_cont(0.5) within group(order BY j.salary_year_avg) as median_salary
    from job_postings_fact j
    JOIN skills_job_dim sk ON
        j.job_id = sk.job_id
    JOIN skills_dim s ON
        sk.skill_id = s.skill_id
    where
        j.job_title_short = 'Data Analyst'
    group by s.skills
    order BY median_salary desc

)
select 
    *
from median_salary_cte
where median_salary is not null 
