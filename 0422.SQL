-- ���� �����ͺ��̽� Ȯ��
-- https://www.sqlservertutorial.net/sql-server-basics/sql-server-insert/
SELECT DB_NAME();

-- �����ͺ��̽� > ���̺�(pandas ������������)
-- �����ͺ��̽� �ȿ� �ִ� ��
---- ���̺� �ܿ���, view, ���ν���, Ʈ����, ����� ���� �Լ� �� ����
-- SQL, SQEL : E - English
-- ������ ���� ������ �ſ� ������
-- ǥ�� SQL, 99% ���, 1% �ٸ� => ������Ÿ�� �� �� ���̰� �� ���� (DB ��������)
-- identity �Լ� ���� https://learn.microsoft.com/ko-kr/troubleshoot/sql/database-engine/connect/network-related-or-instance-specific-error-occurred-while-establishing-connection
-- CREATE TABLE promotions(
--     promotion_id INT PRIMARY KEY IDENTITY(1, 1),
--     promotion_name VARCHAR(255) NOT NULL
-- );
-- drop table promotions;
-- ������ �߰�
-- INSERT ����, �������� �е���, �� �����������ӿ�ũ�� �����ؼ� ó��
--INSERT INTO PROMOTIONS(
--    PROMOTION_NAME
--)
--VALUES(
--    '2025 SUMMER PROMOTION'
--);

--SELECT * FROM promotions; -- ���� ���忡�� �̷��� ����, ����� ���� ����


--select * from INFORMATION_SCHEMA.tables;

--select * from INFORMATION_SCHEMA.columns where table_name='Bikestore';

-- ����� ����
--use Bikestore;
-- ������ Ȯ��
--select * from production.brands;

--use F_Test;
--select employee_id, employee_name, birth_date From staff;

--select employee_id, birth_date AS '���� ����'
--from staff;

-- Distinct �ߺ��� ����
--select distinct gender from staff;

-- ���ڿ� �Լ� 
-- select * from apparel_product_info;
select product_id, left(product_id,2) as ���
from apparel_product_info;

-- substring ���ڿ� �߰� N��° �ڸ����� N���� ���
-- substring(column name, start num, end num)
select product_id, substring(product_id, 0,1) as ���
from apparel_product_info;

-- concat ���ڿ��� ���ڿ� �̾ ���
select CONCAT(category1, '>', category2, '=')
from apparel_product_info;

-- replace : 문자열에서 특정 문자 변경
select product_id, REPLACE(product_id, 'F', 'A')AS 결과
FROM apparel_product_info;

 -- isnull 중요함
 -- where 절과 함께 쓰일 때 자주 활용되는 방법
 -- 데이터상 결측치가 존재할 떄 꼭 필요한 함수
 select * from apparel_product_info;

 -- 숫자함수
-- sign
select sign(-125), sign(0), sign(564)

-- ceiling : 특정 숫자 올림
select * from sales;
select sales_amount_usd, ceiling(sales_amount_usd) as 결과
from sales;

-- 날짜 함수 : 공식문서 참조
-- getdate : 공식문서 참조 https://learn.microsoft.com/ko-kr/sql/t-sql/functions/getdate-transact-sql?view=sql-server-ver16
-- dateadd : 공식문서 참조 https://learn.microsoft.com/ko-kr/sql/t-sql/functions/dateadd-transact-sql?view=sql-server-ver16
-- daatediff : 두 날짜 사이의 기간 및 시간 차이, p255
	-- 활용 시점: 이탈율, 재구매율
select order_date, dateadd(year, -1, order_date) as 결과1,
dateadd(year, +2, order_date) as 결과2,
dateadd(day, +2, order_date) as 결과3 from sales;

select order_date, dateadd(year, -1, order_date) as 결과1,
dateadd(year, +2, order_date) as 결과2,
dateadd(day, +40, order_date) as 결과3 from sales;

-- p.72 datediff
select order_date, datediff(month, order_date, '2025-04-22') 함수적용결과1, 
datediff(day, order_date, '2025-04-22') 함수적용결과2 from sales

select datediff(day, '2002-04-16', '2025-04-22'); -- 태어난 날

-- p.74 순위함수, 윈도우 함수
-- rank, 아래 예시 자세히 x
select 학생, 수학점수, RANK() OVER(order by 수학점수 desc) as rank등수,
DENSE_RANK() OVER(order by 수학점수 desc) as dense_rank,
dense_rank() OVER(order by 수학점수 desc) as row_num
from student_math_score;

-- partition by
-- oveer(order by) : 전체 중 몇등
-- over(partition by class order by) : 반 별로 나웠을 때 반에서 몇등
select 학생, class, 수학점수,
DENSE_RANK() OVER(order by 수학점수 desc) as 전교등수,
dense_rank() OVER(PARTITION BY class ORDER BY 수학점수 desc) as 반등수
from student_math_score;

-- 집계함수

-- case문, 조건문 (if문 대신 x) https://learn.microsoft.com/ko-kr/sql/t-sql/language-elements/if-else-transact-sql?view=sql-server-ver16
-- 값이 0보다 작다면 '환불거래' 0보다 크면 '정상거래'로 분류
SELECT sales_amount, case when sales_amount < 0 then '환불거래'
                        when sales_amount > 0 then '정상거래' 
                    end as 적용결과 
from sales;