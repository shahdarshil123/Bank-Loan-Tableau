USE bankLoanDB;

SELECT * FROM FinancialLoan;

--Find total loan application
SELECT COUNT(*) AS "Total Loan Applications" FROM FinancialLoan;

--Find the Current Month Loan Applications
SELECT COUNT(id) FROM FinancialLoan 
WHERE MONTH(issue_date) = (SELECT MONTH(MAX(issue_date)) AS "Current Month" FROM FinancialLoan)
AND YEAR(issue_date) = (SELECT YEAR(MAX(issue_date)) AS "Current Year" FROM FinancialLoan);

-- Total Loan Amount issued
SELECT SUM(loan_amount) AS "Total loan amount funded" FROM FinancialLoan;

-- Total Loan Amount issued in current month
SELECT SUM(loan_amount) AS "Total loan amount funded" FROM FinancialLoan
WHERE MONTH(issue_date) = (SELECT MONTH(MAX(issue_date)) AS "Current Month" FROM FinancialLoan)
AND YEAR(issue_date) = (SELECT YEAR(MAX(issue_date)) AS "Current Year" FROM FinancialLoan);

-- Total Loan Amount issued in previous month
SELECT SUM(loan_amount) AS "Total loan amount funded" FROM FinancialLoan
WHERE MONTH(issue_date) = (SELECT MONTH(MAX(issue_date))-1 AS "Previous Month" FROM FinancialLoan)
AND YEAR(issue_date) = (SELECT YEAR(MAX(issue_date)) AS "Current Year" FROM FinancialLoan);

--Total Payment Received
SELECT SUM(total_payment) AS "Total payment received" FROM FinancialLoan;


--Total Payment Received in Current Month
SELECT SUM(total_payment) AS "Total payment received in current month" FROM FinancialLoan
WHERE MONTH(issue_date) = (SELECT MONTH(MAX(issue_date)) AS "Current Month" FROM FinancialLoan)
AND YEAR(issue_date) = (SELECT YEAR(MAX(issue_date)) AS "Current Year" FROM FinancialLoan);

--Total Payment Received in Previous Month
SELECT SUM(total_payment) AS "Total payment received in previous month" FROM FinancialLoan
WHERE MONTH(issue_date) = (SELECT MONTH(MAX(issue_date))-1 AS "Previous Month" FROM FinancialLoan)
AND YEAR(issue_date) = (SELECT YEAR(MAX(issue_date)) AS "Current Year" FROM FinancialLoan);

--Find different loan status
SELECT DISTINCT(loan_status) FROM FinancialLoan;

--Classify the applicant based on loan status
SELECT 
	(CASE WHEN loan_status = 'Fully Paid' or loan_status = 'Current' THEN 'Good Loan' ELSE 'Bad Loan' END) AS "Loan Type"
FROM FinancialLoan;

--Find the count of Good Loan Application
SELECT COUNT(id) AS "Good loan applications" FROM FinancialLoan WHERE loan_status = 'Fully Paid' or loan_status = 'Current';

--Find Good Loan Funded Amount
SELECT SUM(loan_amount) AS "Good loan amount funded" FROM FinancialLoan WHERE loan_status = 'Fully Paid' or loan_status = 'Current';

--Find Good Loan Funded Amount
SELECT SUM(total_payment) AS "Good loan amount received" FROM FinancialLoan WHERE loan_status = 'Fully Paid' or loan_status = 'Current';

--Find Bad Loan Funded Amount
SELECT SUM(loan_amount) AS "Bad loan amount funded" FROM FinancialLoan WHERE loan_status = 'Charged Off' ;

--Find Good Loan Funded Amount
SELECT SUM(total_payment) AS "Bad loan amount received" FROM FinancialLoan WHERE loan_status = 'Charged Off' ;

SELECT 
	loan_status,
	COUNT(id) AS "Total loan applications",
	SUM(loan_amount) AS "Total amount funded",
	SUM(total_payment) AS "Total amount received",
	ROUND(AVG(int_rate),4)*100 AS "Average interest rate"
FROM FinancialLoan
GROUP BY loan_status;






