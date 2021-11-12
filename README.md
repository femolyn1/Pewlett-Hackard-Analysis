# Pewlett-Hackard-Analysis
The purpose of this analysis is to determine the total number of employees who will be retiring soon and identify those who are eligible to participate in a mentorship program. This analyis is a proactive step to future proof the staff strength of Pewlett Hackard. As part of this exercise, I created an employee data base using SQL and was able to determine the following:
*  Number of individuals retiring
*  Number of individuals being hired
* Number of individuals available for the mentorship role

# Analysis

## Entity Relationship Diagram:
![](https://github.com/femolyn1/Pewlett-Hackard-Analysis/blob/master/Module%207%20Challenge/ERD.png)

As shown in the above ERD, a total of nine csv files were used for this analysis. Six of them were imported to SQL  while the remaining three were created from existing data.  Before importing the existing csv data into SQL,  we created the above ERD or map of the data base and used the information to create tables ([schema.sql](https://github.com/femolyn1/Pewlett-Hackard-Analysis/blob/master/Module%207%20Challenge/schema.sql)).  Each table contain a description of the character type , primary and foreign keys and NOT NULL comment which prevents the creation of null values. The three additional tables that were created includes , employment information( emp_info), employment by titles ( emp_titles) and mentorship eligible (ment_eligible) table .

### Employment information (emp_info) table :  
The employment information (emp_info)  contains a list of employees who are ready for retirement and still within the payroll of the company. The input of this table as shown in the ERD includes the Employee table, Salaries table and Dep_emp table, all of which were joined together using an inner join method.  

### Employment by title ( emp_titles) table:
This table shows the number of current employees who are about to retire by job title. It was created using an inner join to connect the employment information table and titles table. Duplicate information was removed using partitioning method. After removing the duplicates, a total of 108,958 employees was observed. It is worth noting that we filtered the birth date range to fall between January 1952 and December 1965 and the hire date was also adjusted to fall between January 1985 and December 1988 for the purpose of this calculation. The birth date was expanded to December 1965 to determine the number of employees among the list who will be eligible for the mentorship program.  This information provides an insight to the number of employees within the company whose positions will soon be vacant.

### Mentorship Eligible ( ment_eligible):
As shown in the above ERD, this table was created using two inner joins to link three tables. The tables joined includes, Employees, emp_titles and titles tables. The table was also partitioned to remove duplicates. A count of the rows revealed a total of 691 mentorship eligible employees. 

### Number of individuals the company will need to hire
A total of 131,166 positions will soon be available within the company. This information was obtained by creating a [code](https://github.com/femolyn1/Pewlett-Hackard-Analysis/blob/08f6403c899ac9cc43bed9f9628fc5bb34b670c7/Module%207%20Challenge/queries_challenge.sql#L96) which links the employees and department employee (dep_emp) table using an inner join with the to_date filtered to 9999-01-01 to ensure all individuals captured are currently employed in the company. A count of the total employees obtained from this analysis shows a total of 240,124 individuals. This number was then deducted from the total employees who are ready for retirement, 108,958 (obtained from emp_titles table). 

# Summary
We observed the following from the analysis:
* Total of 108,958 current employees are ready for retirement. 
* Total of 131,166 individuals will need to be hired.
* Total of 691 individuals are available for the mentorship role.

## Observation
The obtained number of people being hired is very subjective because there is no data that shows the category of employment. Some employees might be on coop-placement with the hope of moving on to full employment with the company  while some might be working on contract basis and may no longer be with the company in the immediate future. Without these information, the available employment information is distorted and does not allow us to determine have a true picture of the number of individuals the company would need to hire.

## Suggestion
The company's needs to update the available employment data to relect the employment type or category. With this information, we can write a [code](https://github.com/femolyn1/Pewlett-Hackard-Analysis/blob/08f6403c899ac9cc43bed9f9628fc5bb34b670c7/Module%207%20Challenge/queries_challenge.sql#L96) similar to the one used in this analysis and groupby type or category of employment. This will provide a more insight on the number of individuals the company would need to hire.


