DROP TABLE retirement_titles;

-- Get all the employees who are retiring using birthdate BETWEEN '1952-01-01' AND '1955-12-31'
SELECT emp.emp_no, emp.first_name, emp.last_name, tit.title, tit.from_date, tit.to_date
INTO retirement_titles
From employees as emp
INNER JOIN titles as tit on emp.emp_no = tit.emp_no
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

SELECT*FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows from the retirement_titles table and keep most recent title
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_title
FROM retirement_titles
ORDER BY emp_no, to_date DESC;


SELECT*FROM unique_title;


-- Create Retiring_Titles table that counts the number of employees retiring by their title.
SELECT COUNT(emp_no), ut.title 
INTO Retiring_Titles
FROM unique_title as ut
GROUP BY ut.title;
SELECT*FROM Retiring_Titles
ORDER BY count DESC;

--Mentorship Eligibility table for people who are still working at the company and born BETWEEN '1965-01-01' AND '1965-12-31'
SELECT DISTINCT ON(emp.emp_no)emp.emp_no, 
		emp.first_name,
		emp.last_name, 
		emp.birth_date,
		de.from_date,
		de.to_date,
		tit.title
INTO mentorship_eligibilty
From employees as emp
INNER JOIN titles as tit on emp.emp_no = tit.emp_no
INNER JOIN dept_emp as de on emp.emp_no = de.emp_no
WHERE (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31' AND de.to_date='9999-01-01')
ORDER BY emp.emp_no ASC;

SELECT*FROM mentorship_eligibilty;

