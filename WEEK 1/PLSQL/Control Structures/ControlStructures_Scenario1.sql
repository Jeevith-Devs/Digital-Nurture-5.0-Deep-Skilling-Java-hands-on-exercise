-- Scenario 1: Apply a 1% discount to loan interest rates for customers above 60 years old.
SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to select all customers and compute their age in years
    CURSOR c_customers IS
        SELECT CustomerID, Name, DOB, FLOOR(MONTHS_BETWEEN(SYSDATE, DOB) / 12) AS Age
        FROM Customers;
        
    v_updated_loans_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Executing Scenario 1: Interest Rate Discount for Senior Citizens (> 60 years old) ---');
    
    FOR r_cust IN c_customers LOOP
        IF r_cust.Age > 60 THEN
            -- Find all loans belonging to this senior customer
            FOR r_loan IN (SELECT LoanID, InterestRate FROM Loans WHERE CustomerID = r_cust.CustomerID) LOOP
                -- Apply a 1% discount
                UPDATE Loans
                SET InterestRate = InterestRate - 1
                WHERE LoanID = r_loan.LoanID;
                
                DBMS_OUTPUT.PUT_LINE('Discount applied to Loan ID: ' || r_loan.LoanID || 
                                     ' | Customer: ' || r_cust.Name || 
                                     ' | Age: ' || r_cust.Age || 
                                     ' | Old Rate: ' || r_loan.InterestRate || '% ' ||
                                     ' | New Rate: ' || (r_loan.InterestRate - 1) || '%');
                                     
                v_updated_loans_count := v_updated_loans_count + 1;
            END LOOP;
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Scenario 1 Completed. Total loans updated: ' || v_updated_loans_count);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
    COMMIT;
END;
/
