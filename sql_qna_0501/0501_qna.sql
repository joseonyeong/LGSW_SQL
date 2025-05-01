-- 사전 준비 
-- Edit -> Preferences -> SQL Editor, 
-- "Safe Updates" 체크 박스 해제

--------------------------------------------------
-- 고객 테이블
--------------------------------------------------

SET SQL_SAFE_UPDATES=0;

CREATE SCHEMA `testdb` ;
USE testdb;

-- DROP TABLE TB_CUSTOMER;
CREATE TABLE TB_CUSTOMER
(
  CUSTOMER_CD      VARCHAR(7)                 NOT NULL,   -- 고객코드
  CUSTOMER_NM      VARCHAR(10)            NOT NULL,   -- 고객명
  MW_FLG           VARCHAR(1)                 NOT NULL,   -- 성별구분
  BIRTH_DAY        VARCHAR(8)                 NOT NULL,   -- 생일
  PHONE_NUMBER     VARCHAR(16),                       -- 전화번호
  EMAIL            VARCHAR(30),                       -- EMAIL
  TOTAL_POINT      INTEGER(10),                              -- 누적포인트
  REG_DTTM         VARCHAR(14)                            -- 등록일
);
CREATE UNIQUE INDEX PK_TB_CUSTOMER ON TB_CUSTOMER (CUSTOMER_CD);
ALTER TABLE TB_CUSTOMER ADD (CONSTRAINT PK_TB_CUSTOMER PRIMARY KEY (CUSTOMER_CD));

# DROP TABLE TB_CUSTOMER;
INSERT INTO TB_CUSTOMER VALUES ('2017042','강원진','M','19810603','002-8202-8790','wjgang@navi.com',280300, '20170123132432');
INSERT INTO TB_CUSTOMER VALUES ('2017053','나경숙','W','19891225','002-4509-0043','ksna#boram.co.kr',4500,  '20170210180930');
INSERT INTO TB_CUSTOMER VALUES ('2017108','박승대','M','19711430',NULL,'sdpark@haso.com',23450,  '20170508203450');
INSERT INTO TB_CUSTOMER VALUES ('2018087','서유리','W','19810925','003-1265-8372','urseo@epnt.co.kr',18700, '20180204160903');
INSERT INTO TB_CUSTOMER VALUES ('2018254','이혜옥','W','19839012','003_1287_9734','hylee@hansoft.com',570,  '20180619230805');
INSERT INTO TB_CUSTOMER VALUES ('2019001','김진숙','W','20010426','002-9842-0074','jskim$dreami,org',12820, '20190101080518');
INSERT INTO TB_CUSTOMER VALUES ('2019069','김한길','M','19920315',NULL,'hkkim@ssoya.com',15320,  '20190217110704');
INSERT INTO TB_CUSTOMER VALUES ('2019095','남궁소망','M','19620728','003-6273-8539',NULL,890,'20190312124558');
INSERT INTO TB_CUSTOMER VALUES ('2019167','한찬희','M','19711106','002=1202=5563','chhan@ecom.co.kr',6800,  '20190508155600');
INSERT INTO TB_CUSTOMER VALUES ('2019281','이아름','W','19940513','003-2620-0723','aulee@hoki.com',35600,   '20190709201308');

--------------------------------------------------
-- 포인트 테이블
--------------------------------------------------

CREATE TABLE TB_POINT
(
  CUSTOMER_CD      VARCHAR(7)                 NOT NULL,   -- 고객코드
  SEQ_NO           INTEGER(10)                   NOT NULL,   -- 일련번호
  POINT_MEMO       VARCHAR(50),                            -- 포인트 내용
  POINT            INTEGER(10),                              -- 포인트
  REG_DTTM         VARCHAR(14)                            -- 등록일
);
CREATE UNIQUE INDEX PK_TB_POINT ON TB_POINT (CUSTOMER_CD, SEQ_NO);
ALTER TABLE TB_POINT ADD (CONSTRAINT PK_TB_POINT PRIMARY KEY (CUSTOMER_CD, SEQ_NO));

-- DELETE FROM TB_POINT;
INSERT INTO TB_POINT VALUES ('2017042',1,'청소기 구매 포인트 적립',120700,'20181221160803');
INSERT INTO TB_POINT VALUES ('2017042',2,'이벤트 포인트 적립',9500, '20190405121520');
INSERT INTO TB_POINT VALUES ('2017042',3,'냉장고 구매 포인트 적립',78560,'20190612220810');
INSERT INTO TB_POINT VALUES ('2017042',4,'에어컨 구매 포인트 적립',71540,'20190703140913');
INSERT INTO TB_POINT VALUES ('2017053',1,'세탁기 구매 포인트 적립',3500,'20170410201432');
INSERT INTO TB_POINT VALUES ('2017053',2,'드라이기 구매 포인트 적립',2000,'20181216171040');
INSERT INTO TB_POINT VALUES ('2017108',1,'청소기 구매 포인트 적립',14065,'20180412205434');
INSERT INTO TB_POINT VALUES ('2017108',2,'이벤트 포인트 적립',9385,'20180702232143');
INSERT INTO TB_POINT VALUES ('2018087',1,'이벤트 포인트 적립',7800,'20180421161903');
INSERT INTO TB_POINT VALUES ('2018087',2,'냉장고 구매 포인트 적립',10900, '20181112161956');
INSERT INTO TB_POINT VALUES ('2018254',1,'등록 포인트 적립',500,'20180619230805');
INSERT INTO TB_POINT VALUES ('2018254',2,'이벤트 포인트 적립',70,'20180623170212');
INSERT INTO TB_POINT VALUES ('2019001',1,'등록 포인트 적립',500,'20190102120720');
INSERT INTO TB_POINT VALUES ('2019001',2,'믹서기 구매 포인트 적립',4600,'20190405134554');
INSERT INTO TB_POINT VALUES ('2019001',3,'드라이기 구매 포인트 적립',7820,'20190829071234');
INSERT INTO TB_POINT VALUES ('2019069',1,'이벤트 포인트 적립',8900,'20190219120712');
INSERT INTO TB_POINT VALUES ('2019069',2,'면도기 구매 포인트 적립',3200,'20190420090820');
INSERT INTO TB_POINT VALUES ('2019069',3,'전기밥솥 구매 포인트 적립',3220,'20190620071230');
INSERT INTO TB_POINT VALUES ('2019095',1,'등록 포인트 적립',500,'2019031212456');
INSERT INTO TB_POINT VALUES ('2019095',2,'이벤트 포인트 적립',390,'20190510072345');
INSERT INTO TB_POINT VALUES ('2019167',1,'드라이기 구매 포인트 적립',3200,'20190612042450');
INSERT INTO TB_POINT VALUES ('2019167',2,'전기밥솥 구매 포인트 적립',3600,'20190714133422');
INSERT INTO TB_POINT VALUES ('2019281',1,'등록 포인트 적립',500,'20190709201308');
INSERT INTO TB_POINT VALUES ('2019281',2,'청소기 구매 포인트 적립',8950,'20190710200921');
INSERT INTO TB_POINT VALUES ('2019281',3,'냉장고 구매 포인트 적립',12200,'20190712082334');
INSERT INTO TB_POINT VALUES ('2019281',4,'드라이기 구매 포인트 적립',7600,'20190721134421');
INSERT INTO TB_POINT VALUES ('2019281',5,'믹서기 구매 포인트 적립',6250,'20190724022430');

--------------------------------------------------
-- 성적 테이블
--------------------------------------------------

CREATE TABLE TB_GRADE
(
  CLASS_CD         VARCHAR(1)                 NOT NULL,   -- 반코드
  STUDENT_NO       INTEGER(2)                    NOT NULL,   -- 학생번호
  STUDENT_NM       VARCHAR(10)            NOT NULL,   -- 학생명
  KOR              INTEGER(3),                               -- 국어
  ENG              INTEGER(3),                               -- 영어
  MAT              INTEGER(3),                               -- 수학
  TOT              INTEGER(3),                               -- 합계
  AVG              FLOAT(5,1)                              -- 평균
);
CREATE UNIQUE INDEX PK_TB_GRADE ON TB_GRADE (CLASS_CD, STUDENT_NO);
ALTER TABLE TB_GRADE ADD (CONSTRAINT PK_TB_GRADE PRIMARY KEY (CLASS_CD, STUDENT_NO));

-- DELETE FROM TB_GRADE;
INSERT INTO TB_GRADE VALUES ('A',1,'강원진', 87, 94, 98, 0, 0);
INSERT INTO TB_GRADE VALUES ('A',2,'나경숙', 68, 86, 78, 0, 0);
INSERT INTO TB_GRADE VALUES ('B',1,'박승대', 90, 92, 86, 0, 0);
INSERT INTO TB_GRADE VALUES ('B',2,'서유리', 96, 100, 92, 0, 0);
INSERT INTO TB_GRADE VALUES ('B',3,'이혜옥', 98, 86, 78, 0, 0);
INSERT INTO TB_GRADE VALUES ('C',1,'김진숙', 95, 77, 95, 0, 0);
INSERT INTO TB_GRADE VALUES ('C',2,'김한길', 73, 84, 100, 0, 0);
INSERT INTO TB_GRADE VALUES ('D',1,'남궁소망', 56, 68, 78, 0, 0);
INSERT INTO TB_GRADE VALUES ('D',2,'한찬희', 94, 90, 68, 0, 0);
INSERT INTO TB_GRADE VALUES ('D',3,'이아름', 100, 87, 95, 0, 0);

--------------------------------------------------
-- 품목정보 테이블
--------------------------------------------------

CREATE TABLE TB_ITEM_INFO
(
  ITEM_CD          VARCHAR(7)                 NOT NULL,   -- 관심 품목 코드
  ITEM_NM          VARCHAR(20)                        -- 관심 품목명

);

CREATE UNIQUE INDEX PK_TB_ITEM_INFO ON TB_ITEM_INFO (ITEM_CD);
ALTER TABLE TB_ITEM_INFO ADD (CONSTRAINT PK_TB_ITEM_INFO PRIMARY KEY (ITEM_CD));

-- DELETE FROM TB_ITEM_INFO;
INSERT INTO TB_ITEM_INFO VALUES ('S01','의류/잡화');
INSERT INTO TB_ITEM_INFO VALUES ('S02','뷰티');
INSERT INTO TB_ITEM_INFO VALUES ('S03','레저/자동차');
INSERT INTO TB_ITEM_INFO VALUES ('S04','식품');
INSERT INTO TB_ITEM_INFO VALUES ('S05','생활/건강');
INSERT INTO TB_ITEM_INFO VALUES ('S06','가구/인테리어');
INSERT INTO TB_ITEM_INFO VALUES ('S07','가전');
INSERT INTO TB_ITEM_INFO VALUES ('S08','도서/취미');
INSERT INTO TB_ITEM_INFO VALUES ('S09','컴퓨터');
INSERT INTO TB_ITEM_INFO VALUES ('S10','브랜드');

--------------------------------------------------
-- 판매 테이블
--------------------------------------------------

CREATE TABLE TB_SALES
(
  SALES_DT         VARCHAR(8)                 NOT NULL,   -- 등록일
  SEQ_NO           INTEGER(5)                    NOT NULL,   -- 일련번호
  PRODUCT_NM       VARCHAR(20),                       -- 상품명
  PRICE            INTEGER(10),                              -- 단가(원)
  SALES_COUNT      INTEGER(3)                                -- 판매개수
);

CREATE UNIQUE INDEX PK_TB_SALES ON TB_SALES (SALES_DT, SEQ_NO);
ALTER TABLE TB_SALES ADD (CONSTRAINT PK_TB_SALES PRIMARY KEY (SALES_DT, SEQ_NO));

-- DELETE FROM TB_SALES;
INSERT INTO TB_SALES VALUES ('20190801',1,'노트북',1045000, 4);
INSERT INTO TB_SALES VALUES ('20190801',2,'청소기',545000, 2);
INSERT INTO TB_SALES VALUES ('20190801',3,'노트북',1021000, 6);
INSERT INTO TB_SALES VALUES ('20190802',1,'선풍기',70000, 21);
INSERT INTO TB_SALES VALUES ('20190802',2,'냉장고',1870000, 7);
INSERT INTO TB_SALES VALUES ('20190803',1,'선풍기',92000, 32);
INSERT INTO TB_SALES VALUES ('20190803',2,'냉장고',2012000, 3);
INSERT INTO TB_SALES VALUES ('20190803',3,'선풍기',70000, 15);
INSERT INTO TB_SALES VALUES ('20190803',4,'선풍기',92000, 24);
INSERT INTO TB_SALES VALUES ('20190804',1,'청소기',980000, 5);

COMMIT;

-- 연습문제 1. SELECT 조건 고객포인트 테이블의 모든 필드를 검색한다. 
select * from tb_point;

-- 연습문제 2. SELECT 조건 고객포인트 테이블에서 고객코드, 포인트내용, 포인트를 검색한다. 
select customer_cd, POINT_MEMO, point from tb_point;

-- 연습문제 3. SELECT 조건  고객포인트 테이블에서 고객코드, 포인트내용, 포인트 필드 제목을 한글로 출력한다. 
SELECT CUSTOMER_CD AS 고객코드,
	POINT_MEMO AS '포인트 내용',
    POINT AS 포인트
FROM tb_point;

-- 연습문제 4. WHERE 조건 (답지랑 다를 수 있음!)
-- 고객관리 테이블에서 누적포인트가 10,000 미만인 데이터의 고객코드, 고객명, 이메일, 누적포인트 필드를 검색한다.
select * from tb_customer;
select customer_cd, customer_nm, email, total_point
from tb_customer
where total_point < 10000;

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
       AVG = (KOR + ENG + MAT) / 3;
SELECT * FROM TB_GRADE;

select * from tb_grade;
select class_cd, student_no, student_nm, kor, eng, mat, tot, avg
from tb_grade
where class_cd = 'A' or class_cd = 'B' or (kor >= 80 and eng >= 80 and mat >= 80);

-- 연습문제 7. WHERE BETWEEN 조건
-- 고객포인트 테이블에서 등록일시가 2018년 내에 있고, 포인트가 10,000에서 50,000 포인트 범위의 데이터를 검색한다.
select * from tb_customer;
select * from tb_point;
select customer_cd, seq_no, point_memo, point, reg_dttm
from tb_point
where reg_dttm like '2018%' and point between 10000 and 50000;

-- 연습문제 8. 비교연산자
-- 고객 테이블에서 누적포인트가 20,000 이상인 1980년대 남성 고객의 고객코드, 고객명, 성별, 생년월일, 누적포인트를 검색한다.
select * from tb_customer;
select customer_cd, customer_nm, mw_flg, birth_day, total_point
from tb_customer
where total_point >= 20000 and birth_day like '198%' and MW_FLG = 'M';


-- 연습문제 9. MONTH, AND, IN
-- 고객 테이블에서 남성이면서 생년월일 중 월이 5, 6, 7월인 고객의 고객코드, 고객명, 성별, 생년월일, 누적포인트를 검색한다.
-- 답지랑 다를 수 있음
select * from tb_customer;
select customer_cd, customer_nm, mw_flg, birth_day, total_point
from tb_customer
where MW_FLG = 'M' AND (BIRTH_DAY LIKE '%05%' OR BIRTH_DAY LIKE '%06%' OR BIRTH_DAY LIKE '%07%');


-- 연습문제 10. LIKE
-- 고객 테이블에서 고객코드가 ‘2017’로 시작하면서 남성인 고객 또는 고객코드가 ‘2019’로 시작하면서 여성인 고객을 구하고, 그 중 누적포인트가 30000 이하인 데이터를 검색한다.
SELECT * FROM TB_CUSTOMER;
SELECT CUSTOMER_CD, CUSTOMER_NM, MW_FLG, BIRTH_DAY, TOTAL_POINT
FROM TB_CUSTOMER
WHERE (CUSTOMER_CD LIKE '2017%' AND MW_FLG = 'M') OR (CUSTOMER_CD LIKE '2019%' AND MW_FLG = 'W');


-- 연습문제 11. IN 연산자 
-- 품목정보 테이블에서 품목코드가 'S01’, ‘S04’, ‘S06’, ‘S10’인 데이터를 검색한다.
SELECT * FROM TB_ITEM_INFO;
SELECT ITEM_CD, ITEM_NM
FROM TB_ITEM_INFO
WHERE ITEM_CD IN ('S01', 'S04', 'S06', 'S10');


-- 연습문제 12. IN 연산자 
-- 고객포인트 테이블에서 고객코드가 ‘2017042’ 또는 ‘2018087’ 또는 '2019095' 이면서 포인트내용에 ‘구매’ 문자가 포함된 데이터를 검색한다.
SELECT * FROM TB_POINT;
SELECT CUSTOMER_CD, SEQ_NO, POINT_MEMO, POINT, REG_DTTM
FROM TB_POINT
WHERE CUSTOMER_CD IN (2017042, 2018087, 2019095);

-- 연습문제 13. ORDER BY 
-- 고객포인트 테이블에서 등록일이 '2019＇년이고 포인트내용에 '구매'가 포함된 데이터를 포인트가 큰 순서대로 검색한다.
SELECT * FROM TB_POINT;
SELECT CUSTOMER_CD, SEQ_NO, POINT_MEMO, POINT, REG_DTTM
FROM TB_POINT
WHERE REG_DTTM LIKE '2019%' AND POINT_MEMO LIKE '%구매%'
ORDER BY POINT DESC;


-- 연습문제 14. ORDER BY 
-- 성적 테이블에서 ‘B’반의 국어, 영어, 수학 점수의 합계가 높은 순으로 검색한다.
SELECT * FROM TB_GRADE;
SELECT KOR, ENG, MAT, TOT
FROM TB_GRADE
WHERE CLASS_CD = 'B'
ORDER BY TOT DESC;

-------------------------
-- 연습문제 15. GROUP BY
-- 판매 테이블에서 판매일이 ‘20190802’ 또는 ‘20190803’을 대상으로 판매일과 상품명으로 그룹화해 총판매수를 구하고 판매일과 상품명은 가나다 순으로 보인다.
SELECT * FROM TB_SALES;

SELECT SALES_DT,  PRODUCT_NM, SUM(SALES_COUNT) AS "총판매수"
FROM   TB_SALES
WHERE  SALES_DT IN ('20190802','20190803')
GROUP  BY SALES_DT, PRODUCT_NM
ORDER  BY SALES_DT, PRODUCT_NM;

-- 연습문제 16. DISTINCT 
-- 판매 테이블에서 '20190801＇에서 ‘20190802’ 기간에 판매한 상품명을 가나다 순으로 중복없이 검색한다.
SELECT * FROM TB_SALES;
SELECT distinct PRODUCT_NM
FROM TB_SALES
WHERE SALES_DT between 20190801 AND 20190802
ORDER BY PRODUCT_NM;

-- 연습문제 17. JOIN
-- 고객 테이블의 고객코드가 2019069 데이터를 고객포인트 테이블과 연관 검색하여 고객 테이블에서는 고객코드, 고객명, 성별을 검색한 후 고객포인트 테이블에서는 일련번호, 포인트내용, 포인트를 검색한다.
SELECT * FROM TB_CUSTOMER;
SELECT * FROM TB_POINT;
select C.CUSTOMER_CD, C.CUSTOMER_NM, C.MW_FLG, P.SEQ_NO, P.POINT_MEMO, P.POINT
FROM TB_CUSTOMER C
JOIN   TB_POINT P
ON     C.CUSTOMER_CD = P.CUSTOMER_CD
WHERE  C.CUSTOMER_CD = '2019069';


-- 연습문제 18. CASE
-- 고객 테이블에서 누적포인트가 1,000에서 20,000미만이면 “실버”, 20,000에서 50,000미만 이면 “골드”, 50,000이상이면 “VIP” 등급을 보이고 위 조건에 해당 없으면 “일반” 등급을 보인다.
select * from tb_customer;
select customer_cd, customer_nm, total_point, 
	case 
		when total_point between 1000 and 20000 then '실버'
        when total_point between 20000 and 50000 then '골드'
        when total_point >= 50000 then 'vip'
        else '일반'
        END as '고객 등급'
from tb_customer;

-- 연습문제 19. ROWNUM
-- 성적 테이블에서 반코드가 ‘A’ 또는 ‘C’반의 학생을 대상으로 모든 필드와 순차적인 행번호를 검색한다.
-- PDF에서 TOT AVG는 무시한다. 
select * from tb_grade;
SELECT @ROWNUM:=@ROWNUM+1 AS ROWNUM,
       GD.*
FROM   TB_GRADE GD, (SELECT @rownum:=0) TMP
WHERE  GD.CLASS_CD IN ('A','C');

-- 연습문제 20. NULL (답지랑 다를 수 있음)
-- 고객 테이블에서 고객코드가 ‘2018’ 또는 ‘2019’로 시작하고, 생일이 1990년 또는 2000년 대인 고객 중 전화번호가 설정되어 있는 데이터를 검색한다.
select * from tb_customer;
select customer_cd, customer_nm, mw_flg, birth_day, phone_number, email, total_point, reg_dttm
from tb_customer
where (customer_cd like '2018%' or customer_Cd like '2019%') and
	(birth_day like '199%' or birth_day like '200%') and
	phone_number IS NOT NULL;
