--1
SELECT
    customerkey,
    Round(sum(quantity * netprice * exchangerate) :: numeric, 0) as total_revenue
FROM sales
GROUP BY
    customerkey

--2
SELECT
    customerkey,
    Round(sum(quantity * netprice * exchangerate) :: numeric, 0) as total_revenue
FROM sales
GROUP BY
    customerkey
ORDER BY
    total_revenue DESC
limit 5

--3
SELECT
    customerkey
    --Round(sum(quantity * netprice * exchangerate) :: numeric, 0) as total_revenue
FROM sales
GROUP BY
    customerkey
having
    Round(sum(quantity * netprice * exchangerate) :: numeric, 0) is Null


