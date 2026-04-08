WITH country_category_revenue AS (
    SELECT
        c.countryfull as country,
        p.categoryname as category,
        Round(sum(s.quantity * s.netprice * s.exchangerate) :: numeric, 0) as category_revenue
    FROM sales s
    LEFT JOIN product p on s.productkey = p.productkey
    LEFT JOIN customer c on s.customerkey = c.customerkey
    WHERE
        EXTRACT(YEAR FROM s.orderdate) = 2024 and
        extract(quarter from s.orderdate) = 1
    GROUP BY c.countryfull, p.categoryname
)
SELECT
    *,
    sum(category_revenue) OVER (PARTITION BY country) as total_revenue,
    Round((category_revenue / sum(category_revenue) OVER (PARTITION BY country)) * 100, 2) as revenue_percentage
FROM country_category_revenue  

/* computers take up a significant percent of revenue shares in all the countries, with more than 30 percent in all the cases
the revenue distribution is not balanced in any of the countries, further investigation is required to find the reason behind this, 
and to find out if there are any other factors that are contributing to this imbalance. */