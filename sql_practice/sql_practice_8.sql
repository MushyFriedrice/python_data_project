--4
WITH customer_revenue AS(
    SELECT
        customerkey,
        Round(sum(quantity * netprice * exchangerate) :: numeric, 0) as total_revenue
    FROM sales
    GROUP BY
        customerkey
)
select
    *,
    dense_rank() over(order by total_revenue desc) as rank
from customer_revenue

--5
with customer_sum as(
    SELECT
        customerkey,
        Round(sum(quantity * netprice * exchangerate) :: numeric, 0) as total_revenue
    FROM sales
    GROUP BY
        customerkey
), sum_avg as(
    select
        *,
        round(avg(total_revenue) over() :: numeric, 0) as avg_revenue
    from customer_sum
)
select
    *
from sum_avg
where total_revenue > avg_revenue

--6
WITH customer_revenue AS (
    SELECT
        customerkey,
        SUM(quantity * netprice * exchangerate) AS total_revenue
    FROM sales
    GROUP BY customerkey
),
ranked_customers AS (
    SELECT
        customerkey,
        total_revenue,
        PERCENT_RANK() OVER (ORDER BY total_revenue DESC) AS pct_rank
    FROM customer_revenue
)

SELECT *
FROM ranked_customers
WHERE pct_rank <= 0.1;