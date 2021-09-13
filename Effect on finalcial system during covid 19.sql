-- How many distinct loan types are given by CI Capital?
SELECT DISTINCT loan_type
    FROM   CI_customer;

--  How many Auto loans for two-wheelers have been given?
SELECT loan_type,
       Count(*) AS Number_of_loans
    FROM   CI_customer
  GROUP  BY loan_type;


-- Find out the customers who are less than 30 years old and have taken loans?
SELECT *
    FROM   CI_customer
  WHERE  age < 30; 


-- How many loans have been given where credit score is less than 580 by different loan types?
SELECT loan_type,
       Count(account_no) AS count_of_loans
FROM   CI_loan
WHERE  credit_score < 580
GROUP  BY loan_type;


-- Find out the average income of customers who have credit scores more than 700 and have been defaulted?
SELECT  b.if_default,
       Avg(annual_income) AS Average_annual_income
FROM    CI_customer a
       INNER JOIN CI_loan b
               ON a.account_no = b.account_no
WHERE   b.credit_score > 700
  GROUP  BY b.if_default 


-- What is the average credit score by different marital status?
SELECT  a.marital_status,
       Avg(b.credit_score) AS Average_credit_Score
FROM    CI_customer a
       INNER JOIN CI_loan b
               ON a.account_no = b.account_no
GROUP   BY a.marital_status; 


-- How many customers have more than or equal to 5 defaults by different education levels?
SELECT a.education_level,
       Sum(b.if_default) as default_count
FROM   CI_customer a
       INNER JOIN CI_loan b
              ON a.account_no = b.account_no
  GROUP  BY a.education_level
HAVING default_count >= 5 


-- Create a report that shows the relationship between the number of loans granted for each month and respective unemployment rate. It should be sorted by unemployment rate, from lowest to highest.
SELECT
 a.report_month,
       a.real_gdp_in_lakh_crore,
       a.unemp_rate,
       Count(b.account_no) AS count_of_loans
FROM  
 CI_economics a
       LEFT JOIN CI_loan b
              ON Year(a.report_month) = Year(b.start_date)
                 AND Month(a.report_month) = Month(b.start_date)
GROUP  
BY a.report_month,
          a.real_gdp_in_lakh_crore,
          A.unemp_rate
ORDER 
BY a.unemp_rate ASC


-- 
