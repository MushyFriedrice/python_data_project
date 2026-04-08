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
), customer_months AS (
    SELECT
        s.customerkey,
        DATE_TRUNC('month', s.orderdate) AS order_month
    FROM sales s
    JOIN top_customers tc
        ON s.customerkey = tc.customerkey
    GROUP BY
        s.customerkey,
        order_month
), customer_activity AS (
    SELECT
        customerkey,
        order_month,
        LAG(order_month) OVER (
            PARTITION BY customerkey 
            ORDER BY order_month
        ) AS prev_month
    FROM customer_months
), customer_status AS (
    SELECT
        customerkey,
        order_month,
        prev_month,
        
        CASE 
            WHEN prev_month IS NULL THEN 'new'
            WHEN order_month = prev_month + INTERVAL '1 month' THEN 'retained'
            ELSE 'churn_gap'
        END AS status
    FROM customer_activity
    ORDER BY customerkey, order_month
)
SELECT
    status,
    count(DISTINCT customerkey) AS customer_count,
    ROUND(
        COUNT(DISTINCT customerkey) * 100.0 / 
        SUM(COUNT(DISTINCT customerkey)) OVER (), 2
    ) AS percentage
FROM customer_status
GROUP BY status
order by customer_count DESC