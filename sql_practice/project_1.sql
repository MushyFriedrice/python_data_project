WITH customer_revenue AS (
    SELECT
        customerkey,
        sum(quantity * netprice * exchangerate) AS total_revenue,
        dense_rank() OVER (ORDER BY sum(quantity * netprice * exchangerate) DESC) AS revenue_rank,
        percent_rank() OVER (ORDER BY sum(quantity * netprice * exchangerate) DESC) AS revenue_percent_rank

    FROM sales
    GROUP BY customerkey
), top_customers AS (
    SELECT
        customerkey,
        round(total_revenue :: numeric, 0) AS total_revenue,
        revenue_rank,
        revenue_percent_rank
    FROM customer_revenue
    WHERE revenue_percent_rank <= 0.2
)
SELECT
    s.customerkey,
    TO_CHAR(s.orderdate, 'YYYY-MM') AS sales_month,
    ROUND(SUM(s.quantity * s.netprice * s.exchangerate) :: numeric, 0) AS monthly_revenue,
    tc.total_revenue,
    tc.revenue_rank,
    tc.revenue_percent_rank
FROM sales s
JOIN top_customers tc 
    ON s.customerkey = tc.customerkey
GROUP BY
    s.customerkey,
    sales_month,
    tc.total_revenue,
    tc.revenue_rank,
    tc.revenue_percent_rank
ORDER BY
    s.customerkey,
    sales_month

