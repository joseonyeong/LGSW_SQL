-- 1. LAG() 함수 기본: 이전 행의 값 가져오기
-- 각 직원별로 현재 연도와 이전 연도의 매출 비교
-- LAG() 함수는 현재 행을 기준으로 이전 행의 값을 참조할 수 있게 해주는 윈도우 함수입니다.
-- 실전문제
-- 1. 각 주문의 현재 주문금액과 이전 주문금액의 차이를 계산하시오. 
-- 1. 각 주문의 현재 주문금액과 이전 주문금액의 차이를 계산
-- 1) orders와 orderdetails 테이블을 조인하여 주문별 총액을 계산하는 서브쿼리 작성
-- 2) LAG 함수를 사용하여 이전 주문 금액을 가져옴 (orderDate 기준)
-- 3) 현재 주문금액 - 이전 주문금액으로 차이 계산
SELECT 
    orderNumber,
    orderDate,
    totalAmount,
    LAG(totalAmount) OVER (ORDER BY orderDate) as prev_amount,
    totalAmount - LAG(totalAmount) OVER (ORDER BY orderDate) as amount_difference
FROM (
    SELECT 
        o.orderNumber,
        o.orderDate,
        SUM(quantityOrdered * priceEach) as totalAmount
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY o.orderNumber, o.orderDate
) A
ORDER BY orderDate;

-- 2. 각 고객별로 주문금액과 직전 주문금액을 비교하여 증감률을 계산하시오
-- 2. 각 고객별 주문금액과 직전 주문금액의 증감률 계산
-- 1) orders, orderdetails 테이블 조인하여 고객별, 주문일자별 총 주문금액 계산 (서브쿼리)
-- 2) LAG 함수로 각 고객별 이전 주문금액 가져오기 (PARTITION BY customerNumber)
-- 3) (현재주문금액 - 이전주문금액) / 이전주문금액 * 100 으로 증감률 계산
-- 4) ROUND 함수로 소수점 2자리까지 표시

SELECT 
    customerNumber,
    orderDate,
    orderAmount,
    LAG(orderAmount) OVER (PARTITION BY customerNumber ORDER BY orderDate) as prev_amount,
    ROUND(((orderAmount - LAG(orderAmount) OVER (PARTITION BY customerNumber ORDER BY orderDate)) / 
    LAG(orderAmount) OVER (PARTITION BY customerNumber ORDER BY orderDate) * 100), 2) as growth_rate
FROM (
    SELECT 
        o.customerNumber,
        o.orderDate,
        SUM(quantityOrdered * priceEach) as orderAmount
    FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY o.customerNumber, o.orderDate
) A
ORDER BY customerNumber, orderDate;

-- 3. 각 제품라인별로 3개월 이동평균 매출액을 계산하시오
-- 3. 각 제품라인별 3개월 이동평균 매출액 계산
-- 1) products, orderdetails, orders 테이블 조인하여 제품라인별, 월별 매출액 계산 (서브쿼리)
-- 2) DATE_FORMAT 함수로 orderDate를 월 단위로 그룹화
-- 3) AVG 함수와 OVER절을 사용하여 3개월 이동평균 계산
--    - PARTITION BY로 제품라인별 그룹화
--    - ROWS BETWEEN 2 PRECEDING AND CURRENT ROW로 현재행 포함 이전 2개 행까지의 평균 계산
		-- 해당 위에 rows 머시기는 몇개월 단위인 결과를 낼 때 사용
-- 4) ROUND 함수로 소수점 2자리까지 표시
-- 그룹바이가 핵심
SELECT 
    productLine,
    orderDate,
    monthly_sales,
    ROUND(AVG(monthly_sales) OVER (
        PARTITION BY productLine 
        ORDER BY orderDate 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) as moving_average_3months
FROM (
    SELECT 
        p.productLine,
        DATE_FORMAT(o.orderDate, '%Y-%m-01') as orderDate,
        SUM(od.quantityOrdered * od.priceEach) as monthly_sales
    FROM products p
    JOIN orderdetails od ON p.productCode = od.productCode
    JOIN orders o ON od.orderNumber = o.orderNumber
    GROUP BY p.productLine, DATE_FORMAT(o.orderDate, '%Y-%m-01')
) A
ORDER BY productLine, orderDate;

