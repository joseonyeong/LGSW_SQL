-- MySQL 급여 관리 시스템 트리거

set sql_safe_updates = 0; -- 수정 삭제 가능

-- DB 생성 및 초기화
drop database if exists trigger_demo; -- 스키마 중복 시 삭제
create SCHEMA `trigger_demo` ; -- 스키마 생성
use trigger_demo;

-- 직원 테이블 생성
create table employees(
	id int auto_increment primary key,
    name varchar(100) not null,
    salary decimal(10,2) not null, -- 소수점 두자리까지 지원
    department varchar(50) not null,
    created_at timestamp default current_timestamp -- 데이터 생성 시간
);

-- 급여 변경 이력 테이블 -> 기존 데이터와 섞이는 것을 방지하기 위해
-- 외래키 참조 해서 테이블 생성
create table salary_logs(
	id int auto_increment primary key,
    employee_id int, -- employees 테이블의 id 참조
	old_salary decimal(10,2),
    new_salary decimal(10,2),
    change_date timestamp default current_timestamp,
    -- foreign key는 참조를 했을 경우 써주는 것이 좋음 -> 데이터 무결성 유지
    foreign key (employee_id) references employees(id) on delete cascade -- 해당 직원 삭제 시 연쇄적으로 삭제
);

-- 삭제된 직원 테이블
create table employee_deletion_logs(
	id int auto_increment primary key,
    employee_id int,  			-- id 참조
    employee_name varchar(100), -- name 참조
    salary decimal(10,2), 		-- 삭제되기 직전 직원 급여
    department varchar(50), 	-- 부서명
    deleted_at timestamp default current_timestamp -- 삭제 시간
);

-- 트리거 생성
/*
* before update : employees 테이블에서 수정이 일어나기 발동
* 조건문 : 급여 salary가 변경되었을 때만 작동
* 급여가 변경된 경우 salary_logs 테이블에 직원의 id, 이전 급여, 새로운 급여를 기록
*/
/*
	delimiter // -- 트리거 안에 세미콜론이 있음
		create trigger trigger_name
		before update on table_name
		for each row -- 업데이트를 행단위로 하고 있음. 업데이트되는 각 행을 실행
		begin
			# code
		end
	//
*/

-- 급여 변경 트리거
DELIMITER //
-- employees 테이블에서 급여가 변경되기 직전에 작동하는 트리거 생성
CREATE TRIGGER before_salary_update
BEFORE UPDATE ON employees      -- employees 테이블의 UPDATE 전에 작동
FOR EACH ROW                    -- 업데이트되는 각 행(row)마다 실행
BEGIN
    -- 급여가 변경된 경우에만 동작
    IF NEW.salary != OLD.salary THEN
        -- 변경 전 급여(OLD.salary)와 변경 후 급여(NEW.salary)를 salary_logs 테이블에 기록
        INSERT INTO salary_logs (employee_id, old_salary, new_salary)
        VALUES (OLD.id, OLD.salary, NEW.salary);
    END IF;
END//
-- 다시 구분자(DELIMITER)를 기본값(;)으로 복원
DELIMITER ;


-- 3.2 직원 삭제 트리거
/*
- BEFORE DELETE: employees 테이블에서 직원이 삭제되기 직전에 발동.
- OLD: 삭제되기 전의 데이터를 참조.
- employee_deletion_logs 테이블에 삭제되는 직원의 ID, 이름, 급여, 부서 정보를 기록한다.
- deleted_at 컬럼은 테이블 설정상 자동으로 현재 시간이 들어가므로 별도로 INSERT하지 않아도 된다. 
*/

DELIMITER //

-- employees 테이블에서 삭제되기 전에 작동하는 트리거 생성
CREATE TRIGGER before_employee_delete
BEFORE DELETE ON employees       -- employees 테이블의 DELETE 전에 실행
FOR EACH ROW                     -- 삭제되는 각 행(row)마다 실행
BEGIN
    -- 삭제될 직원의 정보를 employee_deletion_logs 테이블에 기록
    INSERT INTO employee_deletion_logs 
    (employee_id, employee_name, salary, department)
    VALUES 
    (OLD.id, OLD.name, OLD.salary, OLD.department);
END//
DELIMITER ;

-- 트리거 목록 확인
show triggers;
-- 트리거 삭제
drop trigger if exists before_salary_update;

-- 데이터 추가
insert into employees (name, salary, department) values
	('홍길동',33333, 'ㄷ우ㅜ'),
    ('아이',455,'아'),
    ('ㅡ맥',5566666,'ㅎㅎ');
    
-- 데이터 조회
select * from employees;
select * from salary_logs;
select * from employee_deletion_logs;

-- 데이터 수정
-- 급여 인상
update employees
set salary = salary * 1.1
where department = 'ㅎㅎ';

-- 부서 이동
update employees
set department = 'sales'
where name = '홍길동';

-- 데이터 삭제
-- 직원 삭제
delete from employees
where name = '홍길동';