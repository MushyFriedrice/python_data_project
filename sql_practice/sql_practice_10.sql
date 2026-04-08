WITH customer_revenue AS (
    SELECT
        customerkey,
        sum(quantity * netprice * exchangerate) AS total_revenue,
        dense_rank() OVER (ORDER BY sum(quantity * netprice * exchangerate) DESC) AS revenue_rank,
        percent_rank() over(ORDER BY sum(quantity * netprice * exchangerate) DESC) AS revenue_percent_rank
    FROM sales
    GROUP BY
        customerkey
)
SELECT
    customerkey,
    round(total_revenue :: numeric, 0) AS total_revenue,
    revenue_rank,
    revenue_percent_rank
FROM customer_revenue
WHERE 
    revenue_percent_rank <= 0.2