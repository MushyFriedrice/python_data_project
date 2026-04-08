--1
SELECT
    c.name AS company_name,
    Round(avg(j.salary_year_avg) :: numeric, 0) AS avg_salary
FROM job_postings_fact j
JOIN company_dim c ON
    j.company_id = c.company_id
GROUP BY
    c.name
HAVING
      Round(avg(j.salary_year_avg) :: numeric, 0) is not null