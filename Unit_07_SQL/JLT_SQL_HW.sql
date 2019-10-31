-- List the following details of each employee: employee number, last name, first name, gender, and salary.
--to do this, first double check that there isn't more than one salary listed per employee
SELECT 
	* 
FROM 
	(
		SELECT 
			*
			,ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY to_date) AS RowNum
		FROM 
			salaries
	) a
WHERE 
	a.RowNum > 1;


--knowing there is a 1:1 employnum to salary we can do a simple join 
SELECT 
	e.emp_no
	,e.first_name
	,e.last_name
	,e.gender
	,s.salary
FROM 
	employees AS e
LEFT JOIN 
	salaries AS s
	ON e.emp_no = s.emp_no;


	
-- List employees who were hired in 1986.
SELECT 
	* 
FROM 
	(
		SELECT 
			*
			,EXTRACT(YEAR from hire_date) AS hire_year
		FROM 
			employees
	) a
WHERE 
	a.hire_year = '1986';


-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
--these are the CURRENT managers (end date has not occurred)

SELECT 
	* 
FROM 
	dept_manager AS m
LEFT JOIN 
	titles AS t
	ON m.emp_no = t.emp_no


SELECT 
	d.dept_no
	,d.dept_name
	,m.emp_no
	,e.last_name
	,e.first_name
	,m.from_date
	,m.to_date
FROM 
	departments AS d
INNER JOIN 
	dept_manager AS m 
	ON d.dept_no = m.dept_no
LEFT JOIN 
	employees AS e
	ON e.emp_no = m.emp_no
LEFT JOIN 
	titles AS t
	ON t.emp_no = e.emp_no
WHERE 
	m.to_date = '9999-01-01'
AND t.title = 'Manager'
	
	
-- these are all managers ever with their start and end dates listed
SELECT 
	d.dept_no
	,d.dept_name
	,m.emp_no
	,e.last_name
	,e.first_name
	,m.from_date
	,m.to_date
FROM 
	departments AS d
INNER JOIN 
	dept_manager AS m 
	ON d.dept_no = m.dept_no
LEFT JOIN 
	employees AS e
	ON e.emp_no = m.emp_no;


-- List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT 
	e.emp_no
	,e.first_name
	,e.last_name
	,d.dept_name
FROM 
	employees AS e
LEFT JOIN 
	dept_emp AS de
	ON e.emp_no = de.emp_no
LEFT JOIN 
	departments AS d
	ON d.dept_no = de.dept_no;


-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT 
	* 
FROM 
	employees 
WHERE 
	first_name = 'Hercules'
AND last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT 
	e.emp_no
	,e.last_name
	,e.first_name
	,d.dept_name
FROM 
	employees AS e
LEFT JOIN 
	dept_emp AS de
	ON de.emp_no = e.emp_no
LEFT JOIN 
	departments AS d
	ON d.dept_no = de.dept_no
WHERE 
	d.dept_name = 'Sales';


-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT 
	e.emp_no
	,e.last_name
	,e.first_name
	,d.dept_name
FROM 
	employees AS e
LEFT JOIN 
	dept_emp AS de
	ON de.emp_no = e.emp_no
LEFT JOIN 
	departments AS d
	ON d.dept_no = de.dept_no
WHERE 
	d.dept_name IN ('Sales', 'Development');
	

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT DISTINCT
	a.last_name
	,MAX(a.ln_count) AS ttl_ln_count
FROM 
	(
		SELECT 
			* 
			,ROW_NUMBER() OVER(PARTITION BY last_name ORDER BY emp_no) AS ln_count
		FROM 
			employees 
	) a
GROUP BY 
	a.last_name
ORDER BY 
	ttl_ln_count DESC;



--APRIL FOOLS!!! 
select 
    * 
from 
    employees 
where 
    emp_no = '499942';