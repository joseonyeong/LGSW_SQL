use mssqldb;
SET GLOBAL local_infile = 1; -- local file 불러오기 활성화

CREATE TABLE customer (
    mem_no      INT PRIMARY KEY,
    last_name   VARCHAR(10),
    first_name  VARCHAR(20),
    gd          CHAR(1),
    birth_dt    DATE,
    entr_dt     DATE,
    grade       VARCHAR(10),
    sign_up_ch  VARCHAR(2)
);
SELECT * FROM customer;

CREATE TABLE sales (
    InvoiceNo    VARCHAR(20),
    StockCode    VARCHAR(20),
    Description  VARCHAR(100),
    Quantity     INT,
    InvoiceDate  DATETIME,
    UnitPrice    DECIMAL(10,2),
    CustomerID   VARCHAR(20),
    Country      VARCHAR(50)
);
SELECT * FROM sales;

use classicmodels;
CREATE TABLE sales(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);
SELECT * FROM sales;