CREATE TABLE dept(
    deptno INT,
    dname VARCHAR(14),
    loc VARCHAR(13),
       constraint pk_dept primary key (deptno)
);
CREATE TABLE emp(
    empno INT,
    ename VARCHAR(10),
    job VARCHAR(9),
    mgr INT,
    hiredate DATE,
    sal DECIMAL(7,2),
    comm DECIMAL(7,2),
    deptno INT,
   constraint pk_emp primary key (empno),
   constraint fk_deptno foreign key (deptno) references dept (deptno)
);
INSERT INTO dept(deptno, dname, loc) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

INSERT INTO emp VALUES
(7839, 'KANE', 'PRESIDENT', null, '1981-11-17', 5000, null, 10),
(7698, 'STEFAN', 'MANAGER', 7839,'1981-05-01', 2850, null, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, null, 10),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02',2975, null, 20),
(7788, 'SCOTT', 'ANALYST', 7566, '1981-04-19',3000, null, 20),
(7902, 'DAMON', 'ANALYST', 7566, '1981-03-12', 3000, null, 20),
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, null, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
(7521, 'SCOTT', 'SALESMAN', 7698, '1981-02-22',1250, 500, 30),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28',1250, 1400, 30),
(7844, 'TRAVER', 'SALESMAN', 7698, '1981-09-08',1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1987-05-23',1100, null, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-03-12',950, null, 30),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23',1300, null, 10)

SELECT * FROM emp WHERE job IN ('MANAGER', 'CLERK');

SELECT * FROM emp
WHERE deptno IN (20, 30);

SELECT * FROM emp
WHERE YEAR(hiredate) = 1981;

SELECT ename FROM emp
WHERE sal = (SELECT MIN(sal) FROM emp);

SELECT ename FROM emp
WHERE ename LIKE 'D%N';

SELECT * FROM emp
WHERE YEAR(hiredate) IN (1981, 1982);

SELECT * FROM emp
WHERE job = 'CLERK' AND sal < 1500;

SELECT * FROM emp
WHERE job IN ('MANAGER', 'SALESMAN') AND sal > 1500;

SELECT ename FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp));

SELECT * FROM emp
WHERE ename LIKE 'M%N';

SELECT * FROM emp
WHERE deptno NOT IN (10, 30);

SELECT job, AVG(sal) AS avg_salary
FROM emp
GROUP BY job
HAVING AVG(sal) < 2000;

SELECT SUM(sal+coalesce(comm,0)) as total_salary from emp;

SELECT SUM(sal) AS total_salary
FROM emp
WHERE deptno IN (10, 20);

SELECT deptno, COUNT(*) AS num_employees
FROM emp
GROUP BY deptno;
SELECT AVG(sal) AS avg_salary
FROM emp
WHERE deptno IN (10, 20);

SELECT deptno, job
FROM emp
GROUP BY deptno, job;

SELECT job, SUM(sal) AS total_salary
FROM emp
GROUP BY job
HAVING SUM(sal) > 7000;

SELECT ename, hiredate, DATE_ADD(hiredate, INTERVAL 90 DAY) AS probation_end_date
FROM emp;

SELECT ename, hiredate, DATE_ADD(hiredate, INTERVAL 6 MONTH) AS probation_end_date
FROM emp
WHERE YEAR(hiredate) = 1981;

SELECT ename, empno, DATEDIFF(CURDATE(), hiredate) AS days_of_employment
FROM emp
WHERE empno IN (7499, 7566);

SELECT ename, DATE_FORMAT(hiredate, '%D of %M, %Y') AS formatted_hiredate
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp);

SELECT ename, DATE_FORMAT(hiredate, '%D %M of %Y, %H:%i:%s') AS formatted_hiredate
FROM emp;

select ename, sal, sal*0.1+sal as "Salary With 10% Hike" from emp;

SELECT ename, sal, sal * 0.05 + sal AS "Salary With 5% Hike"
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp);

SELECT ename, sal, sal * 0.5 AS 'Salary 50%'
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp);

CREATE TABLE emp179 AS
SELECT * FROM emp;
select* from emp179;

ALTER TABLE emp179
DROP COLUMN address;

ALTER TABLE emp179
ADD CONSTRAINT chk_salary CHECK (sal > 700);

ALTER TABLE emp179
DROP CONSTRAINT chk_salary;

ALTER TABLE emp179
DROP COLUMN address;
SELECT emp.empno, emp.ename, emp.job, dept.dname, dept.loc
FROM emp
JOIN dept ON emp.deptno = dept.deptno
WHERE emp.ename IN ('JOHNS', 'SMITH');

SELECT emp.ename, emp.sal, dept.loc
FROM emp
JOIN dept ON emp.deptno = dept.deptno
WHERE emp.hiredate = (SELECT MIN(hiredate) FROM emp);

SELECT emp.empno, emp.job, emp.sal, dept.dname
FROM emp
JOIN dept ON emp.deptno = dept.deptno
WHERE emp.deptno IN (10, 20);


SELECT emp.empno, emp.ename, emp.job, emp.deptno, dept.dname, dept.loc
FROM emp
JOIN dept ON emp.deptno = dept.deptno
WHERE YEAR(emp.hiredate) IN (1981, 1982);

Create table DEPOSITOR(CUST_ID INT ,
ACC_NO INT);

INSERT INTO DEPOSITOR VALUES
(1, 101),
(2, 301),
(5, 501),
(6, 701);

CREATE table BORROWER(CUST_ID INT,
LOAN_NO INT);

INSERT INTO BORROWER VALUES
(1, 101),
(4, 301),
(8, 501),
(6, 701);
 
DROP table DEPOSITOR;

SELECT* FROM DEPOSITOR;

SELECT* FROM BORROWER;

SELECT CUST_ID, ACC_NO, NULL AS LOAN_NO
FROM DEPOSITOR
UNION
SELECT CUST_ID, NULL AS ACC_NO, LOAN_NO
FROM BORROWER;

SELECT D.CUST_ID, D.ACC_NO, B.LOAN_NO
FROM DEPOSITOR D
INNER JOIN BORROWER B
ON D.CUST_ID = B.CUST_ID;

SELECT D.CUST_ID, D.ACC_NO
FROM DEPOSITOR D
LEFT JOIN BORROWER B
ON D.CUST_ID = B.CUST_ID
WHERE B.CUST_ID IS NULL;

SELECT B.CUST_ID, B.LOAN_NO
FROM BORROWER B
LEFT JOIN DEPOSITOR D
ON B.CUST_ID = D.CUST_ID
WHERE D.CUST_ID IS NULL;

select ename from emp where length(ename)>5

