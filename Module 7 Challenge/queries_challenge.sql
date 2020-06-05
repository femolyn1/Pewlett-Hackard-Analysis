--EMPLOYMENT INFORMATION TABLE (emp_info)..INPUT DATA FOR CHALLENGE QUESTION
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

SELECT * FROM emp_info;
 
 

--CHALLENGE QUESTION 1 -Table showing the number of retirement ready employees by titles
SELECT ei.emp_no,
ei.first_name,
	ei.last_name,
tt.title,
tt.from_date,
ei.salary
INTO retirement_title
FROM emp_info as ei
INNER JOIN titles as tt 
ON (ei.emp_no = tt.emp_no)
ORDER BY ei.emp_no;
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
 

--CHALLENGE QUESTION 2: A table containing number of employees who are eligible for the mentorship program
SELECT e.emp_no,
	e.first_name,
e.last_name,
et.title,
	et.from_date,
	tt.to_date
INTO ment_emp
FROM employees as e 
INNER JOIN emp_titles as et
ON (e.emp_no = et.emp_no)
INNER JOIN titles as tt
ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
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


---CODE TO DETERMINE THE NUMBER OF PEOPLE BEING HIRED
SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
     e.hire_date,
	s.salary
	FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01');