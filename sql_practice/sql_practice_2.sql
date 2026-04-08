--2
SELECT
    c.name AS company_name,
    Round(avg(j.salary_year_avg) :: numeric, 0) AS avg_salary,
    count(*) AS job_count
FROM job_postings_fact j
JOIN company_dim c ON
    j.company_id = c.company_id
WHERE
    j.job_title_short = 'Data Analyst'
GROUP BY
    c.name
HAVING
      Round(avg(j.salary_year_avg) :: numeric, 0) is not null AND
      count(*) >= 10