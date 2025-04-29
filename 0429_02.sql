use classicmodels;

-- 일별 매출액 조회
-- 공통 ordernumber
select * from orders;
select * from orderdetails;

select A.orderDate, B.quantityOrdered * B.priceEach as revenue
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber;

-- 최종적으로 하고자 하는 것
-- 국가별 매출 순위, dense_rank()
select * from offices;
select * from customers;

select c.country, sum(od.quantityOrdered * od.priceEach) as revenu,
	dense_rank() over (order by sum(od.quantityOrdered * od.priceEach)DESC) as rnk
from customers c
left join orders o on c.customerNumber * o.customerNumber
left join orderdetails od on o.orderNumber = od.orderNumber
group by c.country
order by rnk limit 5;

select *
from (
    select 
        c.country
        , sum(od.quantityordered * od.priceEach) as revenue
        , dense_rank() over (order by sum(od.quantityordered * od.priceEach)desc) as rnk
    from customers c
    left join orders o on c.customerNumber = o.customerNumber
    left join orderdetails od on o.orderNumber = od.orderNumber
    group by c.country
) A
where rnk <=5
;

-- 비슷한 개념
-- 미국이 가장 많이 팔리고 있는 것 확인
-- 차량 모델 관련된 DB
-- 미국에서 가장 많이 팔리는 차량 모델 5개 구하기

select * from products;
select * from productlines;

select 
	p.productName
	, sum(od.quantityordered * od.priceEach) as revenue
	, dense_rank() over (order by sum(od.quantityordered * od.priceEach)desc) as rnk
from products p
left join orderdetails od on p.productCode = od.productCode
left join orders o on od.orderNumber = o.orderNumber
left join customers c on o.customerNumber = c.customerNumber
where c.country = 'USA'
group by 1
order by rnk limit 5;

-- lag 함수 : 이전 행의 값 가져오기
select sales_employee,
	fiscal_year,
    sale,
    lag(sale) over(partition by sales_employee
						order by fiscal_year) as prev_year_sale
from sales
order by 1,2;

select * from sales;
-- 각 직원별 전년 대비 매출 증가율 계산
select sales_employee,
	fiscal_year,
    sale,
    lag(sale) over(partition by sales_employee
						order by fiscal_year) as prev_year_sale,
	round((sale - lag(sale) over(partition by sales_employee
						order by fiscal_year)) / lag(sale) over(partition by sales_employee
						order by fiscal_year) * 100,1) as result
from sales
order by 1,2;

-- 1년 전, 2년 전 매출과 비교
select sales_employee,
	lag(sale,1,0) over(partition by sales_employee
						order by fiscal_year) as one_year_result,
	lag(sale,2,0) over(partition by sales_employee
						order by fiscal_year) as two_year_result
from sales
order by 1,2;


-- 연습 미리보기
-- 윈도우절? 윈도윙절?
SELECT 
    o.orderNumber,
    o.orderDate,
    SUM(od.quantityOrdered * od.priceEach) as orderValue,
    SUM(SUM(od.quantityOrdered * od.priceEach)) OVER (
        ORDER BY o.orderDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW -- 핵심
    ) as running_total
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY o.orderNumber, o.orderDate
ORDER BY o.orderDate
LIMIT 10;