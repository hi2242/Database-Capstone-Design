USE dbdesign;

SELECT
    first_name,
    last_name,
    salary,
    (salary * 1.10) AS increased_salary
FROM
    employee AS E
JOIN
    branch AS B ON E.branch_id = B.branch_id
WHERE
    B.branch_name = "Corporate";

SELECT
    first_name,
    last_name,
    salary
FROM
    employee
WHERE
    60000 <= salary AND salary <= 80000 AND sex = 'M';

SELECT
    first_name,
    last_name,
    branch_id,
    salary
FROM
    employee
ORDER BY
    branch_id DESC,
    salary ASC;

SELECT
    first_name,
    last_name,
    total_sales
FROM
    employee AS E
JOIN
    works_with AS W ON E.emp_id = W.emp_id
JOIN
    client AS C ON W.client_id = C.client_id
WHERE
    C.client_name = 'FedEx' AND
    E.salary >= 60000;

SELECT
    SUM(salary) AS total_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary,
    AVG(salary) AS avg_salary
FROM
    employee;

SELECT
    COUNT(*) AS total_employees
FROM
    employee;

SELECT
    branch_name,
    COUNT(*) AS employees_in_branch
FROM
    branch AS B
LEFT JOIN
    employee AS E ON B.branch_id = E.branch_id
GROUP BY
    B.branch_id;