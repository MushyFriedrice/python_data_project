--7
WITH customer_revenue AS(
    SELECT
        customerkey,
        Round(sum(quantity * netprice * exchangerate) :: numeric, 0) as total_revenue
    FROM sales
    GROUP BY
        customerkey 
)
SELECT
    customerkey,
    total_revenue,
    sum(total_revenue) over(order by customerkey) as cumulative_revenue
from customer_revenue

--8
select
    customerkey,
    percentile_cont(0.5) within group(order by quantity * netprice * exchangerate) as median_revenue
from sales
group by customerkey

--9
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
        sum(total_revenue) over() as total_revenue_sum,
        PERCENT_RANK() OVER (ORDER BY total_revenue DESC) AS pct_rank
    FROM customer_revenue
)
SELECT 
    Round(sum(total_revenue) :: numeric, 0) as top_20_percent_revenue,
    Round(max(total_revenue_sum) :: numeric, 0) as total_revenue_sum,
    Round((sum(total_revenue) *100.0 / max(total_revenue_sum)):: numeric, 2) as percentage_of_total_revenue
FROM ranked_customers
WHERE pct_rank <= 0.2

--10
WITH customer_revenue AS (
    SELECT
        customerkey,
        SUM(quantity * netprice * exchangerate) AS total_revenue
    FROM sales
    GROUP BY customerkey
),
segmented AS (
    SELECT
        customerkey,
        total_revenue,
        NTILE(10) OVER (ORDER BY total_revenue DESC) AS tile
    FROM customer_revenue
)

SELECT
    customerkey,
    total_revenue,
    CASE
        WHEN tile <= 2 THEN 'High'       -- Top 20%
        WHEN tile <= 5 THEN 'Medium'     -- Next 30%
        ELSE 'Low'                       -- Remaining 50%
    END AS category
FROM segmented;