/*
1.	Покажите всех менеджеров, которые имеют в подчинении больше 6-ти сотрудников.
*/
SELECT e2.MANAGER_ID, COUNT(1)
FROM EMPLOYEES e1
	JOIN EMPLOYEES e2 ON e1.EMPLOYEE_ID = e2.MANAGER_ID
GROUP BY e2.MANAGER_ID
HAVING COUNT(1) > 6;


/*
2.	Вывести min и max зарплату с вычетом commission_pct для каждого департамента. (commission_pct на базе указывается в процентах).
*/
SELECT d.DEPARTMENT_NAME, MIN(SALARY - (SALARY * COMMISSION_PCT / 100)) AS [Min],
	   MAX(SALARY - (SALARY * COMMISSION_PCT / 100)) AS [Max]
FROM EMPLOYESS e
	JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
GROUP BY d.DEPARTMENT_NAME;


/*
3.	Вывести только регион, где работают больше всего людей.
*/
SELECT TOP 1 WITH TIES
FROM(
SELECT REGION_NAME, COUNT(1)
FROM REGIONS r
	JOIN LOCATIONS l ON r.REGION_ID = l.COUNTRY_ID
	JOIN DEPARTMERNTS d ON l.LOCATION_ID = d.LOCATION_ID
	JOIN EMPLOYEES e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY REGION_NAME
ORDER BY COUNT(1) DESC
)


/*
4.	Найдите разницу в процентах между средней зп по каждому департаменту от общей средней (по всем департаментам).
*/
SELECT DEPARTMENT_NAME, (AVG(SALARY) OVER (PARTITION BY DEPARTMENT_ID) / AVG(SALARY) OVER ()) * 100 AS [Difference]
FROM EMPLOYEES e
	JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID


/*
5.	Найдите людей, кто проработал больше, чем 10 лет в одном департаменте.
*/
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID, DATEDIFF(YEAR, START_DATE, ISNULL(END_DATE, GETDATE())) AS PeriodOfWork
FROM EMPLOYESS e
	JOIN JOB_HISTORY jh ON e.EMPLOYEE_ID = jh.EMPLOYEE_ID
WHERE PeriodOfWork > 10;


/*
6.	Найдите людей, кто занимает 5-10 место по размеру зарплаты.
*/
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM
(
SELECT FIRST_NAME, LAST_NAME, SALARY, DENSE_RANK() OVER (ODER BY SALARY DESC) AS SalaryRank
FROM EMPLOYEES
) t
WHERE SalaryRank BETWEEN 5 and 10