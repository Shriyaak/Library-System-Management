SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employee;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;

--Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books(isbn,book_title,category,rental_price,status,author,publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')
SELECT COUNT(*) FROM books 
-- inserts the record at the end of the table 

--Task 2: Update an Existing Member's Address
UPDATE members 
SET member_address = '125 Main Street'
WHERE  member_id = 'C101' ;
SELECT * FROM members 

--Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table
DELETE FROM issued_status
WHERE   issued_id =   'IS121';

--Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT issued_book_name FROM issued_status
WHERE issued_emp_id = 'E101'

--Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT issued_emp_id , COUNT(issued_id) 
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(issued_id) > 1 ;

--CTAS (Create Table As Select)
--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
CREATE TABLE book_count
AS
SELECT b.isbn, b.book_title, COUNT(ist.issued_id) AS no_issue
FROM books AS b 
JOIN 
issued_status AS ist 
ON ist.issued_book_isbn = b.isbn 
GROUP BY 1 ,2 

SELECT * FROM book_count

-- Task 7. Retrieve All Books in a Specific Category:

SELECT * FROM books 
WHERE category = 'History'

-- Task 8: Find Total Rental Income by Category:

SELECT  b.category, SUM(b.rental_price) as rental_income , COUNT(*) 
FROM books as b 
JOIN issued_status as ist
ON
b.isbn = ist.issued_book_isbn
GROUP BY b.category

--Task 9: List Members Who Registered in the Last 180 Days:
SELECT * FROM members 
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days' 

--Task 10: List Employees with Their Branch Manager's Name and their branch details:
SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.position,
    e1.salary,
    b.*,
    e2.emp_name as manager
FROM employee as e1
JOIN 
branch as b
ON e1.branch_id = b.branch_id    
JOIN
employee as e2
ON e2.emp_id = b.manager_id


