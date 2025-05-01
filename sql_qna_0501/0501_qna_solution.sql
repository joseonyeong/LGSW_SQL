USE testdb;

-- 연습문제 1. SELECT 조건 고객포인트 테이블의 모든 필드를 검색한다. 
SELECT * 
FROM  TB_POINT;

-- 연습문제 2. SELECT 조건 고객포인트 테이블에서 고객코드, 포인트내용, 포인트를 검색한다. 
SELECT CUSTOMER_CD, POINT_MEMO, POINT
FROM   TB_POINT;

-- 연습문제 3. SELECT 조건  고객포인트 테이블에서 고객코드, 포인트내용, 포인트 필드 제목을 한글로 출력한다. 
SELECT CUSTOMER_CD AS "*고객코드", 
       POINT_MEMO AS "포인트 내용",
       POINT AS 포인트
FROM   TB_POINT;

-- 연습문제 4. WHERE 조건
-- 고객관리 테이블에서 누적포인트가 10,000 미만인 데이터의 고객코드, 고객명, 이메일, 누적포인트 필드를 검색한다.
SELECT CUSTOMER_CD, CUSTOMER_NM, EMAIL, TOTAL_POINT
FROM   TB_CUSTOMER
WHERE  TOTAL_POINT < 10000;

-- 연습문제 5. WHERE-AND 조건
-- 고객포인트 테이블에서 고객코드가 ‘2017053’이면서 일련번호가 2인 데이터의 고객코드, 일련번호, 포인트 필드를 검색한다.
SELECT CUSTOMER_CD,
       SEQ_NO,
       POINT
FROM   TB_POINT
WHERE  CUSTOMER_CD = '2017053'
AND    SEQ_NO = 2;

-- 연습문제 6. WHERE-OR 조건
-- 성적 테이블에서 반코드가 ‘A’ 또는 ‘B’이거나 국어, 영어, 수학 점수가 모두 80점 이상인 학생 필드를 검색한다.
UPDATE TB_GRADE
SET    TOT = KOR + ENG + MAT,
       AVG = ROUND((KOR + ENG + MAT) / 3,1);
SELECT * FROM TB_GRADE;

SELECT *
FROM   TB_GRADE
WHERE  (CLASS_CD = 'A' OR  CLASS_CD = 'B') OR 
        (KOR >= 80 AND ENG >= 80 AND MAT >= 80);
        
-- 연습문제 7. WHERE BETWEEN 조건
-- 고객포인트 테이블에서 등록일시가 2018년 내에 있고, 포인트가 10,000에서 50,000 포인트 범위의 데이터를 검색한다.
SELECT *
FROM   TB_POINT
WHERE  REG_DTTM BETWEEN '20180101000000' AND '20181231235959'
AND    POINT BETWEEN 10000 AND 50000;

-- 연습문제 8. 비교연산자
-- 고객 테이블에서 누적포인트가 20,000 이상인 1980년대 남성 고객의 고객코드, 고객명, 성별, 생년월일, 누적포인트를 검색한다.
SELECT CUSTOMER_CD,
       CUSTOMER_NM,
       MW_FLG,
       BIRTH_DAY,
       TOTAL_POINT
FROM   TB_CUSTOMER
WHERE  TOTAL_POINT >= 20000
AND    BIRTH_DAY >= '19800101' AND BIRTH_DAY <= '19891231'
AND    MW_FLG = 'M';

-- 연습문제 9. MONTH, AND, IN
-- 고객 테이블에서 남성이면서 생년월일 중 월이 5, 6, 7월인 고객의 고객코드, 고객명, 성별, 생년월일, 누적포인트를 검색한다.
SELECT CUSTOMER_CD,
       CUSTOMER_NM,
       MW_FLG,
       BIRTH_DAY,
       TOTAL_POINT
FROM   TB_CUSTOMER
WHERE  MW_FLG = 'M'
AND    MONTH(BIRTH_DAY) IN (5, 6, 7);

-- 연습문제 10. LIKE
-- 고객 테이블에서 고객코드가 ‘2017’로 시작하면서 남성인 고객 또는 고객코드가 ‘2019’로 시작하면서 여성인 고객을 구하고, 그 중 누적포인트가 30000 이하인 데이터를 검색한다.
SELECT CUSTOMER_CD,
       CUSTOMER_NM,
       MW_FLG,
       BIRTH_DAY,
       TOTAL_POINT
FROM   TB_CUSTOMER
WHERE  ((CUSTOMER_CD LIKE '2017%'
AND      MW_FLG = 'M')
OR      (CUSTOMER_CD LIKE '2019%'
AND      MW_FLG = 'W'))
AND    TOTAL_POINT <= 30000;

-- 연습문제 11. IN 연산자 
-- 품목정보 테이블에서 품목코드가 'S01’, ‘S04’, ‘S06’, ‘S10’인 데이터를 검색한다.
SELECT * 
FROM   TB_ITEM_INFO
WHERE  ITEM_CD IN ('S01','S04','S06','S10');

-- 연습문제 12. IN 연산자 
-- 고객포인트 테이블에서 고객코드가 ‘2017042’ 또는 ‘2018087’ 또는 '2019095' 이면서 포인트내용에 ‘구매’ 문자가 포함된 데이터를 검색한다.
SELECT * 
FROM   TB_POINT
WHERE  CUSTOMER_CD IN ('2017042','2018087','2019095')
AND    POINT_MEMO LIKE '%구매%';

-- 연습문제 13. ORDER BY 
-- 고객포인트 테이블에서 등록일이 '2019＇년이고 포인트내용에 '구매'가 포함된 데이터를 포인트가 큰 순서대로 검색한다.
SELECT *
FROM   TB_POINT
WHERE  REG_DTTM LIKE '2019%'
AND    POINT_MEMO LIKE '%구매%'
ORDER  BY POINT DESC;

-- 연습문제 14. ORDER BY 
-- 성적 테이블에서 ‘B’반의 국어, 영어, 수학 점수의 합계가 높은 순으로 검색한다.
UPDATE TB_GRADE
SET    TOT = KOR + ENG + MAT,
       AVG = ROUND((KOR + ENG + MAT) / 3,1);
SELECT * FROM TB_GRADE;

SELECT KOR, ENG, MAT, TOT AS 합계
FROM   TB_GRADE
WHERE  CLASS_CD = 'B'
ORDER  BY KOR + ENG + MAT DESC;

-- 연습문제 15. GROUP BY
-- 판매 테이블에서 판매일이 ‘20190802’ 또는 ‘20190803’을 대상으로 판매일과 상품명으로 그룹화해 총판매수를 구하고 판매일과 상품명은 가나다 순으로 보인다.
SELECT SALES_DT,
       PRODUCT_NM,
       SUM(SALES_COUNT) AS "총판매수"
FROM   TB_SALES
WHERE  SALES_DT IN ('20190802','20190803')
GROUP  BY SALES_DT,
          PRODUCT_NM
ORDER  BY SALES_DT,
          PRODUCT_NM;

-- 연습문제 16. DISTINCT 
-- 판매 테이블에서 '20190801＇에서 ‘20190802’ 기간에 판매한 상품명을 가나다 순으로 중복없이 검색한다.
SELECT DISTINCT PRODUCT_NM
FROM   TB_SALES
WHERE  SALES_DT BETWEEN '20190801' AND '20190802'
ORDER  BY PRODUCT_NM;

-- 연습문제 17. JOIN
-- 고객 테이블의 고객코드가 2019069 데이터를 고객포인트 테이블과 연관 검색하여 고객 테이블에서는 고객코드, 고객명, 성별을 검색한 후 고객포인트 테이블에서는 일련번호, 포인트내용, 포인트를 검색한다.
-- 답안 1. 

SELECT CU.CUSTOMER_CD,
       CU.CUSTOMER_NM,
       CU.MW_FLG,
       PT.SEQ_NO,
       PT.POINT_MEMO,
       PT.POINT
FROM   TB_CUSTOMER CU,
       TB_POINT PT
WHERE  CU.CUSTOMER_CD = '2019069'
AND    CU.CUSTOMER_CD = PT.CUSTOMER_CD;

SELECT CU.CUSTOMER_CD,
       CU.CUSTOMER_NM,
       CU.MW_FLG,
       PT.SEQ_NO,
       PT.POINT_MEMO,
       PT.POINT
FROM   TB_CUSTOMER CU
JOIN   TB_POINT PT
ON     CU.CUSTOMER_CD = PT.CUSTOMER_CD
WHERE  CU.CUSTOMER_CD = '2019069';

-- 연습문제 18. CASE
-- 고객 테이블에서 누적포인트가 1,000에서 20,000미만이면 “실버”, 20,000에서 50,000미만 이면 “골드”, 50,000이상이면 “VIP” 등급을 보이고 위 조건에 해당 없으면 “일반” 등급을 보인다.
SELECT CUSTOMER_CD,
       CUSTOMER_NM,
       TOTAL_POINT,
       CASE WHEN TOTAL_POINT BETWEEN 1000 AND 19999 THEN '실버'
            WHEN TOTAL_POINT BETWEEN 20000 AND 49999 THEN '골드'
            WHEN TOTAL_POINT >= 50000 THEN 'VIP'
            ELSE '일반'
       END AS "고객 등급"
FROM   TB_CUSTOMER;

-- 연습문제 19. ROWNUM
-- 성적 테이블에서 반코드가 ‘A’ 또는 ‘C’반의 학생을 대상으로 모든 필드와 순차적인 행번호를 검색한다.
-- PDF에서 TOT AVG는 무시한다. 
SELECT @ROWNUM:=@ROWNUM+1 AS ROWNUM,
       GD.*
FROM   TB_GRADE GD, (SELECT @rownum:=0) TMP
WHERE  GD.CLASS_CD IN ('A','C');

-- 연습문제 20. NULL
-- 고객 테이블에서 고객코드가 ‘2018’ 또는 ‘2019’로 시작하고, 생일이 1990년 또는 2000년 대인 고객 중 전화번호가 설정되어 있는 데이터를 검색한다.
SELECT *
FROM   TB_CUSTOMER
WHERE  (CUSTOMER_CD LIKE '2018%'
OR      CUSTOMER_CD LIKE '2019%')
AND    (BIRTH_DAY LIKE '199%'
OR      BIRTH_DAY LIKE '200%')
AND    PHONE_NUMBER IS NOT NULL;