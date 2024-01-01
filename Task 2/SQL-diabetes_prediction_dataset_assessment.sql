			   SELECT * FROM psyliq.diabetes_prediction;

			   alter table diabetes_prediction rename column employeename to patientname;

/* Q(1).*/     select patientname, age from diabetes_prediction; 

/* Q(2).*/     select patientname from diabetes_prediction where gender= "female" and age>40;

/* Q(3).*/     select avg(bmi) from diabetes_prediction;

/* Q(4).*/     select patientname, blood_glucose_level from diabetes_prediction order by blood_glucose_level Desc;

/* Q(5).*/     select patientname from diabetes_prediction where hypertension= 1 and diabetes= 1;

/* Q(6).*/     select count(patientname) from diabetes_prediction where heart_disease=1;

/* Q(7).*/     SELECT smoking_history,
                         COUNT(CASE WHEN smoking_history IN ('current', 'former', 'ever') THEN 1 ELSE NULL END) as smoker_count,
                         COUNT(CASE WHEN smoking_history IN ('never', 'No Info', 'not current') THEN 1 ELSE NULL END) as nonsmoker_count
                         FROM diabetes_prediction
						  GROUP BY smoking_history;

/* Q(8).*/     select Patient_id, bmi from diabetes_prediction where bmi> (select avg(bmi) from diabetes_prediction);

/* Q(9).*/     select patientname, HbA1c_level from diabetes_prediction order by HbA1c_level desc limit 1;

/* Q(9).*/     select patientname, HbA1c_level from diabetes_prediction order by HbA1c_level asc limit 1;

/* Q(10).*/     SELECT patientname, DATEDIFF(CURRENT_DATE, age) / 365 as age_in_years FROM diabetes_prediction;

/* Q(11).*/     select patientname, gender, blood_glucose_level, dense_rank() over(partition by gender order by blood_glucose_level desc) as rnk from diabetes_prediction;

/* Q(12).*/     update diabetes_prediction set smoking_history  = 'Ex-smoker.' where age > 50;

/* Q(13).*/     insert into diabetes_prediction values("varun smith","pt100101","male", 50, 0, 0, "No Info", 30.06, 2, 100,0);

/* Q(14).*/      DELETE FROM diabetes_prediction WHERE heart_disease = 1;


/* Q(15).*/         SELECT patientname
					FROM diabetes_prediction
					WHERE hypertension = 1

					EXCEPT

					SELECT patientname
					FROM diabetes_prediction
					WHERE diabetes = 1;

/* Q(16).*/     	ALTER TABLE diabetes_prediction MODIFY COLUMN patient_id varchar(255);
					ALTER TABLE diabetes_prediction ADD CONSTRAINT unique_patient_id UNIQUE (patient_id);

/* Q(17).*/         CREATE VIEW patient_info_view AS SELECT Patient_id, age, bmi FROM diabetes_prediction;
					SELECT * FROM patient_info_view;

/* Q(18). To reduce data redundancy and improve data integrity in the diabetes_prediction table, we can consider the following improvements to the database schema:

Normalization:
Break down the table into smaller, related tables to eliminate redundancy. Identify functional dependencies and create separate tables for them. Common normalization steps include:

Patient Information Table:
Create a separate table for patient information with the primary key as patient_id. This table would include columns such as patient_id, patientname, gender, age, and any other patient-specific details.*/

/* Q(19). Optimizing the performance of SQL queries involves various strategies, and the specific optimizations depend on factors like the size of the dataset, the types of queries we're running, and the database engine we're using. Here are some general tips to optimize the performance of SQL queries on our diabetes_prediction dataset:

Indexes:

Ensure that the columns used in WHERE clauses, JOIN conditions, and ORDER BY clauses are indexed. Indexing can significantly speed up data retrieval.
In your case, it seems like the patient_id column would be a good candidate for indexing, especially if it is frequently used in WHERE or JOIN conditions.
sql
Copy code
CREATE INDEX idx_patient_id ON diabetes_prediction (patient_id);
Adjust the index creation according to your actual usage patterns.

Proper Data Types:

Use appropriate and efficient data types for your columns. For example, use INT for numerical identifiers and VARCHAR for variable-length strings.
Normalize the Data:

Ensure that your database is normalized to minimize redundancy and improve data integrity. This might involve breaking down tables into smaller, related tables to reduce data duplication.
Use Aggregate Functions Wisely:

Avoid using SELECT * when you don't need all columns. Select only the columns you need.
Minimize the use of aggregate functions (SUM, AVG, COUNT, etc.) if they are not essential.
Optimize Queries:

Review and optimize your queries. Use the EXPLAIN statement in MySQL to analyze the execution plan of a SELECT query and identify areas for improvement.
sql
Copy code
EXPLAIN SELECT * FROM diabetes_prediction WHERE patient_id = 'your_value';
Partitioning:

Consider partitioning large tables to improve query performance, especially if you have a significant amount of data.
Caching:

Use caching mechanisms to store the results of frequently executed queries. This can be particularly effective for read-heavy applications.
Regular Maintenance:

Regularly update statistics and perform database maintenance tasks, such as rebuilding indexes, to keep the database in good health.
Query and Index Design:

Ensure that your queries and index designs are aligned with your application's specific needs. Avoid over-indexing or creating indexes that are seldom used.
Hardware and Server Optimization:

Ensure that your database server has sufficient resources, and consider optimizing server-level configurations based on the characteristics of your workload.*/



