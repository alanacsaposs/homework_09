-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Depts" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Depts" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR  NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "Dept_manager" (
    "dept_no" VARCHAR  NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "Employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no","salary"
     )
);

CREATE TABLE "Titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "emp_no","title","from_date","to_date"
     )
);

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Depts" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Depts" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

--#1

SELECT e.emp_no, e.last_name, e.gender, s.salary
FROM "Employees" AS e
JOIN "Salaries" AS s
	ON e.emp_no = s.emp_no;

--#2 Employees hired in 1986

SELECT e.emp_no, e.first_name, e.last_name, e.hire_date
FROM "Employees" as e
WHERE e.hire_date LIKE '1986%';

--#3 List the manager of each department with the following information:
--department number, department name, the manager's employee number,
--last name, first name, and start and end employment dates.

SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM "Depts" d
LEFT JOIN "Dept_manager" dm
ON d.dept_no = dm.dept_no
LEFT JOIN "Employees" e
ON dm.emp_no = e.emp_no;

--#4 List the department of each employee with the following information:
-- employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Depts" d
LEFT JOIN "Dept_emp" de
ON d.dept_no = de.dept_no
LEFT JOIN "Employees" e
ON de.emp_no = e.emp_no;

--#5 List all employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name
FROM "Employees"
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--#6 List all employees in the Sales department,
--including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Depts" d
LEFT JOIN "Dept_emp" de
ON d.dept_no = de.dept_no
LEFT JOIN "Employees" e
ON de.emp_no = e.emp_no
WHERE dept_name = 'Sales';

--#7 List all employees in the Sales and Development departments,
--including their employee number, last name, first name
--and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Depts" d
LEFT JOIN "Dept_emp" de
ON d.dept_no = de.dept_no
LEFT JOIN "Employees" e
ON de.emp_no = e.emp_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

--#8 In descending order, list the frequency count of
--employee last names, i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name) AS "Last Name Count"
FROM "Employees"
GROUP BY last_name
ORDER BY "Last Name Count" DESC;




