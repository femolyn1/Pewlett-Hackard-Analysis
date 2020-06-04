--MODULE PRACTICE :TO DETERMINE ELIGIBILITY FOR RETIREMENT- OUTPUT IS A LAUNDRY LIST
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';
--MODULE PRACTICE
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';
--MODULE PRACTICE
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';
--MODULE PRACTICE
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility-Adjusting the code to narrow down the search to those who were employed btw 1952 -1955 and hired btw 1985 to 1988
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1965-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--TO CREATE A NEW TABLE named retirement_info. 
SELECT first_name, last_name
--INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1965-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1965-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info ;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;



-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

--Rewriting above code using alias
SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date 
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;


-- Joining departments and dept_manager tables- We will rewrite code below
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

--Code to join the retirement info with the dept emp
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');


-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number using order function to order the table
SELECT COUNT(ce.emp_no), de.dept_no
--INTO employee_cnt_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--To reoder the table
SELECT * FROM salaries
ORDER BY to_date DESC;

--Adding gender column and saving into a new folder named emp_info- This gives us the list of employees within the date range
SELECT emp_no,
	first_name,
last_name,
	gender
--INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1965-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--JOINING ABOVE TO SALARY TABLE TO ADD THE TO_ DATE INFO
SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1965-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
 AND (de.to_date = '9999-01-01');
 
 
 -- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
	
--Department Retirees		

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name	
--INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);


 --Table showing sales info
 SELECT ri.emp_no,
ri.first_name,
ri.last_name,
d.dept_name
INTO Sales_info
FROM retirement_info as ri
INNER JOIN dept_emp AS de
ON (ri.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE (d.dept_name ='Sales');


 --Table showing Sales & Devpt team info
 SELECT ri.emp_no,
ri.first_name,
ri.last_name,
d.dept_name
INTO sales_dev_info
FROM retirement_info as ri
INNER JOIN dept_emp AS de
ON (ri.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales','Development');

--TABLE 1
--CHALLENGE QUESTION 1 -Table showing the number of retirement ready employees by titles
SELECT emp_info.emp_no,
emp_info.first_name,
	emp_info.last_name,
titles.title,
titles.from_date,
emp_info.salary
INTO retirement_title
FROM emp_info 
INNER JOIN titles 
ON (emp_info.emp_no = titles.emp_no)
ORDER BY emp_info.emp_no;
-- To partition the above data to remove duplicates and show only the most recent title per employee
SELECT emp_no,
 first_name,
 last_name,
 title,
 from_date,
 salary
INTO emp_titles
FROM
 (SELECT emp_no,
 first_name,
 last_name,
 title,
  from_date,
 salary, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM retirement_title
 ) tmp WHERE rn = 1
ORDER BY emp_no;
--To check table created from above query
 SELECT * FROM emp_titles;
 
---TABLE 2
--CHALLENGE QUESTION 2: A table containing number of employees who are eligible for the mentorship program
SELECT employees.emp_no,
	employees.first_name,
employees.last_name,
emp_titles.title,
	emp_titles.from_date,
	titles.to_date
INTO ment_emp
FROM employees 
INNER JOIN emp_titles
ON (employees.emp_no = emp_titles.emp_no)
INNER JOIN titles
ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY to_date DESC;
-- To partition the above data to remove duplicates
SELECT emp_no,
 first_name,
 last_name,
 title,
 from_date,
 to_date
INTO ment_eligible
FROM
 (SELECT emp_no,
 first_name,
 last_name,
 title,
  from_date,
 to_date, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
 FROM ment_emp
 ) tmp WHERE rn = 1
ORDER BY emp_no;
--To check table created from above query

SELECT * FROM ment_eligible;
