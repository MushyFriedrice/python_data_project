--6
WITH skill_median AS(
    SELECT
        s.skills AS skill,
        percentile_cont(0.5) within group(order by j.salary_year_avg) as median_salary,
        count(*) as job_count
    FROM job_postings_fact j
    JOIN skills_job_dim sd ON
        j.job_id = sd.job_id
    JOIN skills_dim s ON
        sd.skill_id = s.skill_id
    WHERE 
        j.job_title_short = 'Data Analyst'
        AND j.salary_year_avg IS NOT NULL
    GROUP BY
        s.skills
    HAVING 
        COUNT(*) > 20
), skill_rank as(
    select
        *,
        dense_rank() over(order by median_salary desc) as rank
    from skill_median
)
select
    *
from skill_rank
where
     rank <= 5