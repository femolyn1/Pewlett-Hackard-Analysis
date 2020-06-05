# Pewlett-Hackard-Analysis
The purpose of this analysis is to determine the total number of employees who will be retiring soon and identify those who are eligible to participate in a mentorship program. This analyis is a proactive step to future proof the staff strenghth of Pewlett Hackard. As part of this exercise, we created an employee data base using SQL to determine the following:
*  Number of individuals retiring
*  Number of individulas the company will need to hire
* Number of individuals available for the mentorship role

# Analysis

## Entity Relationship Diagram:
![](https://github.com/femolyn1/Pewlett-Hackard-Analysis/blob/master/Module%207%20Challenge/ERD.png)

As shown in the above ERD, a total of nine csv files were used for this analysis. Six of them were imported to SQL  while the remaining three were created from existing data.  Before importing the existing csv dat into SQL,  we created the above ERD or map of the data base and used the information to create tables ([schema.sql](https://github.com/femolyn1/Pewlett-Hackard-Analysis/blob/master/Module%207%20Challenge/schema.sql)), in the data base.  Each table contain a description of the character type , primary and foreign keys and NOT NULL comment which prevents the creation of null values. The three additional tables that were created includes , employment information( emp_info), employment by titles ( emp_titles) and mentorship eligible (ment_eligible) table .
### Employment information (emp_info) table :  
The employment information (emp_info)  contains a list of employees who are ready for retirement and still within the payroll of the company. The input of this table as shown in the ERD includes the Employee table, Salaries table and Dep_emp table all of which were joined togehther the using inner join method.  

### Employment by title ( emp_titles) table:
This table shows the number of current employees who are about to retire by job title. It was created using 

