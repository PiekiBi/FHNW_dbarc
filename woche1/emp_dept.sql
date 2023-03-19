------------------------------------------------------------------------------------------

ALTER SESSION SET NLS_LANGUAGE=AMERICAN;
ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-RR';

CREATE TABLE DEPT
(
    DEPTNO NUMBER(2) NOT NULL,
    DNAME  VARCHAR2(14),
    LOC    VARCHAR2(13),
    CONSTRAINT DEPT_PRIMARY_KEY PRIMARY KEY (DEPTNO)
);

INSERT INTO DEPT
VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT
VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT
VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT
VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE EMP
(
    EMPNO    NUMBER(4) NOT NULL,
    ENAME    VARCHAR2(10),
    JOB      VARCHAR2(9),
    MGR      NUMBER(4),
    HIREDATE DATE,
    SAL      NUMBER(7, 2),
    COMM     NUMBER(7, 2),
    DEPTNO   NUMBER(2) NOT NULL,
    CONSTRAINT EMP_PRIMARY_KEY PRIMARY KEY (EMPNO)
);


INSERT INTO EMP
VALUES (7369, 'SMITH', 'CLERK', 7902, '17-DEC-80', 800, NULL, 20);
INSERT INTO EMP
VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '20-FEB-81', 1600, 300, 30);
INSERT INTO EMP
VALUES (7521, 'WARD', 'SALESMAN', 7698, '22-FEB-81', 1250, 500, 30);
INSERT INTO EMP
VALUES (7566, 'JONES', 'MANAGER', 7839, '2-APR-81', 2975, NULL, 20);
INSERT INTO EMP
VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '28-SEP-81', 1250, 1400, 30);
INSERT INTO EMP
VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1-MAY-81', 2850, NULL, 30);
INSERT INTO EMP
VALUES (7782, 'CLARK', 'MANAGER', 7839, '9-JUN-81', 2450, NULL, 10);
INSERT INTO EMP
VALUES (7788, 'SCOTT', 'ANALYST', 7566, '09-DEC-82', 3000, NULL, 20);
INSERT INTO EMP
VALUES (7839, 'KING', 'PRESIDENT', NULL, '17-NOV-81', 5000, NULL, 10);
INSERT INTO EMP
VALUES (7844, 'TURNER', 'SALESMAN', 7698, '8-SEP-81', 1500, 0, 30);
INSERT INTO EMP
VALUES (7876, 'ADAMS', 'CLERK', 7788, '12-JAN-83', 1100, NULL, 20);
INSERT INTO EMP
VALUES (7900, 'JAMES', 'CLERK', 7698, '3-DEC-81', 950, NULL, 30);
INSERT INTO EMP
VALUES (7902, 'FORD', 'ANALYST', 7566, '3-DEC-81', 3000, NULL, 20);
INSERT INTO EMP
VALUES (7934, 'MILLER', 'CLERK', 7782, '23-JAN-82', 1300, NULL, 10);

COMMIT;

ALTER TABLE emp
    ADD CONSTRAINT emp_self_key FOREIGN KEY (mgr) REFERENCES emp;
ALTER TABLE emp
    ADD CONSTRAINT EMP_FOREIGN_KEY FOREIGN KEY (DEPTNO) REFERENCES DEPT (DEPTNO);
